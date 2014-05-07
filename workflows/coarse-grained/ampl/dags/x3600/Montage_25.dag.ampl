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
     T_MontagemProjectPP            5     13.59        4.027         7.948
       T_MontagemDiffFit            9     10.60       15.012         0.390
     T_MontagemConcatFit            1      0.72        0.390         0.002
       T_MontagemBgModel            1      1.42        0.003         0.000
    T_MontagemBackground            5     10.71        7.948         7.948
        T_MontagemImgTbl            1      1.39       39.742         0.002
           T_MontagemAdd            1      3.03        0.002        88.710
        T_MontagemShrink            1      3.86       88.710         1.775
          T_MontagemJPEG            1      0.45        1.775         0.195
;
