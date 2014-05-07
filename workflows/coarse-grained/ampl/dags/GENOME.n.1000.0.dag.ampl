set TASK = T_GenomefastqSplit_chr T_GenomefilterContams_chr T_Genomesolsanger_chr T_Genomefastqbfq_chr T_Genomemap_chr T_GenomemapMerge_chr T_GenomemapMerge_chr T_Genomemaqindex_chr T_Genomepileup_chr;
set LAYER = L_GenomefastqSplit_chr L_GenomefilterContams_chr L_Genomesolsanger_chr L_Genomefastqbfq_chr L_Genomemap_chr L_GenomemapMerge_chr L_GenomemapMerge_chr L_Genomemaqindex_chr L_Genomepileup_chr;

set LAYER_TASK[L_GenomefastqSplit_chr] = T_GenomefastqSplit_chr;
set LAYER_TASK[L_GenomefilterContams_chr] = T_GenomefilterContams_chr;
set LAYER_TASK[L_Genomesolsanger_chr] = T_Genomesolsanger_chr;
set LAYER_TASK[L_Genomefastqbfq_chr] = T_Genomefastqbfq_chr;
set LAYER_TASK[L_Genomemap_chr] = T_Genomemap_chr;
set LAYER_TASK[L_GenomemapMerge_chr] = T_GenomemapMerge_chr;
set LAYER_TASK[L_GenomemapMerge_chr] = T_GenomemapMerge_chr;
set LAYER_TASK[L_Genomemaqindex_chr] = T_Genomemaqindex_chr;
set LAYER_TASK[L_Genomepileup_chr] = T_Genomepileup_chr;

param: 
                           task_count exec_time data_size_in data_size_out :=
    T_GenomefastqSplit_chr            7     0.016768   369.117845   369.117845
    T_GenomefilterContams_chr          245     0.000388    10.546224    10.546224
    T_Genomesolsanger_chr          245     0.000103     5.270425     4.293691
    T_Genomefastqbfq_chr          245     0.000189     4.293691     1.024317
         T_Genomemap_chr          245     1.685704  1963.247477     1.113388
    T_GenomemapMerge_chr            7     0.005273    38.968574    36.762805
    T_GenomemapMerge_chr            1     0.037989   257.339634   251.434745
    T_Genomemaqindex_chr            1     0.000050   242.773239     3.896994
      T_Genomepileup_chr            1     0.512714  1966.120153    21.266828
;
