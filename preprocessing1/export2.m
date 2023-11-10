clear % clear matlab workspace
clc % clear matlab command window
clear all

% MADE
% data = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_made\condition_data\';
% speicherort2 = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_made\export3\';
% participants = {2,3,4,5,6,8,9,10,11,14,15,16,17,18,19,20,21,24,26,28,29,30,31,32,33,34,36,37,38,39,41,42,45,46}; 

%HAPPE
% data = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_happe\condition_data\';
% speicherort2 = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_happe\export3\';
% participants = {1,2,4,5,7,9,10,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,32,33,34,35,36,37,38,39,41,45,46}; 

%APICE
data = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_apice\DATA\condition_data\';
speicherort2 = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_apice\DATA\export3\';
participants = {1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,41,42,45,46}; 

channel_names = {'F3', 'Fz', 'F4', 'C3', 'Cz', 'C4'};
channel_roi = [5, 6, 7, 13, 14, 15];

for subject = 1:length(participants) %geändert -> vorher datafile_names 
   %EEG = pop_loadset(['vp' num2str(participants{subject}) '_processed_data_condition_data.set'], data);
   EEG = pop_loadset(['erp_prp_vp' num2str(participants{subject}) '_condition_data.set'], data);
   idx_channel = ismember(1:size(EEG.data, 1), channel_roi);
   new_data = squeeze(mean(EEG.data(idx_channel, :, :), 1));
   
   dateiname = [speicherort2 'vp' num2str(participants{subject}) '_trials_roi.csv'];
   writematrix(new_data, dateiname);

    %bedingungen_vektor
    col_names = cell(length(EEG.event),1);
    for j = 1:length(EEG.event)
        col_names{j} = EEG.event(j).code;
    end

    dateiname_cond = [speicherort2 'vp' num2str(participants{subject}) '_cond.csv'];
    writecell(col_names, dateiname_cond);
end


