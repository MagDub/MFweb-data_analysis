
load('../../data_analysis/usermat_completed.mat')
load('../../data_analysis/6_exclude/to_exclude.mat')
to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

% Demographics
load('../../data/questionnaire/demographics/raw/demo_desc.mat')
load('../../data/questionnaire/demographics/raw/demo.mat')
load('../../data/questionnaire/demographics/raw/p_ID.mat')
load('../../data/questionnaire/demographics/raw/started_datetime.mat')

% Questionnaires
load('../../data/questionnaire/all/IQscore_all.mat')
load('../../data/questionnaire/all/BIS11_all.mat')
load('../../data/questionnaire/all/AQ10_all.mat')
load('../../data/questionnaire/all/ASRS_all.mat')
load('../../data/questionnaire/all/CFS_all.mat')
load('../../data/questionnaire/all/IUS_all.mat')
load('../../data/questionnaire/all/OCIR_all.mat')
load('../../data/questionnaire/all/STAI_all.mat')
load('../../data/questionnaire/all/LSAS_all.mat')
load('../../data/questionnaire/all/SDS_all.mat')

% Add behaviour 
load('../../data/data_for_figs/pickedD_SH.mat')
load('../../data/data_for_figs/pickedD_LH.mat')

load('../../data/data_for_figs/pickedA_SH.mat')
load('../../data/data_for_figs/pickedA_LH.mat')

load('../../data/data_for_figs/pickedB_SH.mat')
load('../../data/data_for_figs/pickedB_LH.mat')

load('../../data/data_for_figs/pickedC_SH.mat')
load('../../data/data_for_figs/pickedC_LH.mat')

load('../../data/data_for_figs/pickedhigh_Aexploit_SH.mat')
load('../../data/data_for_figs/pickedhigh_Aexploit_LH.mat')

load('../../data/data_for_figs/pickedhigh_Bexploit_SH.mat')
load('../../data/data_for_figs/pickedhigh_Bexploit_LH.mat')

load('../../data/data_for_figs/pickedhigh_SH.mat')
load('../../data/data_for_figs/pickedhigh_LH.mat')

load('../../data/data_for_figs/pickedmedium_SH.mat')
load('../../data/data_for_figs/pickedmedium_LH.mat')

load('../../data/data_for_figs/score_desc.mat')
load('../../data/data_for_figs/score.mat')

load('../../data/data_for_figs/EV_SH_mat.mat')
load('../../data/data_for_figs/EV_LH_mat.mat')

load('../../data/data_for_figs/IS_SH_mat.mat')
load('../../data/data_for_figs/IS_LH_mat.mat')

load('../../data/data_for_figs/consistency_freq_desc.mat')
load('../../data/data_for_figs/consistency_freq.mat')

load('../../data/data_for_figs/BIC_all.mat')
load('../../data/data_for_figs/BIC_all_desc.mat')

load('../../data/data_for_figs/model_parameters.mat')
load('../../data/data_for_figs/model_parameters_desc.mat')

xi_SH = model_parameters(:,find(contains(model_parameters_desc,'xi_short')));
xi_LH = model_parameters(:,find(contains(model_parameters_desc,'xi_long')));
eta_SH = model_parameters(:,find(contains(model_parameters_desc,'eta_short')));
eta_LH = model_parameters(:,find(contains(model_parameters_desc,'eta_long')));
sgm0_SH = model_parameters(:,find(contains(model_parameters_desc,'sgm0_short')));
sgm0_LH = model_parameters(:,find(contains(model_parameters_desc,'sgm0_long')));
Q0 = model_parameters(:,find(contains(model_parameters_desc,'Q0')));

load('../../data/data_for_figs/model_parameters_mod8.mat')
load('../../data/data_for_figs/model_parameters_mod8_desc.mat')

mod8_xi_SH = model_parameters(:,find(contains(model_parameters_desc,'xi_short')));
mod8_xi_LH = model_parameters(:,find(contains(model_parameters_desc,'xi_long')));
mod8_eta_SH = model_parameters(:,find(contains(model_parameters_desc,'eta_short')));
mod8_eta_LH = model_parameters(:,find(contains(model_parameters_desc,'eta_long')));
mod8_tau_SH = model_parameters(:,find(contains(model_parameters_desc,'tau_short')));
mod8_tau_LH = model_parameters(:,find(contains(model_parameters_desc,'tau_long')));
mod8_gamma_SH = model_parameters(:,find(contains(model_parameters_desc,'gamma_short')));
mod8_gamma_LH = model_parameters(:,find(contains(model_parameters_desc,'gamma_long')));

% Behaviour per block 

load('../../data/data_for_figs/pickedhigh_SH_B1.mat')
load('../../data/data_for_figs/pickedhigh_SH_B2.mat')
load('../../data/data_for_figs/pickedhigh_SH_B3.mat')
load('../../data/data_for_figs/pickedhigh_SH_B4.mat')

