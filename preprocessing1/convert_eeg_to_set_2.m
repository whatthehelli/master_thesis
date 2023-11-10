%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prepare data for analysis in with the eeglab/ the HAPPE pipeline
%   In order to analyze the EEG data from the brainvision amplifier with
%   HAPPE, we need to (a) convert it in a different file format (from
%   .vhdr/.eeg to .set) and (b) change the trigger name, as the current
%   trigger names contain a ' ' (blank space), which HAPPE can't handle
%   properly. This script does both of that.
%
%   Also, this script takes care of excluding trials in which the infant
%   did not look at the screen. This was previously coded manually from
%   videos, so it expects as input .txt files with a list of 1's and 0's
%   (1=looked, 0= did not look). In case the infant did not look, the
%   trigger from that trials gets an X appended and is therefore in HAPPE
%   not included when trials with the "normal" trigger are selected.
%
%   Specifics for this experiment: The trimodal experiment has two sessions
%   with slightly different sets of participants, so we need to run the
%   whole thing twice, once for each session
%   Also, there are some participants who did not have a video recording to
%   code looking behavior from, these are treated separately at the end
%   
%   (Before running, you need to add eeglab to your Matlab path)
%
%   Sarah Jessen, September 2022
% ------------------------------------------------
clear all

% folder where the EEG raw data (.eeg, .vhdr,.vmrk) are located
folder_raweeg = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\rawdata';
% folder where output is supposed to be saved
folder_output = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\rawdata_eeglab_onlytrigger';
% location where file with electrode layout is located
electemplate = 'D:\Masterarbeit\Forschungspraktikum\eeglab2022.1\plugins\dipfit\standard_BEM\elec\standard_1005.elc';
% folder where files with whether infant looked are
folder_looking = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\looking';
addpath(genpath('D:\Masterarbeit\Forschungspraktikum\eeglab2022.1\'));
datapath = 'D:\Masterarbeit\Forschungspraktikum\MOMA-audio\';


% SESSION 1
participants = {45,46}

for p = 1:length(participants)
    % read list coding whether infant looked for a given trial
    %looked = textscan([folder_looking 'ma_vp' num2str(participants{p}) '_n1.txt'],'%u'); %geändert textread zu textscan (empfohlen)
    looked = textread([datapath '/looking/ma_vp' num2str(participants{p}) '_n1.txt'],'%u');
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    EEG = pop_loadbv(folder_raweeg, ['moma-audio_vp' num2str(participants{p}) '_n1.vhdr']); %anpassen
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname',['vp' num2str(participants{p})],'gui','off'); 
    EEG = eeg_checkset( EEG );
    % assign correct layout
    EEG=pop_chanedit(EEG, 'lookup',electemplate);
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
   

    % change all triggers with space ('S 22' etc.) to trigger without space
    % ('S22' etc.)
    % look_counter to go through all the trials in the looking list (is different
    % from event-counter (e) as there are more events than trials (e.g.
    % fixationcross onset, attentiongetter etc.)
    look_counter = 1;
    for e = 1:length(ALLEEG.event)
         if strcmp(ALLEEG.event(e).type,'S  1'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S1'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S  2'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S2'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S  3'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S3'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S  4'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S4'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S  5'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S5'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S  6'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S6'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S  7'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S7'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S  8'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S8'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S  9'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S9'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S 10'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S10'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S 11'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S11'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         elseif strcmp(ALLEEG.event(e).type,'S 12'); EEG = pop_editeventvals(EEG,'changefield',{e,'type','S12'}); EEG = pop_editeventvals(EEG,'changefield',{e,'code','Trigger'});
         end
    end

    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET); %Zwischenspeicherung

    % Schleife, die abprüft an welchen Stellen in ALLEEG.event.code 'Trigger'
    % eingetragen ist -> alle Werte mit S1, S2... -> Insgesamt 216
    for z = 1:length(ALLEEG.event)
        if strcmp(ALLEEG.event(z).code,'Trigger')
            trigger_idx(z) = 1;
        else
            trigger_idx(z) = 0;
        end
    end
    
    %in a sind Stellen, an denen 'Trigger' steht, dieser Vektor wird als Index
    %benutzt und wird überschrieben, ob die VP geguckt hat oder nicht
    A = find(trigger_idx);

%     funktioniert eventuell noch nicht -> abprüfen, ob looking-Datei
%     gleich lang ist mit der Anzahl der Trigger
       if length(A) == length(looked)
           trigger_idx(A) = looked;
       else
           disp('Something is wrong with the number of trials!')
           return
       end

    for g = 1:length(ALLEEG.event)
        if strcmp(ALLEEG.event(g).type,'S1'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S1X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S2'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S2X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S3'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S3X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S4'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S4X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S5'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S5X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S6'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S6X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S7'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S7X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S8'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S8X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S9'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S9X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S10'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S10X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S11'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S11X'}); end
        elseif strcmp(ALLEEG.event(g).type,'S12'); if trigger_idx(g) == 0; EEG = pop_editeventvals(EEG,'changefield',{g,'type','S12X'}); end
        end
    end

 %alle Stimuli löschen (klappt nur beim einzeln ausführen, nicht bei
    %"run"
    for j = length(ALLEEG.event):-1:1
        if strcmp(ALLEEG.event(j).code,'Stimulus')
            EEG.event(j)=[];
        end
    end
    
    [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
    EEG = pop_saveset( EEG, 'filename',['vp' num2str(participants{p}) '.set'],'filepath',folder_output);
    clear A; clear e; clear g; clear trigger_idx; clear z;
    close 
end
