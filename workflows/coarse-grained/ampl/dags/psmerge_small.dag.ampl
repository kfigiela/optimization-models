set TASK = T_psmergeUpdateProductionDB T_psmergeColdDBLoadDBPreprocess T_psmergeValidateMerge T_psmergeMergeDB T_psmergeMergeDB;
set LAYER = L_psmergeUpdateProductionDB_psmergeColdDBLoadDBPreprocess_psmergeValidateMerge_psmergeMergeDB L_psmergeMergeDB;

set LAYER_TASK[L_psmergeUpdateProductionDB_psmergeColdDBLoadDBPreprocess_psmergeValidateMerge_psmergeMergeDB] = T_psmergeUpdateProductionDB T_psmergeColdDBLoadDBPreprocess T_psmergeValidateMerge T_psmergeMergeDB;
set LAYER_TASK[L_psmergeMergeDB] = T_psmergeMergeDB;

param: 
                           task_count exec_time data_size_in data_size_out :=
    T_psmergeUpdateProductionDB            1     1.000000 2128609.280000     0.000000
    T_psmergeColdDBLoadDBPreprocess            1     0.083333   200.000000  9300.000000
    T_psmergeValidateMerge            1     0.016667 195035136.000000 2128609.280000
        T_psmergeMergeDB           92     3.000000 2097252.000000 2097152.000000
        T_psmergeMergeDB            1     3.000000 2097252.000000 2097152.000000
;
