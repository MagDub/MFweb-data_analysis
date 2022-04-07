addpath('./functions/')

load('../usermat_completed.mat')
data_fold = ('../../data/');
dir_data = (strcat(data_fold,'sanity_check/'));
dir_save = (strcat(data_fold,'data_for_figs/'));

n = size(usermat_completed,2);

score_LH = nan(n,1);
first_apple_LH = nan(n,1);
score_LH_mean = nan(n,1);
score_SH = nan(n,1);
trials_SH = nan(n,1);
trials_LH = nan(n,1);
average_first_apple_SH = nan(n,1);
average_first_apple_LH = nan(n,1);
average_all_apple_LH = nan(n,1);

load(strcat(dir_data, 'user_1/logs/logdesc.mat'));

for ID_i = 1:n
    
    ID = usermat_completed(ID_i);
    
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

    % logdesc{5} = sample
    % logdesc{6} = tree
    % logdesc{7} = size

    it1_score = tmp1.logABDlong(:,7);
    it1_score(tmp1.logABDlong(:,5)~=6) = []; %50

    it1_trees = tmp1.logABDlong(:,6);
    it1_trees(tmp1.logABDlong(:,5)~=6) = []; %50
    

    it2_score = tmp2.logABlong(:,7);
    it2_score(tmp2.logABlong(:,5)~=5) = []; %50

    it2_trees = tmp2.logABlong(:,6);
    it2_trees(tmp2.logABlong(:,5)~=5) = []; %50

    
    it3_score = tmp3.logADlong(:,7);
    it3_score(tmp3.logADlong(:,5)~=5) = []; %50

    it3_trees = tmp3.logADlong(:,6);
    it3_trees(tmp3.logADlong(:,5)~=5) = []; %50
        

    it4_score = tmp4.logBDlong(:,7);
    it4_score(tmp4.logBDlong(:,5)~=3) = []; %50

    it4_trees = tmp4.logBDlong(:,6);
    it4_trees(tmp4.logBDlong(:,5)~=3) = []; %50

    
    first_apple_LH(ID_i,1) = sum(it1_score) + sum(it2_score) + sum(it3_score) + sum(it4_score); % score
  

    % split depending on first tree selected
    A_score_LH_1st = mean([it1_score(it1_trees==1); it2_score(it2_trees==1); it3_score(it3_trees==1); it4_score(it4_trees==1)]);
    B_score_LH_1st = mean([it1_score(it1_trees==2); it2_score(it2_trees==2); it3_score(it3_trees==2); it4_score(it4_trees==2)]);
    C_score_LH_1st = mean([it1_score(it1_trees==3); it2_score(it2_trees==3); it3_score(it3_trees==3); it4_score(it4_trees==3)]);
    D_score_LH_1st = mean([it1_score(it1_trees==4); it2_score(it2_trees==4); it3_score(it3_trees==4); it4_score(it4_trees==4)]);




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

    trials_LH(ID_i,1) = (size(it1_score,1)+size(it2_score,1)+size(it3_score,1)+size(it4_score,1));
    
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
score = [usermat_completed' average_first_apple_SH average_first_apple_LH average_all_apple_LH];

save(strcat(dir_save, 'score.mat'), 'score');
save(strcat(dir_save, 'score_desc.mat'), 'score_desc');

score_SH = score(:,2);
first_LH = score(:,3);
score_LH = score(:,4);

save(strcat(dir_save,'score_SH.mat'), 'score_SH');
save(strcat(dir_save,'score_LH.mat'), 'score_LH');
save(strcat(dir_save,'first_LH.mat'), 'first_LH');

