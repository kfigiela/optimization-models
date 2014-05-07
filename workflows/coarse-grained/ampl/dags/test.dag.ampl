set TASK = T_preprocess T_process T_postprocess;
set LAYER = L_preprocess L_process L_postprocess;

set LAYER_TASK[L_preprocess] = T_preprocess;
set LAYER_TASK[L_process] = T_process;
set LAYER_TASK[L_postprocess] = T_postprocess;

param: 
                           task_count exec_time data_size_in data_size_out :=
            T_preprocess            1     0.002778     0.000191     0.000019
               T_process            2     0.002778     0.000000     0.000000
           T_postprocess            1     0.000278     0.000000     0.000000
;