load('../../data/data_for_figs/pickedhigh_LH_B1.mat')
load('../../data/data_for_figs/pickedhigh_LH_B2.mat')
load('../../data/data_for_figs/pickedhigh_LH_B3.mat')
load('../../data/data_for_figs/pickedhigh_LH_B4.mat')

load('../../data/data_for_figs/pickednovel_SH_B1.mat')
load('../../data/data_for_figs/pickednovel_SH_B2.mat')
load('../../data/data_for_figs/pickednovel_SH_B3.mat')
load('../../data/data_for_figs/pickednovel_SH_B4.mat')

load('../../data/data_for_figs/pickednovel_LH_B1.mat')
load('../../data/data_for_figs/pickednovel_LH_B2.mat')
load('../../data/data_for_figs/pickednovel_LH_B3.mat')
load('../../data/data_for_figs/pickednovel_LH_B4.mat')

load('../../data/data_for_figs/pickedlow_SH_B1.mat')
load('../../data/data_for_figs/pickedlow_SH_B2.mat')
load('../../data/data_for_figs/pickedlow_SH_B3.mat')
load('../../data/data_for_figs/pickedlow_SH_B4.mat')

load('../../data/data_for_figs/pickedlow_LH_B1.mat')
load('../../data/data_for_figs/pickedlow_LH_B2.mat')
load('../../data/data_for_figs/pickedlow_LH_B3.mat')
load('../../data/data_for_figs/pickedlow_LH_B4.mat')

load('../../data/data_for_figs/pickedmedium_SH_B1.mat')
load('../../data/data_for_figs/pickedmedium_SH_B2.mat')
load('../../data/data_for_figs/pickedmedium_SH_B3.mat')
load('../../data/data_for_figs/pickedmedium_SH_B4.mat')

load('../../data/data_for_figs/pickedmedium_LH_B1.mat')
load('../../data/data_for_figs/pickedmedium_LH_B2.mat')
load('../../data/data_for_figs/pickedmedium_LH_B3.mat')
load('../../data/data_for_figs/pickedmedium_LH_B4.mat')
                
% 

all_quest = [IQscore_all, BIS11_all, AQ10_all, ASRS_all, CFS_all, OCIR_all, STAI_all, IUS_all, SDS_all, LSAS_all];

all_desc = {'User', 'userIDDemo', 'age', 'gender', ...
             'average_first_apple_SH', 'average_first_apple_LH', 'average_all_apple_LH', ...
                'pickedA_SH', 'pickedA_LH', 'pickedB_SH', 'pickedB_LH', ...
                    'pickedD_SH', 'pickedD_LH', 'pickedC_SH', 'pickedC_LH', 'pickedhigh_SH', 'pickedhigh_LH', 'pickedmedium_SH', 'pickedmedium_LH', ...
                       'EV_SH', 'EV_LH', 'IS_SH', 'IS_LH', 'consistent_SH', 'consistent_LH', ...
                           'xi_SH', 'xi_LH', 'eta_SH', 'eta_LH', 'sgm0_SH', 'sgm0_LH', 'Q0', ...
                              'mod8_xi_SH', 'mod8_xi_LH', 'mod8_eta_SH', 'mod8_eta_LH', ...
                              'mod8_tau_SH', 'mod8_tau_LH', 'mod8_gamma_SH', 'mod8_gamma_LH', ...
                                  'pickedhigh_Aexploit_SH', 'pickedhigh_Aexploit_LH', 'pickedhigh_Bexploit_SH', 'pickedhigh_Bexploit_LH', ...
                                    'pickedhigh_SH_B1', 'pickedhigh_SH_B2', 'pickedhigh_SH_B3', 'pickedhigh_SH_B4', ...
                                    'pickedhigh_LH_B1', 'pickedhigh_LH_B2', 'pickedhigh_LH_B3', 'pickedhigh_LH_B4', ...
                                    'pickedmedium_SH_B1', 'pickedmedium_SH_B2', 'pickedmedium_SH_B3', 'pickedmedium_SH_B4', ...
                                    'pickedmedium_LH_B1', 'pickedmedium_LH_B2', 'pickedmedium_LH_B3', 'pickedmedium_LH_B4', ...
                                    'pickednovel_SH_B1', 'pickednovel_SH_B2', 'pickednovel_SH_B3', 'pickednovel_SH_B4', ...
                                    'pickednovel_LH_B1', 'pickednovel_LH_B2', 'pickednovel_LH_B3', 'pickednovel_LH_B4', ...
                                    'pickedlow_SH_B1', 'pickedlow_SH_B2', 'pickedlow_SH_B3', 'pickedlow_SH_B4', ...
                                    'pickedlow_LH_B1', 'pickedlow_LH_B2', 'pickedlow_LH_B3', 'pickedlow_LH_B4', ...
                                         'IQscore', 'BIS11_TotalScore', 'BIS11_Attentional', 'BIS11_Motor', 'BIS11_NonPlanning', ...
                                           'BIS11_Motor_Motor', 'BIS11_Motor_Perseverance', 'AQ10_TotalScore', ...
                                             'ASRS_Sum', 'ASRS_ShadedNb', 'ASRS_SumA', 'ASRS_ShadedNbA', 'ASRS_PassThreshold', 'ASRS_SumInattention',...
                                                'ASRS_SumHyperImpuls', 'ASRS_ShadedNbInattention', 'ASRS_ShadedNbHyperImpuls', 'CFS_TotalScore', ...
                                                    'OCIR_TotalScore', 'OCIR_Washing', 'OCIR_Checking', 'OCIR_Ordering', 'OCIR_Obsessions', 'OCIR_Hoarding', 'OCIR_Neutralising', ...
                                                       'STAI_TotalScore', 'IUS_TotalScore', 'IUS_FactorNegative', 'IUS_FactorUnfair',... 
                                                        'SDS_TotalScore','LSAS_TotalScore', 'LSAS_Fear', 'LSAS_Avoidance', 'LSAS_PerformanceFear', ...
                                                            'LSAS_SocialFear', 'LSAS_PerformanceAvoidance', 'LSAS_SocialAvoidance'};

