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
     T_MontagemProjectPP            5     0.003776     4.026779     7.948205
       T_MontagemDiffFit            9     0.002944    15.012199     0.389744
     T_MontagemConcatFit            1     0.000200     0.389977     0.001801
       T_MontagemBgModel            1     0.000394     0.002600     0.000253
    T_MontagemBackground            5     0.002975     7.948458     7.948205
        T_MontagemImgTbl            1     0.000386    39.741824     0.001525
           T_MontagemAdd            1     0.000842     0.001815    88.710049
        T_MontagemShrink            1     0.001072    88.710049     1.774911
          T_MontagemJPEG            1     0.000125     1.774911     0.195366
;
