
% General

% Check si demographics ca joue (voir dans un user, son age, gender et
% score et voir si fit quand on regarde manuellement sur database)

% ASRS DATA NADA

% Correlation power simulation 

load('../usermat_completed.mat')

res_fold = '../../data/questionnaire/';

% load demographics
load(strcat(res_fold, 'demographics/raw/p_ID.mat'))
load(strcat(res_fold, 'demographics/raw/demo.mat'))
load(strcat(res_fold, 'demographics/raw/demo_desc.mat'))

n = length(usermat_completed);

%init
RT_quest_all = nan(n,8);
ASRS_all = nan(n,9);
OCIR_all = nan(n,1);
STAI_all = nan(n,1);
AQ10_all = nan(n,1);
CFS_all = nan(n,1);
BIS11_all= nan(n,1);
IUS_all = nan(n,3);
IQscore_all= nan(n,1);
CheckPassedPerc_all = nan(n,1);
TotTimeSec_all = nan(n,1);
Demo_all = nan(n,6);

for i=1:n
        
    userID = usermat_completed(i);
        
    disp(['userID:', 32, num2str(userID)])
    
    addpath('./concat_fct/')
    path_ = '../../data/raw/';
    
    path_quest = strcat(path_,'user_',num2str(userID),'/questionnaires/');
    list_q = dir(strcat(path_quest,'*.xls'));
    
    if length(list_q)~=1
        disp('many questionnaire file: PROBLEM')
    end
    
    user_fol = strcat(res_fold,'user_',num2str(userID));
    if ~exist(user_fol)
        mkdir(user_fol)
    end
    
    if exist(path_quest)
        
        T = readtable(strcat(path_quest,list_q.name));

        % Compute reaction times: RT in milliseconds (divide by 1000 -> seconds)
%         tmp = [str2double(T.PageNo0), str2double(T.PageNo1), str2double(T.PageNo2)...
%             str2double(T.PageNo3), str2double(T.PageNo4), str2double(T.PageNo5),...
%             str2double(T.PageNo6), str2double(T.PageNo7), str2double(T.PageNo8), str2double(T.PageNo9)];

%         n_quest = 10;
%         RT_quest=[];
% 
%         for q = 1: n_quest
%             RT_quest(end+1) = tmp(q+1) - tmp(q); 
%         end

