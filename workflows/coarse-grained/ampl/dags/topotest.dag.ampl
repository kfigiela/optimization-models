set TASK = T_task T_task T_task;
set LAYER = L_task L_task L_task;

set LAYER_TASK[L_task] = T_task;
set LAYER_TASK[L_task] = T_task;
set LAYER_TASK[L_task] = T_task;

param: 
                           task_count exec_time data_size_in data_size_out :=
                  T_task            2     0.000278     0.000000     0.000000
                  T_task            2     0.000278     0.000000     0.000000
                  T_task            1     0.000278     0.000000     0.000000
;
