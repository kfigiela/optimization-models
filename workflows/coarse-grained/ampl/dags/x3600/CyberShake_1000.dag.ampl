set TASK = T_CyberShakeExtractSGT T_CyberShakeSeismogramSynthesis T_CyberShakePeakValCalcOkaya T_CyberShakeZipSeis T_CyberShakeZipPSA;
set LAYER = L_CyberShakeExtractSGT L_CyberShakeSeismogramSynthesis L_CyberShakePeakValCalcOkaya_CyberShakeZipSeis L_CyberShakeZipPSA;

set LAYER_TASK[L_CyberShakeExtractSGT] = T_CyberShakeExtractSGT;
set LAYER_TASK[L_CyberShakeSeismogramSynthesis] = T_CyberShakeSeismogramSynthesis;
set LAYER_TASK[L_CyberShakePeakValCalcOkaya_CyberShakeZipSeis] = T_CyberShakePeakValCalcOkaya T_CyberShakeZipSeis;
set LAYER_TASK[L_CyberShakeZipPSA] = T_CyberShakeZipPSA;

param: 
                           task_count exec_time data_size_in data_size_out :=
    T_CyberShakeExtractSGT            4    126.12    38148.328       548.683
    T_CyberShakeSeismogramSynthesis          497     43.65      551.616         0.023
    T_CyberShakePeakValCalcOkaya          497      1.08        0.023         0.000
     T_CyberShakeZipSeis            1      9.38        0.000         2.040
      T_CyberShakeZipPSA            1      3.81        0.000         0.010
;