%         RT_quest_desc={'ASRS', 'BIS11', 'OCIR', 'IUS', 'SDS', 'STAI', 'IQ', 'IQim'};
            

        %%%%%%%%
        
        % MEDIC % 
        [MEDIC_mat_desc, MEDIC_mat] = concat_MEDIC(T.MEDIC{1});
        
        % AQ10 % (recommended cutoff: 6)
        [AQ10_mat_desc, AQ10_mat, AQ10_score_desc, AQ10_score] = concat_AQ10(T.AQ10{1});
        
        % OCIR: OCD
        % Score: Sum (recommended cutoff: 21)
        [OCIR_mat_desc, OCIR_mat, OCIR_score_desc, OCIR_score] = concat_OCIR(T.OCIR{1});
        
        % CFS
        [CFS_mat_desc, CFS_mat, CFS_score_desc, CFS_score] = concat_CFS(T.CFS{1});

        % STAI: State-Trait Anxiety Inventory (we only do trait)
        [STAI_mat_desc, STAI_mat, STAI_score_desc, STAI_score] = concat_STAI(T.STAI{1});

        % ASRS: Adult ADHD self-report scale 
        [ASRS_mat_desc, ASRS_mat, ASRS_score_desc, ASRS_score] = concat_ASRS(T.ASRS{1});

        % BIS11
        [BIS11_mat_desc, BIS11_mat, BIS11_score_desc, BIS11_score] = concat_BIS11(T.BIS11{1});

        % IUS
        [IUS_mat_desc, IUS_mat, IUS_score_desc, IUS_score] = concat_IUS(T.IUS{1});
        
        % LSAS: Liebowitz Social Anxiety Scale
        [LSAS_mat_desc, LSAS_mat, LSAS_score_desc, LSAS_score] = concat_LSAS(T.LSAS{1});

        % SDS: Zung Self Rating Depression Scale
        [SDS_mat_desc, SDS_mat, SDS_score_desc, SDS_score] = concat_SDS(T.SDS{1});

        % IQ
        [IQscore, IQpercentage] = concat_IQ(T);

        % Demo
        tmp_dem = strfind(p_ID, T.ProlificID);

        for d_=1:size(tmp_dem,1)
            tmp_d(d_) = ~isempty(tmp_dem{d_});
        end

        d_ind = find(tmp_d,1);
        if isempty(d_ind)
            Demo_mat = nan(1,3);
        else
            Demo_mat = demo(d_ind, :);
        end
        Demo_mat_desc = demo_desc;

        % Checks
        [~, check_mat_AQ10, ~] = concat_checks(T.AQ10{1}, 1);
        [~, check_mat_CFS, ~] = concat_checks(T.CFS{1}, 1);
        [~, check_mat_ASRS, ~] = concat_checks(T.ASRS{1}, 1);
        [~, check_mat_BIS11, ~] = concat_checks(T.BIS11{1}, 2);
        [~, check_mat_OCIR, ~] = concat_checks(T.OCIR{1}, 1);      
        [~, check_mat_IUS, ~] = concat_checks(T.IUS{1}, 2);
        [~, check_mat_SDS, ~] = concat_checks(T.SDS{1}, 1);
        [~, check_mat_STAI, ~] = concat_checks(T.STAI{1}, 1);
        [~, check_mat_LSAS, ~] = concat_checks_LSAS(T.LSAS{1}, 2);

        check_mat = [check_mat_AQ10; check_mat_CFS; check_mat_ASRS; check_mat_BIS11; check_mat_OCIR; check_mat_IUS; check_mat_SDS; check_mat_STAI];

        passed = 0;

        for k = 1:size(check_mat,1)
            if check_mat(k,1) == check_mat(k,2)
                passed = passed+1;
            end
        end

        % LSAS check
        for j = 1:size(check_mat_LSAS,1)
            if (check_mat_LSAS(j,1) == check_mat_LSAS(j,2)) && (check_mat_LSAS(j,1) == check_mat_LSAS(j,3))
                passed = passed+1;
            end
        end

        CheckPassedPerc = passed / (size(check_mat,1)+2);

        % Compute total time spend
        start_time = T.UserStartTime{1};
        finish_time = T.QuestionnaireFinishTime{1};

        t1={strcat('01-Oct-2011',32,start_time(1:8))};
        t2={strcat('01-Oct-2011',32,finish_time(1:8))};

        if etime(datevec(datenum(t2)),datevec(datenum(t1)))<0
            t2={strcat('02-Oct-2011',32,finish_time(1:8))};
        end

        TotTimeSec = etime(datevec(datenum(t2)),datevec(datenum(t1)));

        % Change of Time Zone
        % hours_diff=6;
        % if userID==13
        %    TotTimeSec = TotTimeSec-hours_diff*3600;
        % end

        save(strcat(user_fol,'/RT_quest.mat'), 'RT_quest')
        save(strcat(user_fol,'/RT_quest_desc.mat'), 'RT_quest_desc')
        
        save(strcat(user_fol,'/ASRS_mat_desc.mat'), 'ASRS_mat_desc')
        save(strcat(user_fol,'/ASRS_mat.mat'), 'ASRS_mat')
        
        save(strcat(user_fol,'/AQ10_mat_desc.mat'), 'AQ10_mat_desc')
        save(strcat(user_fol,'/AQ10_mat.mat'), 'AQ10_mat')
        
        save(strcat(user_fol,'/CFS_mat_desc.mat'), 'CFS_mat_desc')
        save(strcat(user_fol,'/CFS_mat.mat'), 'CFS_mat')
        
        save(strcat(user_fol,'/MEDIC_mat_desc.mat'), 'MEDIC_mat_desc')
        save(strcat(user_fol,'/MEDIC_mat.mat'), 'MEDIC_mat')
        
        save(strcat(user_fol,'/OCIR_mat_desc.mat'), 'OCIR_mat_desc')
        save(strcat(user_fol,'/OCIR_mat.mat'), 'OCIR_mat')
        
        save(strcat(user_fol,'/STAI_mat_desc.mat'), 'STAI_mat_desc')
        save(strcat(user_fol,'/STAI_mat.mat'), 'STAI_mat')
        
        save(strcat(user_fol,'/BIS11_mat_desc.mat'), 'BIS11_mat_desc')
        save(strcat(user_fol,'/BIS11_mat_desc.mat'), 'BIS11_mat_desc')
        
        save(strcat(user_fol,'/IUS_mat_desc.mat'), 'IUS_mat_desc')
        save(strcat(user_fol,'/IUS_mat_desc.mat'), 'IUS_mat_desc')
        
        save(strcat(user_fol,'/SDS_mat_desc.mat'), 'SDS_mat_desc')
        save(strcat(user_fol,'/SDS_mat.mat'), 'SDS_mat')
        
        save(strcat(user_fol,'/TotTimeSec.mat'), 'TotTimeSec')
        
        save(strcat(user_fol,'/CheckPassedPerc.mat'), 'CheckPassedPerc')
        
        save(strcat(user_fol,'/Demo_mat.mat'), 'Demo_mat')
        save(strcat(user_fol,'/Demo_mat_desc.mat'), 'Demo_mat_desc')

        % Allparticipants
        RT_quest_all(i,:) = RT_quest; % All participants
        ASRS_all(i,:) = ASRS_score;
        OCIR_all(i,:) = OCIR_score;
        AQ10_all(i,:) = AQ10_score;
        CFS_all(i,:) = CFS_score;
        STAI_all(i,:) = STAI_score;
        BIS11_all(i,:) = BIS11_score;
        IUS_all(i,:) = IUS_score;
        IQscore_all(i,:) = IQscore;
        CheckPassedPerc_all(i,:) = CheckPassedPerc;
        TotTimeSec_all(i,:) = TotTimeSec;
        Demo_all(i,:) = Demo_mat;
    end
