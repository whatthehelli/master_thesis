%% Plot

clear all
%Load study (vorher erstellt, evtl. nochmal anpassen, schon unterteilt in verschiedene Bedingungen)
addpath 'D:\Masterarbeit\Forschungspraktikum\eeglab2022.1'
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

%jeweils in made, happe oder apice ÄNDERN!
studyname = 'happe'

[STUDY ALLEEG] = pop_loadstudy('filename', [studyname '.study'], 'filepath', 'C:\Users\Helena\Documents\Helena\Uni\6_Jahr\WiSe22_23\Forschungspraktikum\MOMA-audio\study\');

CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
eeglab redraw;

compare_cond = struct([])
for n = 1:length(EEG)
   compare_cond(n).vp_no = EEG(n).subject;
   compare_cond(n).happy = nnz(strcmp({EEG(n).event.code},'happy'));
   compare_cond(n).fearful = nnz(strcmp({EEG(n).event.code},'fearful'))
end

%nachgucken, ob pro Bedingung mind. 10 Trials vorhanden sind, falls nicht
%im nächsten Schritt gelöscht
for m = 1:length(compare_cond)
    if compare_cond(m).happy < 10 || compare_cond(m).fearful < 10
        index_vector(m) = 1;
    else
        index_vector(m) = 0;
    end
    rmv_trialcount = logical(index_vector);
end

vp_without = compare_cond;
vp_without(rmv_trialcount) = []
vp_without.vp_no

% KLAPPT NICHT
% values_vector = zeros(1, numel(vp_without));
% for i = 1:length(vp_without)
%     values_vector(i) = vp_without(i).vp_no;
% end

%VP mit zuwenig Trials gelöscht
%  EEG(rmv_trialcount) = [];
%  ALLEEG(rmv_trialcount) = [];
%  CURRENTSET(rmv_trialcount) = [];
%  STUDY.datasetinfo(rmv_trialcount) = [];
 %sortrows(STUDY.subject(rmv_trialcount)) = [];
%  EEG = eeg_checkset(EEG);
%  ALLEEG = eeg_checkset(ALLEEG)
 %STUDY = eeg_checkset(STUDY)


 %[h, p, ci, stats] = ttest(EEG.event(code == "happy", :), EEG.event(code == "fearful", :), 'Alpha', 0.05, 'Tail', 'both');
 %STUDY = std_erpplot(STUDY,ALLEEG,'channels',{ 'FP1'});
 %STUDY = pop_statparams(STUDY, 'condstats', 'on');
 %[STUDY erpdata erptimes pgroup pcond pinter] = std_erpplot(STUDY,ALLEEG,'channels',{ 'Fz', 'F3', 'F4'});

%  [STUDY erpdata erptimes] = std_erpplot(STUDY, ALLEEG, 'channels', {'Fz'}, 'timerange', [-200 800]);
%  std_plotcurve(erptimes, erpdata, 'plotconditions', 'together', 'titles', {[studyname ' Fz']}, 'plotstderr', 'on', ...
%        'figure', 'on', 'filter', 30, 'legend', 'on', 'ylim', [-20 5]);
% 

% name = 'happe';
% speicherort2 = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\preprocessed_happe\export2';
% trialanzahl = [];
% for j = 1:length(STUDY.datasetinfo)
%     trialanzahl(j) = length(STUDY.datasetinfo(j).trialinfo);
% end
% csvwrite([speicherort2 '\' name '_trialanzahl_alle.csv'],trialanzahl);
