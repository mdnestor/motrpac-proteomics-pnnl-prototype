#!/bin/sh

# Execute in docker
java -Xmx4000M \
-jar /app/MSGFPlus.jar \
-s /data/test_phospho/msgfplus_input/MoTrPAC_Pilot_TMT_P_S1_01_DIL_28Oct17_Elm_AQ-17-10-03.mzML \
-o /data/test_phospho/msgfplus_output/MoTrPAC_Pilot_TMT_P_S1_01_DIL_28Oct17_Elm_AQ-17-10-03.mzid \
-d /data/ID_007275_FB1B42E8.fasta \
-conf /parameters/MzRef_StatCysAlk_S_Phospho_Dyn_TY_Phospho_TMT_6plex.txt | tee /data/test_phospho/step02_phospho.log

java -Xmx4000M \
-jar /app/MSGFPlus.jar \
-s /data/test_phospho/msgfplus_input/MoTrPAC_Pilot_TMT_P_S2_01_3Nov17_Elm_AQ-17-10-03.mzML \
-o /data/test_phospho/msgfplus_output/MoTrPAC_Pilot_TMT_P_S2_01_3Nov17_Elm_AQ-17-10-03.mzid \
-d /data/ID_007275_FB1B42E8.fasta \
-conf /parameters/MzRef_StatCysAlk_S_Phospho_Dyn_TY_Phospho_TMT_6plex.txt | tee -a /data/test_phospho/step02_phospho.log
