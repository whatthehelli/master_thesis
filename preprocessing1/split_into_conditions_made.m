
%% load data
clear all;
addpath('C:\Users\Helena\Documents\Helena\Uni\6_Jahr\WiSe22_23\Forschungspraktikum\eeglab2022.1\');
eeglab

%made
% processed_location = 'C:\Users\Helena\Documents\Helena\Uni\6_Jahr\WiSe22_23\Forschungspraktikum\MOMA-audio\preprocessed_made\processed_data\';
% output_location = 'C:\Users\Helena\Documents\Helena\Uni\6_Jahr\WiSe22_23\Forschungspraktikum\MOMA-audio\preprocessed_made\';

%happe
% processed_location = 'C:\Users\Helena\Documents\Helena\Uni\6_Jahr\WiSe22_23\Forschungspraktikum\MOMA-audio\preprocessed_happe\processed_whole\';
% output_location = 'C:\Users\Helena\Documents\Helena\Uni\6_Jahr\WiSe22_23\Forschungspraktikum\MOMA-audio\preprocessed_happe\';

%apice
processed_location = 'C:\Users\Helena\Documents\Helena\Uni\6_Jahr\WiSe22_23\Forschungspraktikum\MOMA-audio\preprocessed_apice\DATA\erp\';
output_location = 'C:\Users\Helena\Documents\Helena\Uni\6_Jahr\WiSe22_23\Forschungspraktikum\MOMA-audio\preprocessed_apice\DATA\';

%% Read files to analyses
datafile_names=dir(processed_location); %alle Files aus dem rawdata-Ordner aufrufen
datafile_names=datafile_names(~ismember({datafile_names.name},{'.', '..', '.DS_Store'})); %alle files, die im DS_Store sind -> für Macs
datafile_names={datafile_names.name}; 
[filepath,name,ext] = fileparts(char(datafile_names{1})); %es werden seperat Pfad, Name und Endung abgespeichert

%condition_num = {'S1','S2','S3','S4','S5','S6';'S7','S8','S9','S10','S11','S12'};

%% Loop over all particapant
for subject=1:length(datafile_names)
   %% 
   %made (alle)
%    participants={1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,41,42,45,46}; 
%    EEG = pop_loadset(['vp' num2str(participants{subject}) '_processed_data.set'], processed_location); %anpassen

   %participants happe (ohne 7 und 31)
%    participants = {1,2,3,4,5,7,8,9,10,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,32,33,34,35,36,37,38,39,41,42,45,46}; 
%    EEG = pop_loadset(['vp' num2str(participants{subject}) '_processed.set'], processed_location);

   %participants apice (ohne 17)
   participants = {1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,41,42,45,46}; 
   EEG = pop_loadset(['erp_prp_vp' num2str(participants{subject}) '.set'], processed_location); %anpassen
   
   [ALLEEG EEG CURRENTSET] = eeg_store(ALLEEG, EEG, CURRENTSET);
   %[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname',['vp' num2str(participants{subject})],'gui','off'); 
   EEG = eeg_checkset( EEG );

   %einteilen in happy und fearful (Conditions)
    for h = 1:length(EEG.epoch)
        if strcmp(EEG.event(h).type,'S1'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','happy'});end
        if strcmp(EEG.event(h).type,'S2'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','happy'});end
        if strcmp(EEG.event(h).type,'S3'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','happy'});end
        if strcmp(EEG.event(h).type,'S4'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','happy'});end
        if strcmp(EEG.event(h).type,'S5'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','happy'});end
        if strcmp(EEG.event(h).type,'S6'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','happy'});end
        if strcmp(EEG.event(h).type,'S7'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','fearful'});end
        if strcmp(EEG.event(h).type,'S8'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','fearful'});end
        if strcmp(EEG.event(h).type,'S9'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','fearful'});end
        if strcmp(EEG.event(h).type,'S10'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','fearful'});end
        if strcmp(EEG.event(h).type,'S11'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','fearful'});end
        if strcmp(EEG.event(h).type,'S12'); EEG = pop_editeventvals(EEG,'changefield',{h,'code','fearful'});end
    end
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET); %Zwischenspeicherung
    EEG = eeg_checkset(EEG);
    EEG = pop_editset(EEG, 'setname',  strrep(datafile_names{subject}, ext, '_condition_data'));
    EEG = pop_saveset(EEG, 'filename', strrep(datafile_names{subject}, ext, '_condition_data.set'),'filepath', [output_location filesep 'condition_data' filesep ]); % save .set format

end




