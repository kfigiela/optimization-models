set TASK = T_SIPHTFindterm T_SIPHTPatser T_SIPHTBlast T_SIPHTRNAMotif T_SIPHTTransterm T_SIPHTPatser_concate T_SIPHTSRNA T_SIPHTBlast_QRNA T_SIPHTBlast_candidate T_SIPHTFFN_Parse T_SIPHTBlast_paralogues T_SIPHTBlast_synteny T_SIPHTSRNA_annotate;
set LAYER = L_SIPHTFindterm_SIPHTPatser_SIPHTBlast_SIPHTRNAMotif_SIPHTTransterm L_SIPHTPatser_concate_SIPHTSRNA L_SIPHTBlast_QRNA_SIPHTBlast_candidate_SIPHTFFN_Parse_SIPHTBlast_paralogues L_SIPHTBlast_synteny L_SIPHTSRNA_annotate;

set LAYER_TASK[L_SIPHTFindterm_SIPHTPatser_SIPHTBlast_SIPHTRNAMotif_SIPHTTransterm] = T_SIPHTFindterm T_SIPHTPatser T_SIPHTBlast T_SIPHTRNAMotif T_SIPHTTransterm;
set LAYER_TASK[L_SIPHTPatser_concate_SIPHTSRNA] = T_SIPHTPatser_concate T_SIPHTSRNA;
set LAYER_TASK[L_SIPHTBlast_QRNA_SIPHTBlast_candidate_SIPHTFFN_Parse_SIPHTBlast_paralogues] = T_SIPHTBlast_QRNA T_SIPHTBlast_candidate T_SIPHTFFN_Parse T_SIPHTBlast_paralogues;
set LAYER_TASK[L_SIPHTBlast_synteny] = T_SIPHTBlast_synteny;
set LAYER_TASK[L_SIPHTSRNA_annotate] = T_SIPHTSRNA_annotate;

param: 
                           task_count exec_time data_size_in data_size_out :=
         T_SIPHTFindterm           32     0.337664     3.182997    36.490140
           T_SIPHTPatser          584     0.000355     2.781505     0.087402
            T_SIPHTBlast           32     0.696844   246.449714     6.806832
         T_SIPHTRNAMotif           32     0.009442     2.635286     1.060897
        T_SIPHTTransterm           32     0.015730     2.980739     0.430827
    T_SIPHTPatser_concate           32     0.000021     1.595092     1.563325
             T_SIPHTSRNA           32     0.098847    61.270826     6.367654
       T_SIPHTBlast_QRNA           32     0.396908   246.471406     3.177163
    T_SIPHTBlast_candidate           32     0.001405     1.368875     0.014770
        T_SIPHTFFN_Parse           32     0.000450     4.497570     0.679171
    T_SIPHTBlast_paralogues           32     0.001424     1.204431     0.706861
    T_SIPHTBlast_synteny           32     0.009167     3.237271     1.040374
    T_SIPHTSRNA_annotate           32     0.000444     4.070496     1.428345
;
