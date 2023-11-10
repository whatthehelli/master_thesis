clear % clear matlab workspace
clc % clear matlab command window
clear all

%MADE
% studyname = 'made_without_vp'
% name = 'made';
% speicherort = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_made\exportx';
% speicherort2 = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_made\export2';

%HAPPE
% studyname = 'happe_without_vp'
% name = 'happe';
% speicherort = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_happe\exportx';
% speicherort2 = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_happe\export2';

%APICE
studyname = 'apice'
name = 'apice';
speicherort = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_apice\DATA\exportx';
% speicherort2 = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_apice\DATA\export2';

[STUDY ALLEEG] = pop_loadstudy('filename', [studyname '.study'], 'filepath', 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\study\');

channel_names = {'F3', 'Fz', 'F4', 'C3', 'Cz', 'C4'};
condition_name = {'happy', 'fearful'}

for i = 1:length(channel_names)
    [STUDY erpdata erptimes] = std_erpplot(STUDY,ALLEEG,'channels', {channel_names{i}}, 'noplot', 'on');
    erpdata_happy = erpdata{2};
    erpdata_fearful = erpdata{1};
    csvwrite([speicherort '\' name '_' channel_names{i} '_happy.csv'],erpdata_happy);
    csvwrite([speicherort '\' name '_' channel_names{i} '_fearful.csv'],erpdata_fearful);
end

% erptimes = erptimes;
% csvwrite( 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\erptimes.csv', erptimes)

%Anzahl Trials herausfinden
% trialanzahl = [];
% for j = 1:length(STUDY.datasetinfo)
%     trialanzahl(j) = length(STUDY.datasetinfo(j).trialinfo);
% end
% csvwrite([speicherort2 '\' name '_trialanzahl.csv'],trialanzahl);
% 

% trialanzahl_2 = [];
% for j = 1:length(STUDY.datasetinfo)
%     trialanzahl_2(1,j) = str2double(STUDY.datasetinfo(j).subject);
%     trialanzahl_2(2,j) = length(STUDY.datasetinfo(j).trialinfo);
% end
% 
% csvwrite([speicherort2 '\' name '_trialanzahl_2.csv'],trialanzahl_2);
