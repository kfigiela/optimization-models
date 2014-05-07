# vim: syntax=ampl sw=2

option solver cplex;
option log_file run.log;

option cplex_options "display=1 time=900 threads=8";

model model.mod;

data;
include infrastructure.dat;
include workflow.dat;

let storage            := $storage;
let workflow_deadline  := num($deadline) ;


# calculate needed sets
let {p in PROVIDER, i in PROVIDER_INSTANCES[p]} instance_max_machines[i] := provider_max_machines[p];
let {p in PROVIDER, i in PROVIDER_INSTANCES[p], s in STORAGE} local[i,s] := if p in STORAGE_LOCAL[s] then 0 else 1;


solve;

var Runtime;
var RealRuntime;

let Runtime := sum {l in LAYER} LayerDeadline[l];
let RealRuntime := sum {l in LAYER} max {t in LAYER_TASK[l], i in INSTANCE, idx in 0 .. (instance_max_machines[i] - 1)} InstanceTasks[t,i,idx]*unit_time[t,i,storage];
 
for {l in LAYER} {
  for {t in LAYER_TASK[l]} {
    printf "[%s][%s]: \n", l,t;
    for {i in INSTANCE} {
      if InstanceActive[t,i,0] > 0 then {
        printf "%10s [%2d]\t", i, sum {idx in 0 .. (instance_max_machines[i]-1)} InstanceActive[t,i,idx];
        for {idx in 0 .. (instance_max_machines[i]-1)} {
          if InstanceHours[t,i,idx] > 0 then {
            printf "%2d/%2d\t", InstanceHours[t,i,idx], InstanceTasks[t,i,idx];
          }
        }
        printf "\n";
      }
    }
  }
}

display solve_message;
printf "--- YAML ---\n";
printf "cost: %.3f\n", TotalCost;
printf "deadline: %d\n", workflow_deadline;
printf "runtime: %d\n", Runtime;
printf "real_runtime: %5.2f\n", RealRuntime;
printf "storage: %s\n", storage;
printf "layers:\n";
for {l in LAYER} {
  printf " - name: %s\n", l;
  printf "   deadline: %d\n", LayerDeadline[l];
  printf "   instances:\n", l;
  for {t in LAYER_TASK[l]} {
    for {i in INSTANCE} {
      for {idx in 0 .. (instance_max_machines[i]-1): InstanceActive[t,i,idx] > 0} {
        printf "     - type: %s\n", i;
        printf "       hours: %d\n", InstanceHours[t,i,idx];
        printf "       tasks: %d\n", InstanceTasks[t,i,idx];
        printf "       cost: %5.2f\n", (instance_price[i] * InstanceHours[t,i,idx] + (request_price + transfer_cost[t,i,storage])*InstanceTasks[t,i,idx]);
      }    
    }
  }
}

printf "--- /YAML ---\n";
display LayerDeadline;
display LayerTime;


