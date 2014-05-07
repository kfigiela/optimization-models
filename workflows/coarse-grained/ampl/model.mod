# vim: syntax=ampl

set INSTANCE;                                              # instance types
set STORAGE;                                               # cloud storage options (S3, CloudFiles)
set PROVIDER;                                              # cloud providers
set PROVIDER_INSTANCES {p in PROVIDER} within INSTANCE;    # set of instance types per provider
set STORAGE_LOCAL {STORAGE} within PROVIDER; 

set LAYER;
set TASK;
set LAYER_TASK {LAYER} within TASK;

param provider_max_machines {PROVIDER} >= 0 integer;       # VM limit per provider (Amazon has default limit of 20 machnies)
param instance_max_machines {INSTANCE} > 0 integer;        # copy of previous, for easier access

param instance_price {INSTANCE} >= 0;                      # price per instance hour
param ccu {INSTANCE} >= 0;                                 # CloudHarmony Compute Units, similar to Amazon ECU, results of benchmarks from http://blog.cloudharmony.com/2010/05/what-is-ecu-cpu-benchmarking-in-cloud.html
                                               
param request_price >= 0;                                  # price per data request
param instance_transfer_price_out {INSTANCE} >= 0;         # price per MB of data transfer outbound             
param instance_transfer_price_in  {INSTANCE} >= 0;         # price per MB of data transfer inbound
param storage_transfer_price_out  {STORAGE}  >= 0;         # price per MB of data transfer outbound             
param storage_transfer_price_in   {STORAGE}  >= 0;         # price per MB of data transfer inbound
                                               
param local {INSTANCE, STORAGE} binary >= 0;               # matrix showing which transfers are local (0) and which non-local (1)
param transfer_rate {INSTANCE, STORAGE} >= 0;
                                               
param exec_time {TASK} >= 0;                               # average task execution time on m1.small instance in hours                                              
param task_count {TASK} > 0 integer;                       # total number of tasks
param data_size_in {TASK} >= 0;                            # data size per task
param data_size_out {TASK} >= 0;                           # data size per task
param workflow_deadline > 0 integer;                       # maximum duration of computing
param storage symbolic;                                    # which storage is used

# precalculated parameters
param transfer_time {t in TASK, i in INSTANCE, s in STORAGE} := (data_size_in[t]+data_size_out[t])/(transfer_rate[i,s] * 3600);
param unit_time     {t in TASK, i in INSTANCE, s in STORAGE} := max(exec_time[t] / ccu[i], transfer_time[t,i,storage]); # time required for task to compute on instance i
param transfer_cost {t in TASK, i in INSTANCE, s in STORAGE} := (data_size_out[t] * (instance_transfer_price_out[i]+storage_transfer_price_in[s]) + data_size_in[t] * (storage_transfer_price_out[s]+instance_transfer_price_in[i])) * local[i,s];


var InstanceActive {t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)} binary;
var InstanceHours  {t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)} integer >= 0 <= workflow_deadline;
var InstanceTasks  {t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)} integer >= 0 <= task_count[t];
var LayerDeadline  {l in LAYER}                                                           integer >= 1 <= workflow_deadline;
var LayerTime      {l in LAYER}                                                                   >= 0 <= workflow_deadline;

minimize TotalCost: 
  sum { t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1) } (instance_price[i] * InstanceHours[t,i,idx] + (request_price + transfer_cost[t,i,storage])*InstanceTasks[t,i,idx]);

subject to
  keep_layer_deadlines_sum_under_workflow_deadline: 
    sum { l in LAYER} LayerTime[l] <= workflow_deadline;
  keep_layer_time {l in LAYER}:
    LayerTime[l] <= LayerDeadline[l];

  keep_layer_time_2 {l in LAYER}:
    LayerDeadline[l] <= LayerTime[l] + 1;
  
  bind_instance_active_with_instance_hours_1 {t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)}: 
    InstanceHours[t,i,idx] >= InstanceActive[t,i,idx];
  bind_instance_active_with_instance_hours_2 {t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)}: 
    InstanceHours[t,i,idx] <= workflow_deadline*InstanceActive[t,i,idx];
  
  bind_instance_active_with_instance_tasks_1 {t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)}: 
    InstanceTasks[t,i,idx] >= InstanceActive[t,i,idx];
  bind_instance_active_with_instance_tasks_2 {t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)}: 
    InstanceTasks[t,i,idx] <= task_count[t] * InstanceActive[t,i,idx];

  keep_layer_deadline {l in LAYER, t in LAYER_TASK[l], i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)}:
    InstanceHours[t,i,idx] <= LayerDeadline[l];

  keep_layer_deadline_2 {l in LAYER, t in LAYER_TASK[l], i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)}:
    InstanceTasks[t,i,idx]*unit_time[t,i,storage] <= LayerTime[l];
 
  is_there_enough_processing_power_to_do_the_tasks {t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)}:
    InstanceHours[t,i,idx] >= InstanceTasks[t,i,idx]*unit_time[t,i,storage];
  but_not_more {t in TASK, i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)}:
    InstanceHours[t,i,idx] <= InstanceTasks[t,i,idx]*unit_time[t,i,storage] + 1;

  enough_power {t in TASK}:
    sum {i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)} InstanceTasks[t,i,idx] = task_count[t];
   
  discard_symmetric_solutions_1 {t in TASK, i in INSTANCE, idx in 1 .. (instance_max_machines[i] - 1)}:
    InstanceHours[t,i,idx] <= InstanceHours[t,i,idx-1]; 
  discard_symmetric_solutions_2 {t in TASK, i in INSTANCE, idx in 1 .. (instance_max_machines[i] - 1)}:
    InstanceActive[t,i,idx] <= InstanceActive[t,i,idx-1];
  discard_symmetric_solutions_3 {t in TASK, i in INSTANCE, idx in 1 .. (instance_max_machines[i] - 1)}:
    InstanceTasks[t,i,idx] <= InstanceTasks[t,i,idx-1];

  force_provider_instance_limit {l in LAYER, p in PROVIDER}: 
    sum {i in PROVIDER_INSTANCES[p], t in LAYER_TASK[l], idx in 0 .. (instance_max_machines[i] - 1)} InstanceActive[t,i,idx] <= provider_max_machines[p];


       
