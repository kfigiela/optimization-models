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
     T_MontagemProjectPP          166     0.003771     4.026779     7.936747
       T_MontagemDiffFit          662     0.002941    15.838316     0.176435
     T_MontagemConcatFit            1     0.014711     0.193646     0.132549
       T_MontagemBgModel            1     0.024756     0.159075     0.008418
    T_MontagemBackground          166     0.002983     7.945165     7.936747
        T_MontagemImgTbl            1     0.018308  1317.526491     0.064308
           T_MontagemAdd            1     0.027647     0.064598   581.301682
        T_MontagemShrink            1     0.006181   581.301682    11.630686
          T_MontagemJPEG            1     0.000700    11.630686     1.356996
;
