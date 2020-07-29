addpath('./functions/')

load('../usermat_completed_task.mat')
data_fold = ('../../data/');
dir_data = (strcat(data_fold,'sanity_check/'));
dir_save = (strcat(data_fold,'data_for_figs/'));

n = size(usermat_completed_task,2);

score_LH = nan(n,1);
first_apple_LH = nan(n,1);
score_LH_mean = nan(n,1);
score_SH = nan(n,1);
trials_SH = nan(n,1);
trials_LH = nan(n,1);
average_first_apple_SH = nan(n,1);
average_first_apple_LH = nan(n,1);
average_all_apple_LH = nan(n,1);

for ID_i = 1:n
    
    ID = usermat_completed_task(ID_i);
    
    tmp1 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABDlong.mat'));
    tmp2 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABlong.mat'));
    tmp3 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logADlong.mat'));
    tmp4 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logBDlong.mat'));
    
    % keep only choice trials
    tmp1.logABDlong = keeponlychoice(tmp1.logABDlong);
    tmp2.logABlong = keeponlychoice(tmp2.logABlong);
    tmp3.logADlong = keeponlychoice(tmp3.logADlong);
    tmp4.logBDlong = keeponlychoice(tmp4.logBDlong);
            
    % All trials
    score_LH(ID_i,1) = sum(tmp1.logABDlong(:,7)) + sum(tmp2.logABlong(:,7)) + sum(tmp3.logADlong(:,7)) + sum(tmp4.logBDlong(:,7));
       
    %%% Same for first apple only %%%
    % All trials     
    it1 = tmp1.logABDlong(:,7);
    it1(tmp1.logABDlong(:,5)~=6) = []; %50
    
    it2 = tmp2.logABlong(:,7);
    it2(tmp2.logABlong(:,5)~=5) = []; %50
    
    it3 = tmp3.logADlong(:,7);
    it3(tmp3.logADlong(:,5)~=5) = []; %50
        
    it4 = tmp4.logBDlong(:,7);
    it4(tmp4.logBDlong(:,5)~=3) = []; %50
    
    first_apple_LH(ID_i,1) = sum(it1) + sum(it2) + sum(it3) + sum(it4); 

    score_LH_mean(ID_i,1) = score_LH(ID_i,1)/6;
    
    tmp1 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABDshort.mat'));
    tmp2 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABshort.mat'));
    tmp3 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logADshort.mat'));
    tmp4 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logBDshort.mat'));
    
    % keep only choice trials
    tmp1.logABDshort = keeponlychoice(tmp1.logABDshort);
    tmp2.logABshort = keeponlychoice(tmp2.logABshort);
    tmp3.logADshort = keeponlychoice(tmp3.logADshort);
    tmp4.logBDshort = keeponlychoice(tmp4.logBDshort);
  
    % All trials
    score_SH(ID_i,1) = sum(tmp1.logABDshort(:,7)) + sum(tmp2.logABshort(:,7)) + sum(tmp3.logADshort(:,7)) + sum(tmp4.logBDshort(:,7));

    trials_LH(ID_i,1) = (size(it1,1)+size(it2,1)+size(it3,1)+size(it4,1));
    
    if trials_LH(ID_i,1) ~= 200
        disp(strcat('participant', 32, int2str(ID), 32, 'has less trials in LH:', 32, num2str(trials_LH(ID_i,1)), 32, 'instead of 200'));
    end
    
    it1_SH = tmp1.logABDshort(:,7);
    it2_SH = tmp2.logABshort(:,7);
    it3_SH = tmp3.logADshort(:,7);
    it4_SH = tmp4.logBDshort(:,7);
    
    trials_SH(ID_i,1) = (size(it1_SH,1)+size(it2_SH,1)+size(it3_SH,1)+size(it4_SH,1));
    
    if trials_SH(ID_i,1) ~= 200
        disp(strcat('participant', 32, int2str(ID), 32, 'has less trials in SH:', 32, num2str(trials_SH(ID_i,1)), 32, 'instead of 200'));
    end
        
    average_first_apple_SH(ID_i,1) = score_SH(ID_i,1)/trials_SH(ID_i,1);
    average_first_apple_LH(ID_i,1) = first_apple_LH(ID_i,1)/trials_LH(ID_i,1);
    average_all_apple_LH(ID_i,1) = score_LH_mean(ID_i,1)/trials_LH(ID_i,1);
end

score_desc = [{'ID'} {'average_first_apple_SH'} {'average_first_apple_LH'} {'average_all_apple_LH'}];
score = [usermat_completed_task' average_first_apple_SH average_first_apple_LH average_all_apple_LH];

save(strcat(dir_save, 'score.mat'), 'score');
save(strcat(dir_save, 'score_desc.mat'), 'score_desc');

