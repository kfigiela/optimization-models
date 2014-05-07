set TASK = T_psloadPreprocessCSV T_psloadLoadCSV T_psloadValidateLoadDB T_psloadEnd T_psloadLoadCSV;
set LAYER = L_psloadPreprocessCSV_psloadLoadCSV_psloadValidateLoadDB_psloadEnd L_psloadLoadCSV;

set LAYER_TASK[L_psloadPreprocessCSV_psloadLoadCSV_psloadValidateLoadDB_psloadEnd] = T_psloadPreprocessCSV T_psloadLoadCSV T_psloadValidateLoadDB T_psloadEnd;
set LAYER_TASK[L_psloadLoadCSV] = T_psloadLoadCSV;

param: 
                           task_count exec_time data_size_in data_size_out :=
    T_psloadPreprocessCSV         1000     0.001389   150.706000   150.706000
         T_psloadLoadCSV         2982     0.008333    50.526157    50.526157
    T_psloadValidateLoadDB         1000     0.001389   150.706000   100.000000
             T_psloadEnd            1     0.002778 100000.000000     0.000000
         T_psloadLoadCSV            1     0.008333    37.000000    37.000000
;