userID=score(:,1);

for i=1:size(userID,1)
    
    user_no = userID(i);
    
    ind = find(usermat_completed==user_no);

    if ~isempty(ind) 
        all_(i,:) = [score(ind,1), demo(user_no,1:3), ...
                            score(ind,2:4), ...
                                pickedA_SH(ind), pickedA_LH(ind), pickedB_SH(ind), pickedB_LH(ind), ...
                                    pickedD_SH(ind), pickedD_LH(ind),pickedC_SH(ind), pickedC_LH(ind), pickedhigh_SH(ind), pickedhigh_LH(ind), pickedmedium_SH(ind), pickedmedium_LH(ind), ...
                                      EV_SH_mat(ind), EV_LH_mat(ind),IS_SH_mat(ind), IS_LH_mat(ind),consistency_freq(ind,2), consistency_freq(ind,1), ...
                                        xi_SH(ind), xi_LH(ind), eta_SH(ind), eta_LH(ind), sgm0_SH(ind), sgm0_LH(ind), Q0(ind), ...
                                            mod8_xi_SH(ind), mod8_xi_LH(ind), mod8_eta_SH(ind), mod8_eta_LH(ind), ...
                                                mod8_tau_SH(ind), mod8_tau_LH(ind), mod8_gamma_SH(ind), mod8_gamma_LH(ind), ...
                                                    pickedhigh_Aexploit_SH(ind), pickedhigh_Aexploit_LH(ind), pickedhigh_Bexploit_SH(ind), pickedhigh_Bexploit_LH(ind), ...
                                                        pickedhigh_SH_B1(ind), pickedhigh_SH_B2(ind), pickedhigh_SH_B3(ind), pickedhigh_SH_B4(ind), ...
                                                        pickedhigh_LH_B1(ind), pickedhigh_LH_B2(ind), pickedhigh_LH_B3(ind), pickedhigh_LH_B4(ind), ...
                                                            pickedmedium_SH_B1(ind), pickedmedium_SH_B2(ind), pickedmedium_SH_B3(ind), pickedmedium_SH_B4(ind), ...
                                                            pickedmedium_LH_B1(ind), pickedmedium_LH_B2(ind), pickedmedium_LH_B3(ind), pickedmedium_LH_B4(ind), ...
                                                                pickednovel_SH_B1(ind), pickednovel_SH_B2(ind), pickednovel_SH_B3(ind), pickednovel_SH_B4(ind), ...
                                                                pickednovel_LH_B1(ind), pickednovel_LH_B2(ind), pickednovel_LH_B3(ind), pickednovel_LH_B4(ind), ...
                                                                    pickedlow_SH_B1(ind), pickedlow_SH_B2(ind), pickedlow_SH_B3(ind), pickedlow_SH_B4(ind), ...
                                                                    pickedlow_LH_B1(ind), pickedlow_LH_B2(ind), pickedlow_LH_B3(ind), pickedlow_LH_B4(ind)];
        quest_(i,:) = all_quest(ind,:);
        prolificIDs(i,:) = p_ID(user_no);
        datetimes(i,:) = started_datetime(user_no);
    end
end

% BIC scores
load('../../data/data_for_figs/BIC_all.mat');
load('../../data/data_for_figs/BIC_all_desc.mat');

all = [all_ quest_];

all(to_del,5:end)=nan;

exclude = isnan(all(:,end));

all_desc = ['prolific_id', 'started_datetime', 'exclude', all_desc, BIC_all_desc]; 
all = [prolificIDs datetimes num2cell(exclude) num2cell(all) num2cell(BIC_all)]; 

T = cell2table(all,'VariableNames',all_desc);

writetable(T,'./web_data_completed.xlsx')
