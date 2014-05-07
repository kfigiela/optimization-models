set TASK = T_psmergeUpdateProductionDB T_psmergeColdDBLoadDBPreprocess T_psmergeValidateMerge T_psmergeMergeDB T_psmergeMergeDB;
set LAYER = L_psmergeUpdateProductionDB_psmergeColdDBLoadDBPreprocess_psmergeValidateMerge_psmergeMergeDB L_psmergeMergeDB;

set LAYER_TASK[L_psmergeUpdateProductionDB_psmergeColdDBLoadDBPreprocess_psmergeValidateMerge_psmergeMergeDB] = T_psmergeUpdateProductionDB T_psmergeColdDBLoadDBPreprocess T_psmergeValidateMerge T_psmergeMergeDB;
set LAYER_TASK[L_psmergeMergeDB] = T_psmergeMergeDB;

param: 
                           task_count exec_time data_size_in data_size_out :=
    T_psmergeUpdateProductionDB            1   3600.00  2128609.280         0.000
    T_psmergeColdDBLoadDBPreprocess            1    300.00      200.000      9300.000
    T_psmergeValidateMerge            1     60.00 195035136.000   2128609.280
        T_psmergeMergeDB           92  10800.00  2097252.000   2097152.000
        T_psmergeMergeDB            1  10800.00  2097252.000   2097152.000
;
