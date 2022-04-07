addpath('./functions/')

load('../usermat_completed.mat')
data_fold = ('../../data/');
dir_data = (strcat(data_fold,'sanity_check/'));
dir_save = (strcat(data_fold,'data_for_figs/'));

n = size(usermat_completed,2);

load(strcat(dir_data, 'user_1/logs/logdesc.mat'));

score_LH_mean = nan(n,1);
score_LH_mean_A = nan(n,1);
score_LH_mean_B = nan(n,1);
score_LH_mean_C = nan(n,1);
score_LH_mean_D = nan(n,1);
score_LH_mean_H = nan(n,1);
score_LH_mean_M = nan(n,1);

score_26_LH_mean_A = nan(n,1);
score_26_LH_mean_B = nan(n,1);
score_26_LH_mean_C = nan(n,1);
score_26_LH_mean_D = nan(n,1);
score_26_LH_mean_H = nan(n,1);
score_26_LH_mean_M = nan(n,1);

score_16_LH_A = nan(n,5);
score_16_LH_B = nan(n,5);
score_16_LH_C = nan(n,5);
score_16_LH_D = nan(n,5);
score_16_LH_H = nan(n,5);
score_16_LH_M = nan(n,5);

Ntrials = 400;

for ID_i = 1:n
    
    ID = usermat_completed(ID_i);

    %%%%%% LONG HORIZON
    
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABDlong.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABlong.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logADlong.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logBDlong.mat'));

    % for each trial compute explore exploit
    isExploit_LH = nan(Ntrials,1);

    for trial_=1:Ntrials

        % select only trial
        tmpABD = logABDlong(logABDlong(:,2)==trial_,:);
        tmpAB = logABlong(logABlong(:,2)==trial_,:);
        tmpAD = logADlong(logADlong(:,2)==trial_,:);
        tmpBD = logBDlong(logBDlong(:,2)==trial_,:);
        
        % compute explore exploit and prior sample mean
        if ~isempty(tmpABD)
            isExploit_LH(trial_) = isExploitAB(tmpABD);
            prior_samp = keeppriorsamples(tmpABD);
        elseif ~isempty(tmpAB)
            isExploit_LH(trial_) = isExploitAB(tmpAB);
            prior_samp = keeppriorsamples(tmpAB);
        elseif ~isempty(tmpAD)
            isExploit_LH(trial_) = 1;
            prior_samp = keeppriorsamples(tmpAD);
        elseif ~isempty(tmpBD)
            isExploit_LH(trial_) = 2;
            prior_samp = keeppriorsamples(tmpBD);
        end

        if ~isnan(isExploit_LH(trial_))
            exploitation_value_LH_mean(trial_) = mean(prior_samp(prior_samp(:,6)==isExploit_LH(trial_),7));
            exploitation_value_LH_max(trial_) = max(prior_samp(prior_samp(:,6)==isExploit_LH(trial_),7));
        else 
            exploitation_value_LH_mean(trial_) = nan;
            exploitation_value_LH_max(trial_) = nan;
        end

    end

    % keep only choice trials
    logABDlong = keeponlychoice(logABDlong);
    logABlong = keeponlychoice(logABlong);
    logADlong = keeponlychoice(logADlong);
    logBDlong = keeponlychoice(logBDlong);
            
    % high and medium
    only_1stchoice = [logABDlong(logABDlong(:,5)==6,:); logABlong(logABlong(:,5)==5,:); logADlong(logADlong(:,5)==5,:); logBDlong(logBDlong(:,5)==3,:)];
    isExploit_LH(isnan(isExploit_LH))=[];
    exploitation_value_LH_mean(isnan(exploitation_value_LH_mean))=[];
    exploitation_value_LH_max(isnan(exploitation_value_LH_max))=[];
    only_choice_sorted = sortrows(only_1stchoice,2);
    only_choice_sorted_exp = [only_choice_sorted, isExploit_LH, exploitation_value_LH_mean', exploitation_value_LH_max'];

    % Split
    tmp_H_LH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == only_choice_sorted_exp(:,10), :);
    tmp_M_LH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) ~= only_choice_sorted_exp(:,10) & ...
                                                only_choice_sorted_exp(:,6) ~= 3 & ...
                                                only_choice_sorted_exp(:,6) ~= 4, :);
    
    tmp_A_LH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == 1, :);
    tmp_B_LH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == 2, :);
    tmp_C_LH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == 3, :);
    tmp_D_LH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == 4, :);

    %%% Mean sample of LH

    tmp_all_log = [logABDlong; logABlong; logADlong; logBDlong];
    tmp_26_log = [logABDlong(logABDlong(:,5)>=7,:); logABlong(logABlong(:,5)>=6,:); logADlong(logADlong(:,5)>=6,:); logBDlong(logBDlong(:,5)>=4,:)];
    tmp_2_log = [logABDlong(logABDlong(:,5)==7,:); logABlong(logABlong(:,5)==6,:); logADlong(logADlong(:,5)==6,:); logBDlong(logBDlong(:,5)==4,:)];
    tmp_3_log = [logABDlong(logABDlong(:,5)==8,:); logABlong(logABlong(:,5)==7,:); logADlong(logADlong(:,5)==7,:); logBDlong(logBDlong(:,5)==5,:)];
    tmp_4_log = [logABDlong(logABDlong(:,5)==9,:); logABlong(logABlong(:,5)==8,:); logADlong(logADlong(:,5)==8,:); logBDlong(logBDlong(:,5)==6,:)];
    tmp_5_log = [logABDlong(logABDlong(:,5)==10,:); logABlong(logABlong(:,5)==9,:); logADlong(logADlong(:,5)==9,:); logBDlong(logBDlong(:,5)==7,:)];
    tmp_6_log = [logABDlong(logABDlong(:,5)==11,:); logABlong(logABlong(:,5)==10,:); logADlong(logADlong(:,5)==10,:); logBDlong(logBDlong(:,5)==8,:)];

    % sometimes some later LH draw are missing, 
    % we remove thos participants to not bias the average on the LH
    
    if ID_i ~= 31 && ID_i ~= 148 && ID_i ~= 176

        % All
        score_LH_mean(ID_i,1) = sum(tmp_all_log(:,7))/(6*200);
    
        % Per bandit average over 6 draws
        score_LH_mean_A(ID_i,1) = sum(tmp_all_log(ismember(tmp_all_log(:,2), tmp_A_LH(:,2)),7))/(6*size(tmp_A_LH,1));
        score_LH_mean_B(ID_i,1) = sum(tmp_all_log(ismember(tmp_all_log(:,2), tmp_B_LH(:,2)),7))/(6*size(tmp_B_LH,1));
        score_LH_mean_C(ID_i,1) = sum(tmp_all_log(ismember(tmp_all_log(:,2), tmp_C_LH(:,2)),7))/(6*size(tmp_C_LH,1));
        score_LH_mean_D(ID_i,1) = sum(tmp_all_log(ismember(tmp_all_log(:,2), tmp_D_LH(:,2)),7))/(6*size(tmp_D_LH,1));
        score_LH_mean_H(ID_i,1) = sum(tmp_all_log(ismember(tmp_all_log(:,2), tmp_H_LH(:,2)),7))/(6*size(tmp_H_LH,1));
        score_LH_mean_M(ID_i,1) = sum(tmp_all_log(ismember(tmp_all_log(:,2), tmp_M_LH(:,2)),7))/(6*size(tmp_M_LH,1));
    
        % Per bandit average over last 5 draws
        score_26_LH_mean_A(ID_i,1) = sum(tmp_26_log(ismember(tmp_26_log(:,2), tmp_A_LH(:,2)),7))/(5*size(tmp_A_LH,1));
        score_26_LH_mean_B(ID_i,1) = sum(tmp_26_log(ismember(tmp_26_log(:,2), tmp_B_LH(:,2)),7))/(5*size(tmp_B_LH,1));
        score_26_LH_mean_C(ID_i,1) = sum(tmp_26_log(ismember(tmp_26_log(:,2), tmp_C_LH(:,2)),7))/(5*size(tmp_C_LH,1));
        score_26_LH_mean_D(ID_i,1) = sum(tmp_26_log(ismember(tmp_26_log(:,2), tmp_D_LH(:,2)),7))/(5*size(tmp_D_LH,1));
        score_26_LH_mean_H(ID_i,1) = sum(tmp_26_log(ismember(tmp_26_log(:,2), tmp_H_LH(:,2)),7))/(5*size(tmp_H_LH,1));
        score_26_LH_mean_M(ID_i,1) = sum(tmp_26_log(ismember(tmp_26_log(:,2), tmp_M_LH(:,2)),7))/(5*size(tmp_M_LH,1));
    
        % extract samples
        smp_A = ismember(tmp_2_log(:,2), tmp_A_LH(:,2));
        smp_B = ismember(tmp_2_log(:,2), tmp_B_LH(:,2));
        smp_C = ismember(tmp_2_log(:,2), tmp_C_LH(:,2));
        smp_D = ismember(tmp_2_log(:,2), tmp_D_LH(:,2));
        smp_H = ismember(tmp_2_log(:,2), tmp_H_LH(:,2));
        smp_M = ismember(tmp_2_log(:,2), tmp_M_LH(:,2));
    
        % Per bandit average over each draw
        reward_25_all = [tmp_2_log(:,7), tmp_3_log(:,7), tmp_4_log(:,7), tmp_5_log(:,7), tmp_6_log(:,7)];
    
        score_16_LH_A(ID_i,:) = sum(reward_25_all(smp_A,:),1)./(size(tmp_A_LH,1));
        score_16_LH_B(ID_i,:) = sum(reward_25_all(smp_B,:),1)./(size(tmp_B_LH,1));
        score_16_LH_C(ID_i,:) = sum(reward_25_all(smp_C,:),1)./(size(tmp_C_LH,1));
        score_16_LH_D(ID_i,:) = sum(reward_25_all(smp_D,:),1)./(size(tmp_D_LH,1));
        
        if max(score_16_LH_D(ID_i,:)) > 10
            disp(ID_i)
        end
        
        score_16_LH_H(ID_i,:) = sum(reward_25_all(smp_H,:))./(size(tmp_H_LH,1));
        score_16_LH_M(ID_i,:) = sum(reward_25_all(smp_M,:))./(size(tmp_M_LH,1));

    end

    %%% 1st sample of LH

    tmp_1st_log = [logABDlong(logABDlong(:,5)==6,:); logABlong(logABlong(:,5)==5,:); logADlong(logADlong(:,5)==5,:); logBDlong(logBDlong(:,5)==3,:)];

    % All
    score_LH_first(ID_i,1) = mean(tmp_1st_log(:,7));

    % extract trial per bandit
    A_is_chosen_LH = [sortrows(tmp_1st_log(ismember(tmp_1st_log(:,2), tmp_A_LH(:,2)),:),2), tmp_A_LH(:,11:12)];
    B_is_chosen_LH = [sortrows(tmp_1st_log(ismember(tmp_1st_log(:,2), tmp_B_LH(:,2)),:),2), tmp_B_LH(:,11:12)];
    C_is_chosen_LH = [sortrows(tmp_1st_log(ismember(tmp_1st_log(:,2), tmp_C_LH(:,2)),:),2), tmp_C_LH(:,11:12)];
    D_is_chosen_LH = [sortrows(tmp_1st_log(ismember(tmp_1st_log(:,2), tmp_D_LH(:,2)),:),2), tmp_D_LH(:,11:12)];
    H_is_chosen_LH = [sortrows(tmp_1st_log(ismember(tmp_1st_log(:,2), tmp_H_LH(:,2)),:),2), tmp_H_LH(:,11:12)];
    M_is_chosen_LH = [sortrows(tmp_1st_log(ismember(tmp_1st_log(:,2), tmp_M_LH(:,2)),:),2), tmp_M_LH(:,11:12)];

    % Score per bandit and value of exploitation option (mean and max)
    score_LH_first_A(ID_i,:) = mean(A_is_chosen_LH(:,[7,10,11]));
    score_LH_first_B(ID_i,:) = mean(B_is_chosen_LH(:,[7,10,11]));
    score_LH_first_C(ID_i,:) = mean(C_is_chosen_LH(:,[7,10,11]));
    score_LH_first_D(ID_i,:) = mean(D_is_chosen_LH(:,[7,10,11]));
    score_LH_first_H(ID_i,:) = mean(H_is_chosen_LH(:,[7,10,11]));
    score_LH_first_M(ID_i,:) = mean(M_is_chosen_LH(:,[7,10,11]));

    %%%%%% SHORT HORIZON

    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABDshort.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABshort.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logADshort.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logBDshort.mat'));

    
    % for each trial compute explore exploit
    isExploit_SH = nan(Ntrials,1);

    for trial_=1:Ntrials

        % select only trial
        tmpABD = logABDshort(logABDshort(:,2)==trial_,:);
        tmpAB = logABshort(logABshort(:,2)==trial_,:);
        tmpAD = logADshort(logADshort(:,2)==trial_,:);
        tmpBD = logBDshort(logBDshort(:,2)==trial_,:);
        
        % compute explore exploit
        if ~isempty(tmpABD)
            isExploit_SH(trial_) = isExploitAB(tmpABD);
            prior_samp = keeppriorsamples(tmpABD);
        elseif ~isempty(tmpAB)
            isExploit_SH(trial_) = isExploitAB(tmpAB);
            prior_samp = keeppriorsamples(tmpAB);
        elseif ~isempty(tmpAD)
            isExploit_SH(trial_) = 1;
            prior_samp = keeppriorsamples(tmpAD);
        elseif ~isempty(tmpBD)
            isExploit_SH(trial_) = 2;
            prior_samp = keeppriorsamples(tmpBD);
        end

        if ~isnan(isExploit_SH(trial_))
            exploitation_value_SH_mean(trial_) = mean(prior_samp(prior_samp(:,6)==isExploit_SH(trial_),7));
            exploitation_value_SH_max(trial_) = max(prior_samp(prior_samp(:,6)==isExploit_SH(trial_),7));
        else 
            exploitation_value_SH_mean(trial_) = nan;
            exploitation_value_SH_max(trial_) = nan;
        end
    end


    % keep only choice trials
    logABDshort = keeponlychoice(logABDshort);
    logABshort = keeponlychoice(logABshort);
    logADshort = keeponlychoice(logADshort);
    logBDshort = keeponlychoice(logBDshort);
            
    % high and medium
    only_1stchoice = [logABDshort; logABshort; logADshort; logBDshort];
    isExploit_SH(isnan(isExploit_SH))=[];
    exploitation_value_SH_mean(isnan(exploitation_value_SH_mean))=[];
    exploitation_value_SH_max(isnan(exploitation_value_SH_max))=[];
    only_choice_sorted = sortrows(only_1stchoice,2);
    only_choice_sorted_exp = [only_choice_sorted, isExploit_SH, exploitation_value_SH_mean', exploitation_value_SH_max'];

    % Split
    tmp_H_SH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == only_choice_sorted_exp(:,10),:);
    tmp_M_SH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) ~= only_choice_sorted_exp(:,10) & ...
                                                only_choice_sorted_exp(:,6) ~= 3 & ...
                                                only_choice_sorted_exp(:,6) ~= 4,:);
    
    tmp_A_SH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == 1, :);
    tmp_B_SH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == 2, :);
    tmp_C_SH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == 3, :);
    tmp_D_SH = only_choice_sorted_exp(only_choice_sorted_exp(:,6) == 4, :);


    %%% 1st sample SH

    % All
    score_SH(ID_i,1) = mean(only_1stchoice(:,7));

    % extract trial per bandit
    A_is_chosen_SH = [sortrows(only_1stchoice(ismember(only_1stchoice(:,2), tmp_A_SH(:,2)),:),2), tmp_A_SH(:,11:12)];
    B_is_chosen_SH = [sortrows(only_1stchoice(ismember(only_1stchoice(:,2), tmp_B_SH(:,2)),:),2), tmp_B_SH(:,11:12)];
    C_is_chosen_SH = [sortrows(only_1stchoice(ismember(only_1stchoice(:,2), tmp_C_SH(:,2)),:),2), tmp_C_SH(:,11:12)];
    D_is_chosen_SH = [sortrows(only_1stchoice(ismember(only_1stchoice(:,2), tmp_D_SH(:,2)),:),2), tmp_D_SH(:,11:12)];
    H_is_chosen_SH = [sortrows(only_1stchoice(ismember(only_1stchoice(:,2), tmp_H_SH(:,2)),:),2), tmp_H_SH(:,11:12)];
    M_is_chosen_SH = [sortrows(only_1stchoice(ismember(only_1stchoice(:,2), tmp_M_SH(:,2)),:),2), tmp_M_SH(:,11:12)];

    % Score per bandit and value of exploitation option (mean and max)
    score_SH_A(ID_i,:) = mean(A_is_chosen_SH(:,[7,10,11]));
    score_SH_B(ID_i,:) = mean(B_is_chosen_SH(:,[7,10,11]));
    score_SH_C(ID_i,:) = mean(C_is_chosen_SH(:,[7,10,11]));
    score_SH_D(ID_i,:) = mean(D_is_chosen_SH(:,[7,10,11]));
    score_SH_H(ID_i,:) = mean(H_is_chosen_SH(:,[7,10,11]));
    score_SH_M(ID_i,:) = mean(M_is_chosen_SH(:,[7,10,11]));

    % save freqs
    score_freq_A(ID_i,:) = [size(tmp_A_SH,1), size(tmp_A_LH,1)];
    score_freq_B(ID_i,:) = [size(tmp_B_SH,1), size(tmp_B_LH,1)];
    score_freq_C(ID_i,:) = [size(tmp_C_SH,1), size(tmp_C_LH,1)];
    score_freq_D(ID_i,:) = [size(tmp_D_SH,1), size(tmp_D_LH,1)];
    score_freq_H(ID_i,:) = [size(tmp_H_SH,1), size(tmp_H_LH,1)];
    score_freq_M(ID_i,:) = [size(tmp_M_SH,1), size(tmp_M_LH,1)];
    

