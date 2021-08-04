
% All IDs and users from prolific
load('../../data/questionnaire/demographics/raw/p_ID.mat')
load('../../data/questionnaire/demographics/raw/userID.mat')
load('../../data/questionnaire/demographics/raw/started_datetime.mat')

% Completed
load('../usermat_completed_task.mat')
load('../usermat_completed_attentive.mat')
load('../usermat_completed.mat')

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

load('../../data/data_for_figs/model_parameters.mat')
load('../../data/data_for_figs/model_parameters_desc.mat')

xi_SH = model_parameters(:,find(contains(model_parameters_desc,'xi_short')));
xi_LH = model_parameters(:,find(contains(model_parameters_desc,'xi_long')));
eta_SH = model_parameters(:,find(contains(model_parameters_desc,'eta_short')));
eta_LH = model_parameters(:,find(contains(model_parameters_desc,'eta_long')));
sgm0_SH = model_parameters(:,find(contains(model_parameters_desc,'sgm0_short')));
sgm0_LH = model_parameters(:,find(contains(model_parameters_desc,'sgm0_long')));
Q0 = model_parameters(:,find(contains(model_parameters_desc,'Q0')));

check_ = (score(:,1) == usermat_completed_task');
if sum(check_)~=size(score,1)
    disp('ID mismatch')
end

summary(:,8:30) = nan(size(summary,1),23);

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

summary_desc{24} = 'xi_SH';
summary_desc{25} = 'xi_LH';
summary_desc{26} = 'eta_SH';
summary_desc{27} = 'eta_LH';
summary_desc{28} = 'sgm0_SH';
summary_desc{29} = 'sgm0_LH';
summary_desc{30} = 'Q0';

score_tot = (score(:,2)+score(:,4))/2;
bonus_GBP = (score_tot-4)/2;

for i=1:size(userID)
    
    user_no = userID(i);
    
    ind = find(usermat_completed_task==user_no);
    
    if ~isempty(ind)
        summary(i,8:30) = [bonus_GBP(ind), score(ind,2:4), ...
                              pickedD_SH(ind), pickedD_LH(ind),pickedC_SH(ind), pickedC_LH(ind), pickedhigh_SH(ind), pickedhigh_LH(ind),...
                                      EV_SH_mat(ind), EV_LH_mat(ind),IS_SH_mat(ind), IS_LH_mat(ind),consistency_freq(ind,2), consistency_freq(ind,1)...
                                        xi_SH(ind), xi_LH(ind), eta_SH(ind), eta_LH(ind), sgm0_SH(ind), sgm0_LH(ind), Q0(ind)];
    end
end

bonus_mat = [p_ID  num2cell(round(summary(:,8),2))];
to_del = isnan(summary(:,8));
bonus_mat(to_del,:)=[];
bonus_table = cell2table(bonus_mat);

summary_all_desc = ['prolific_id', 'started_datetime', summary_desc]; 
summary_all = [p_ID started_datetime num2cell(summary)]; 
T = cell2table(summary_all,'VariableNames',summary_all_desc);

% writetable(bonus_table,'../../data/excel/bonus_table.txt');
% writetable(T,'../../data/excel/web_data_new.xlsx')
