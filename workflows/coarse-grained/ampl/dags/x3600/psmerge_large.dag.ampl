set TASK = T_psmergeUpdateProductionDB T_psmergeColdDBLoadDBPreprocess T_psmergeValidateMerge T_psmergeMergeDB T_psmergeMergeDB;
set LAYER = L_psmergeUpdateProductionDB_psmergeColdDBLoadDBPreprocess_psmergeValidateMerge_psmergeMergeDB L_psmergeMergeDB;

set LAYER_TASK[L_psmergeUpdateProductionDB_psmergeColdDBLoadDBPreprocess_psmergeValidateMerge_psmergeMergeDB] = T_psmergeUpdateProductionDB T_psmergeColdDBLoadDBPreprocess T_psmergeValidateMerge T_psmergeMergeDB;
set LAYER_TASK[L_psmergeMergeDB] = T_psmergeMergeDB;

param: 
                           task_count exec_time data_size_in data_size_out :=
    T_psmergeUpdateProductionDB            1   3600.00 34057748.480         0.000
    T_psmergeColdDBLoadDBPreprocess           16    300.00      200.000     43887.500
    T_psmergeValidateMerge           16     60.00 920387584.000   2128609.280
        T_psmergeMergeDB         7021  10800.00  2097252.000   2097152.000
        T_psmergeMergeDB            1  10800.00  2097252.000   2097152.000
;
