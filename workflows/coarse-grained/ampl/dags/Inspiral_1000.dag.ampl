set TASK = T_LIGOTmpltBank T_LIGOInspiral T_LIGOThinca T_LIGOTrigBank T_LIGOInspiral T_LIGOThinca;
set LAYER = L_LIGOTmpltBank L_LIGOInspiral L_LIGOThinca L_LIGOTrigBank L_LIGOInspiral L_LIGOThinca;

set LAYER_TASK[L_LIGOTmpltBank] = T_LIGOTmpltBank;
set LAYER_TASK[L_LIGOInspiral] = T_LIGOInspiral;
set LAYER_TASK[L_LIGOThinca] = T_LIGOThinca;
set LAYER_TASK[L_LIGOTrigBank] = T_LIGOTrigBank;
set LAYER_TASK[L_LIGOInspiral] = T_LIGOInspiral;
set LAYER_TASK[L_LIGOThinca] = T_LIGOThinca;

param: 
                           task_count exec_time data_size_in data_size_out :=
         T_LIGOTmpltBank          229     0.005038    38.633425     0.941778
          T_LIGOInspiral          229     0.128505    41.884451     0.299083
            T_LIGOThinca           20     0.001468     3.747379     0.034646
          T_LIGOTrigBank          251     0.001422     0.032521     0.012297
          T_LIGOInspiral          251     0.128498    40.955594     0.295695
            T_LIGOThinca           20     0.001507     3.710975     0.034689
;
