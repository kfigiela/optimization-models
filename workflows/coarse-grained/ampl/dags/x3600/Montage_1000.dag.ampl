set TASK = T_MontagemProjectPP T_MontagemDiffFit T_MontagemConcatFit T_MontagemBgModel T_MontagemBackground T_MontagemImgTbl T_MontagemAdd T_MontagemShrink T_MontagemJPEG;
set LAYER = L_MontagemProjectPP L_MontagemDiffFit L_MontagemConcatFit L_MontagemBgModel L_MontagemBackground L_MontagemImgTbl L_MontagemAdd L_MontagemShrink L_MontagemJPEG;

set LAYER_TASK[L_MontagemProjectPP] = T_MontagemProjectPP;
set LAYER_TASK[L_MontagemDiffFit] = T_MontagemDiffFit;
set LAYER_TASK[L_MontagemConcatFit] = T_MontagemConcatFit;
set LAYER_TASK[L_MontagemBgModel] = T_MontagemBgModel;
set LAYER_TASK[L_MontagemBackground] = T_MontagemBackground;
set LAYER_TASK[L_MontagemImgTbl] = T_MontagemImgTbl;
set LAYER_TASK[L_MontagemAdd] = T_MontagemAdd;
set LAYER_TASK[L_MontagemShrink] = T_MontagemShrink;
set LAYER_TASK[L_MontagemJPEG] = T_MontagemJPEG;

param: 
                           task_count exec_time data_size_in data_size_out :=
     T_MontagemProjectPP          166     13.58        4.027         7.937
       T_MontagemDiffFit          662     10.59       15.838         0.176
     T_MontagemConcatFit            1     52.96        0.194         0.133
       T_MontagemBgModel            1     89.12        0.159         0.008
    T_MontagemBackground          166     10.74        7.945         7.937
        T_MontagemImgTbl            1     65.91     1317.526         0.064
           T_MontagemAdd            1     99.53        0.065       581.302
        T_MontagemShrink            1     22.25      581.302        11.631
          T_MontagemJPEG            1      2.52       11.631         1.357
;
