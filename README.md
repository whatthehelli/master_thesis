# master_thesis
scripts for evaluation for my master thesis. 

Im folgenden sind alle verwendeten Skripte für die Masterarbeit aufgelistet. Die Hauptdatenauswertung hat mit dem Auswertung_MA2.Rmd in R stattgefunden. Dafür lagen die vorverarbeiteten Daten aus den drei Pipelines vor. Die Vorverarbeitungsskripte sind im Ordner "preprocessing" zu finden. Die jeweiligen Dateipfade müssten angepasst werden, da diese an unterschiedlichen Orten verteilt lagen.

Im R-Skript sollte alles ausreichend kommentiert sein (letztes verwendetes Skript). Die anderen Skripte wurden in der folgenden Reihenfolge verwendet:
1. convert_eeg_to_set_2.m - ALLE - "All .vhdr, .vmrk, .eeg to set and S1-S12 Trigger (all other ""events"" are removed) and change every trigger where the child did not look on the screen to S_X"
2. made_preprocessing_pipeline_rawdataset.m - MADE - preprocessing MADE-pipeline (filtering, epoch, remove artifacts, interpolation, rereferencing), personal adjustments in Step 8 (preparation), s. script and Tätigkeitsübersicht
3. HAPPE_v3.m - HAPPE - preprocessing HAPPE-pipeline
4. ex1_details_2023.m - APICE - preprocessing APICE-pipeline, personal adjustments (perceptible with %GEÄNDERT)
5. split_into_conditions_made.m - ALLE - split all trigger into conditions (happy (S1-S6) and fearful (S7-S12))
6. _(manual) - kein Skript: create study with eeglab (load every dataset of the preprocessing and create
study)
7. plot_MADE.m - ALLE - remove subjects with to little trials (<10), manual change of the pipeline-name
8. _(manual) - kein Skript: create new study only with subject with enough trials per condition
9. export.m - ALLE  - export erp-data for every ROI-channel and two conditions happy and fearful + export number of trials (for every study (with all subjects and sorted out)
10. export2.m - export data for every subject individual: one .csv-file with the data (sampling 
rate x trials, averaged over six ROI-channels) and one .csv-file with attribution of condition (happy or fearful)
