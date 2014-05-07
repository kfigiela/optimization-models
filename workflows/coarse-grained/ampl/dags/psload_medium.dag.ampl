set TASK = T_psloadPreprocessCSV T_psloadLoadCSV T_psloadValidateLoadDB T_psloadEnd T_psloadValidateLoadDB;
set LAYER = L_psloadPreprocessCSV_psloadLoadCSV_psloadValidateLoadDB_psloadEnd L_psloadValidateLoadDB;

set LAYER_TASK[L_psloadPreprocessCSV_psloadLoadCSV_psloadValidateLoadDB_psloadEnd] = T_psloadPreprocessCSV T_psloadLoadCSV T_psloadValidateLoadDB T_psloadEnd;
set LAYER_TASK[L_psloadValidateLoadDB] = T_psloadValidateLoadDB;

param: 
                           task_count exec_time data_size_in data_size_out :=
    T_psloadPreprocessCSV          100     0.001389   150.360000   150.360000
         T_psloadLoadCSV          305     0.008333    49.298361    49.298361
    T_psloadValidateLoadDB           99     0.001389   150.717172   100.000000
             T_psloadEnd            1     0.002778 10000.000000     0.000000
    T_psloadValidateLoadDB            1     0.001389   115.000000   100.000000
;
