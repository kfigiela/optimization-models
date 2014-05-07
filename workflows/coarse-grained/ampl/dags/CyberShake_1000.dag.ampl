set TASK = T_CyberShakeExtractSGT T_CyberShakeSeismogramSynthesis T_CyberShakePeakValCalcOkaya T_CyberShakeZipSeis T_CyberShakeZipPSA;
set LAYER = L_CyberShakeExtractSGT L_CyberShakeSeismogramSynthesis L_CyberShakePeakValCalcOkaya_CyberShakeZipSeis L_CyberShakeZipPSA;

set LAYER_TASK[L_CyberShakeExtractSGT] = T_CyberShakeExtractSGT;
set LAYER_TASK[L_CyberShakeSeismogramSynthesis] = T_CyberShakeSeismogramSynthesis;
set LAYER_TASK[L_CyberShakePeakValCalcOkaya_CyberShakeZipSeis] = T_CyberShakePeakValCalcOkaya T_CyberShakeZipSeis;
set LAYER_TASK[L_CyberShakeZipPSA] = T_CyberShakeZipPSA;

param: 
                           task_count exec_time data_size_in data_size_out :=
    T_CyberShakeExtractSGT            4     0.035033 38148.328007   548.682736
    T_CyberShakeSeismogramSynthesis          497     0.012126   551.615843     0.022888
    T_CyberShakePeakValCalcOkaya          497     0.000301     0.022888     0.000206
     T_CyberShakeZipSeis            1     0.002606     0.000000     2.040338
      T_CyberShakeZipPSA            1     0.001058     0.000000     0.010117
;
