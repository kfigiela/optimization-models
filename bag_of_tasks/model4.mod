set INSTANCE;                                   # instance types
set STORAGE;                                    # cloud storage options (S3, CloudFiles)
set PROVIDER;                                   # cloud providers
set PROVIDER_INSTANCES {p in PROVIDER} within INSTANCE; # set of instance types per provider

set STORAGE_LOCAL {STORAGE} within PROVIDER; # 

param provider_max_machines {PROVIDER} >= 0 integer;    # VM limit per provider (Amazon has default limit of 20 machnies)
param instance_max_machines {INSTANCE} > 0 integer;     # copy of previous, for easier access

param instance_price {INSTANCE} >= 0;           # price per instance hour
param ccu {INSTANCE} >= 0;                       # CloudHarmony Compute Units, similar to Amazon ECU, results of benchmarks from http://blog.cloudharmony.com/2010/05/what-is-ecu-cpu-benchmarking-in-cloud.html
                                               
param request_price >= 0;                       # price per data request
param instance_transfer_price_out {INSTANCE} >= 0 ;      # price per MB of data transfer outbound             
param instance_transfer_price_in {INSTANCE} >= 0;         # price per MB of data transfer inbound
param storage_transfer_price_out {STORAGE} >= 0 ;      # price per MB of data transfer outbound             
param storage_transfer_price_in {STORAGE} >= 0;         # price per MB of data transfer inbound
                                               
param local {INSTANCE, STORAGE} binary >= 0;    # matrix showing which transfers are local (0) and which non-local (1)
param transfer_rate {INSTANCE, STORAGE} >= 0;
                                               
param exec_time >= 0;                            # average task execution time on m1.small instance in hours                                              
param total_tasks > 0 integer;                           # total number of tasks
param data_size_in >= 0;                             # data size per task
param data_size_out >= 0;                             # data size per task
param deadline > 0 integer;                     # maximum duration of computing
param DataAssignment {STORAGE} binary;

# precalculated parameters
# param unit_time {i in INSTANCE, s in STORAGE} :=  exec_time / ccu[i] + (data_size_in+data_size_out)/(transfer_rate[i,s] * 3600); # time required for task to compute on instance i
param transfer_time {i in INSTANCE, s in STORAGE} := (data_size_in+data_size_out)/(transfer_rate[i,s] * 3600);
param unit_time {i in INSTANCE, s in STORAGE} :=  max(exec_time / ccu[i], transfer_time[i,s]); # time required for task to compute on instance i
param transfer_cost {i in INSTANCE, j in STORAGE} := (data_size_out * (instance_transfer_price_out[i]+storage_transfer_price_in[j]) + data_size_in * (storage_transfer_price_out[j]+instance_transfer_price_in[i])) * local[i,j];
param instance_deadline {i in INSTANCE, s in STORAGE} := ceil(floor((deadline-transfer_time[i,s])/unit_time[i,s])*unit_time[i,s]); # For debugging, not involved in actual computation
param tasks_per_deadline {i in INSTANCE, s in STORAGE} := floor((deadline-transfer_time[i,s])/unit_time[i,s]); # For debugging, not involved in actual computation
param time_quantum {i in INSTANCE, s in STORAGE} := ceil(unit_time[i,s]); # required for tasks which are longer than 1 hour
param tasks_per_time_quantum {i in INSTANCE, s in STORAGE} := floor(time_quantum[i,s]/unit_time[i,s]); 

var TaskAssignment {i in INSTANCE} integer >= 0  <= total_tasks;  # how many tasks we assign to instance
# var DataAssignment {j in STORAGE} binary;                         # which storage provider to use
var NumberInstances {i in INSTANCE} integer >= 0 <= instance_max_machines[i];  # number of required instances to perform tasks which will run for (deadline) hours
var TailTasksHours {i in INSTANCE} integer >= 0 <= (deadline-1);                                                             # we may have some leftover tasks, we may need to run this instance for additional N hours
var HasTail {INSTANCE} binary; # := sgn(TailTasksHours[i]), required for MaxInstances constraint - using functions in constraints breaks calculation

minimize Total_Cost: 
  sum {i in INSTANCE} (
                ((sum {s in STORAGE} DataAssignment[s]*(instance_deadline[i,s]*NumberInstances[i])) + TailTasksHours[i]) * instance_price[i]
                + TaskAssignment[i]*(request_price + (sum {s in STORAGE} DataAssignment[s] * transfer_cost[i,s] ))
              ); 


subject to 
  TaskAssignmentLowerBound {i in INSTANCE}:
    TaskAssignment[i] >= sum {s in STORAGE} (NumberInstances[i] * tasks_per_deadline[i,s]) * DataAssignment[s];
  TaskAssignmentUpperBound {i in INSTANCE}:
    TaskAssignment[i] <= sum {s in STORAGE} (NumberInstances[i] * tasks_per_deadline[i,s] + max(0, tasks_per_deadline[i,s] - 1)) * DataAssignment[s]; # -1 because of weak inequality required for bonmin to work
  TailTasksHoursLowerBound {i in INSTANCE}:
    TailTasksHours[i] >= sum {s in STORAGE} (TaskAssignment[i] - NumberInstances[i] * tasks_per_deadline[i,s]) * unit_time[i,s] * DataAssignment[s];
  TailTasksHoursUpperBound {i in INSTANCE}:
    TailTasksHours[i] <= sum {s in STORAGE} (TaskAssignment[i] - NumberInstances[i] * tasks_per_deadline[i,s] + tasks_per_time_quantum[i,s]) * unit_time[i,s] * DataAssignment[s];

  SumTasks: 
    sum {i in INSTANCE} TaskAssignment[i] = total_tasks;
  # Data: 
  #   sum {j in STORAGE}  DataAssignment[j] = 1; # SOA1 type constraint, only one storage provider

  SetHasTailLowerBound {i in INSTANCE}:
    TailTasksHours[i] >= HasTail[i];  # if TailTasksHours == 0 then HasTail also == 0, if TailTasksHours >= 1 then HasTail may be 1
  SetHasTailUpperBound {i in INSTANCE}:
    TailTasksHours[i] <= max((deadline-1),0)*HasTail[i];  # 100000000 is virtual infinity, this trick makes HasTail and TailTasksHours binding work

  MaxInstances {p in PROVIDER}: 
   sum {i in PROVIDER_INSTANCES[p]} (HasTail[i] + NumberInstances[i]) <= provider_max_machines[p];