end

score_freq_desc = {'SH', 'LH'};
score_all = [usermat_completed' score_SH score_LH_first score_LH_mean];

score_desc = {'ID', 'SH', 'SH_exploi_mean', 'SH_exploi_max', 'LH_first', 'LH_exploi_mean', 'LH_exploi_max', ...
                'LH_all', 'LH_26', 'LH_2','LH_3', 'LH_4', 'LH_5', 'LH_6'};

score_A = [usermat_completed' score_SH_A score_LH_first_A score_LH_mean_A score_26_LH_mean_A score_16_LH_A];
score_B = [usermat_completed' score_SH_B score_LH_first_B score_LH_mean_B score_26_LH_mean_B score_16_LH_B];
score_C = [usermat_completed' score_SH_C score_LH_first_C score_LH_mean_C score_26_LH_mean_C score_16_LH_C];
score_D = [usermat_completed' score_SH_D score_LH_first_D score_LH_mean_D score_26_LH_mean_D score_16_LH_D];
score_H = [usermat_completed' score_SH_H score_LH_first_H score_LH_mean_H score_26_LH_mean_H score_16_LH_H];
score_M = [usermat_completed' score_SH_M score_LH_first_M score_LH_mean_M score_26_LH_mean_M score_16_LH_M];
   
save(strcat(dir_save, 'score_desc.mat'), 'score_desc');

save(strcat(dir_save, 'score_A.mat'), 'score_A');
save(strcat(dir_save, 'score_B.mat'), 'score_B');
save(strcat(dir_save, 'score_C.mat'), 'score_C');
save(strcat(dir_save, 'score_D.mat'), 'score_D');

save(strcat(dir_save, 'score_H.mat'), 'score_H');
save(strcat(dir_save, 'score_M.mat'), 'score_M');

save(strcat(dir_save, 'score_freq_A.mat'), 'score_freq_A');
save(strcat(dir_save, 'score_freq_B.mat'), 'score_freq_B');
save(strcat(dir_save, 'score_freq_C.mat'), 'score_freq_C');
save(strcat(dir_save, 'score_freq_D.mat'), 'score_freq_D');
save(strcat(dir_save, 'score_freq_H.mat'), 'score_freq_H');
save(strcat(dir_save, 'score_freq_M.mat'), 'score_freq_M');

save(strcat(dir_save, 'score_freq_desc.mat'), 'score_freq_desc');



