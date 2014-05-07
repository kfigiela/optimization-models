set TASK = T_avianfluAutoDock T_avianfluPrepareGPF T_avianfluAutoGrid T_avianfluAutoDock;
set LAYER = L_avianfluAutoDock_avianfluPrepareGPF_avianfluAutoGrid L_avianfluAutoDock;

set LAYER_TASK[L_avianfluAutoDock_avianfluPrepareGPF_avianfluAutoGrid] = T_avianfluAutoDock T_avianfluPrepareGPF T_avianfluAutoGrid;
set LAYER_TASK[L_avianfluAutoDock] = T_avianfluAutoDock;

param: 
                           task_count exec_time data_size_in data_size_out :=
      T_avianfluAutoDock         1999     0.500000     7.695313     0.195313
    T_avianfluPrepareGPF            1     0.033333     0.146484     0.000977
      T_avianfluAutoGrid            1     0.066667     0.147461 15000.195313
      T_avianfluAutoDock            1     0.500000     7.695313     0.195313
;
