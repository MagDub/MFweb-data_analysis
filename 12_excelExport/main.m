
% All IDs and users from prolific
load('../../data/questionnaire/demographics/raw/p_ID.mat')
load('../../data/questionnaire/demographics/raw/userID.mat')
load('../../data/questionnaire/demographics/raw/started_datetime.mat')

% Completed
load('../usermat_completed.mat')
load('../usermat_completed_attentive.mat')

% Exclusion
load('../../data/questionnaire/demographics/raw/exclusion_criteria_desc.mat')
load('../../data/questionnaire/demographics/raw/exclusion_criteria.mat')

% Demographics
load('../../data/questionnaire/demographics/raw/demo_desc.mat')
load('../../data/questionnaire/demographics/raw/demo.mat')


% Add attention checks

summary_desc = demo_desc;
summary_desc{7} = 'PassedChecks';

summary = [demo nan(size(demo,1),1)];

for i=1:size(userID)
    
    user_no = userID(i);
    
    ind = find(exclusion_criteria(:,1)==user_no);
    
    if ~isempty(ind)
        summary(i,7) = abs(exclusion_criteria(ind,2)-1);
    end
    
end


% Add behaviour 

load('../../data/data_for_figs/pickedD_SH.mat')
load('../../data/data_for_figs/pickedD_LH.mat')

load('../../data/data_for_figs/pickedC_SH.mat')
load('../../data/data_for_figs/pickedC_LH.mat')

load('../../data/data_for_figs/pickedhigh_SH.mat')
load('../../data/data_for_figs/pickedhigh_LH.mat')

load('../../data/data_for_figs/score_desc.mat')
load('../../data/data_for_figs/score.mat')

load('../../data/data_for_figs/EV_SH_mat.mat')
load('../../data/data_for_figs/EV_LH_mat.mat')

load('../../data/data_for_figs/IS_SH_mat.mat')
load('../../data/data_for_figs/IS_LH_mat.mat')

load('../../data/data_for_figs/consistency_freq_desc.mat')
load('../../data/data_for_figs/consistency_freq.mat')

check_ = (score(:,1) == usermat_completed_attentive');
if sum(check_)~=size(score,1)
    disp('ID mismatch')
end

summary(:,8:23) = nan(size(summary,1),16);

summary_desc{8} = 'bonus_GBP';
summary_desc{9} = 'average_first_apple_SH';
summary_desc{10} = 'average_first_apple_LH';
summary_desc{11} = 'average_all_apple_LH';

summary_desc{12} = 'pickedD_SH';
summary_desc{13} = 'pickedD_LH';
summary_desc{14} = 'pickedC_SH';
summary_desc{15} = 'pickedC_LH';
summary_desc{16} = 'pickedhigh_SH';
summary_desc{17} = 'pickedhigh_LH';

summary_desc{18} = 'EV_SH';
summary_desc{19} = 'EV_LH';
summary_desc{20} = 'IS_SH';
summary_desc{21} = 'IS_LH';
summary_desc{22} = 'consistent_SH';
summary_desc{23} = 'consistent_LH';

score_tot = (score(:,2)+score(:,4))/2;
bonus_GBP = (score_tot-4)/2;

for i=1:size(usermat_completed_attentive,2)
    
    user_no = usermat_completed_attentive(i);
    
    ind = find(summary(:,1)==user_no);
    
    summary(ind,8:23) = [bonus_GBP(i), score(i,2:4)...
                          pickedD_SH(i), pickedD_LH(i),pickedC_SH(i), pickedC_LH(i), pickedhigh_SH(i), pickedhigh_LH(i),...
                                  EV_SH_mat(i), EV_LH_mat(i),IS_SH_mat(i), IS_LH_mat(i),consistency_freq(i,2), consistency_freq(i,1)];        
end

summary_all_desc = ['prolific_id', 'started_datetime', summary_desc]; 
summary_all = [p_ID started_datetime num2cell(summary)]; 
T = cell2table(summary_all,'VariableNames',summary_all_desc);

filename = '../../data/excel/web_data.xlsx';
writetable(T,filename)
