set TASK = T_avianfluAutoDock T_avianfluPrepareGPF T_avianfluAutoGrid T_avianfluAutoDock;
set LAYER = L_avianfluAutoDock_avianfluPrepareGPF_avianfluAutoGrid L_avianfluAutoDock;

set LAYER_TASK[L_avianfluAutoDock_avianfluPrepareGPF_avianfluAutoGrid] = T_avianfluAutoDock T_avianfluPrepareGPF T_avianfluAutoGrid;
set LAYER_TASK[L_avianfluAutoDock] = T_avianfluAutoDock;

param: 
                           task_count exec_time data_size_in data_size_out :=
      T_avianfluAutoDock         1999   1800.00        7.695         0.195
    T_avianfluPrepareGPF            1    120.00        0.146         0.001
      T_avianfluAutoGrid            1    240.00        0.147     15000.195
      T_avianfluAutoDock            1   1800.00        7.695         0.195
;
