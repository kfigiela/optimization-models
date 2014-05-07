set TASK = T_psloadPreprocessCSV T_psloadLoadCSV T_psloadValidateLoadDB T_psloadEnd T_psloadLoadCSV;
set LAYER = L_psloadPreprocessCSV_psloadLoadCSV_psloadValidateLoadDB_psloadEnd L_psloadLoadCSV;

set LAYER_TASK[L_psloadPreprocessCSV_psloadLoadCSV_psloadValidateLoadDB_psloadEnd] = T_psloadPreprocessCSV T_psloadLoadCSV T_psloadValidateLoadDB T_psloadEnd;
set LAYER_TASK[L_psloadLoadCSV] = T_psloadLoadCSV;

param: 
                           task_count exec_time data_size_in data_size_out :=
    T_psloadPreprocessCSV         1000      5.00      150.706       150.706
         T_psloadLoadCSV         2982     30.00       50.526        50.526
    T_psloadValidateLoadDB         1000      5.00      150.706       100.000
             T_psloadEnd            1     10.00   100000.000         0.000
         T_psloadLoadCSV            1     30.00       37.000        37.000
;
