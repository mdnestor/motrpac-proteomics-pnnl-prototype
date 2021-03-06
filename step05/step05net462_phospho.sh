#! /bin/sh

mono /app/mzid2tsv/net462/MzidToTsvConverter.exe \
-mzid:/data/test_phospho/msgfplus_output/MoTrPAC_Pilot_TMT_P_S1_01_DIL_28Oct17_Elm_AQ-17-10-03_final.mzid \
-tsv:/data/test_phospho/msgfplus_output/MoTrPAC_Pilot_TMT_P_S1_01_DIL_28Oct17_Elm_AQ-17-10-03.tsv \
-unroll -showDecoy | tee /data/test_phospho/step05_mzid2tsv.log

mono /app/mzid2tsv/net462/MzidToTsvConverter.exe \
-mzid:/data/test_phospho/msgfplus_output/MoTrPAC_Pilot_TMT_P_S2_01_3Nov17_Elm_AQ-17-10-03_final.mzid \
-tsv:/data/test_phospho/msgfplus_output/MoTrPAC_Pilot_TMT_P_S2_01_3Nov17_Elm_AQ-17-10-03.tsv \
-unroll -showDecoy | tee -a /data/test_phospho/step05_mzid2tsv.log