end


fol_all = strcat(res_fold,'all');
save(strcat(fol_all,'/RT_quest_all.mat'), 'RT_quest_all')
save(strcat(fol_all,'/RT_quest_desc.mat'), 'RT_quest_desc')
save(strcat(fol_all,'/ASRS_all.mat'), 'ASRS_all')
save(strcat(fol_all,'/ASRS_mat_desc.mat'), 'ASRS_mat_desc')
save(strcat(fol_all,'/OCIR_all.mat'), 'OCIR_all')
save(strcat(fol_all,'/STAI_all.mat'), 'STAI_all')
save(strcat(fol_all,'/CFS_all.mat'), 'CFS_all')
save(strcat(fol_all,'/AQ10_all.mat'), 'AQ10_all')
save(strcat(fol_all,'/BIS11_all.mat'), 'BIS11_all')
save(strcat(fol_all,'/IUS_all.mat'), 'IUS_all')
save(strcat(fol_all,'/IQscore_all.mat'), 'IQscore_all')
save(strcat(fol_all,'/CheckPassedPerc_all.mat'), 'CheckPassedPerc_all')
save(strcat(fol_all,'/TotTimeSec_all.mat'), 'TotTimeSec_all')
save(strcat(fol_all,'/Demo_all.mat'), 'Demo_all')
save(strcat(fol_all,'/Demo_desc.mat'), 'demo_desc')

