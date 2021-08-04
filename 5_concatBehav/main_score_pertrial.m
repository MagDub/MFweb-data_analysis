addpath('./functions/')

load('../usermat_completed.mat')
data_fold = ('../../data/');
dir_data = (strcat(data_fold,'sanity_check/'));
dir_save = (strcat(data_fold,'data_for_figs/'));

Ntrials = 400;

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

% LH all trials

disp('Per trial: Long horizon, all')

per_trial_all_LH_400trials = nan(n, Ntrials);
per_trial_all_LH = nan(n, Ntrials/2);

for ID_i = 1:n 
    
    ID = usermat_completed(ID_i);
    
    disp(strcat('User_ID=', num2str(ID)));
        
    for trial_=1:Ntrials
        
        tmp1 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABDlong.mat'));
        tmp2 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABlong.mat'));
        tmp3 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logADlong.mat'));
        tmp4 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logBDlong.mat'));

        % select only trial
        tmp1.logABDlong(tmp1.logABDlong(:,2)~=trial_,:)=[];
        tmp2.logABlong(tmp2.logABlong(:,2)~=trial_,:)=[];
        tmp3.logADlong(tmp3.logADlong(:,2)~=trial_,:)=[];
        tmp4.logBDlong(tmp4.logBDlong(:,2)~=trial_,:)=[];

        % keep only choice trials
        tmp1.logABDlong = keeponlychoice(tmp1.logABDlong);
        tmp2.logABlong = keeponlychoice(tmp2.logABlong);
        tmp3.logADlong = keeponlychoice(tmp3.logADlong);
        tmp4.logBDlong = keeponlychoice(tmp4.logBDlong);

        % All trials
        score_LH(ID_i,trial_) = sum(tmp1.logABDlong(:,7)) + sum(tmp2.logABlong(:,7)) + sum(tmp3.logADlong(:,7)) + sum(tmp4.logBDlong(:,7));

        % Mean per draw
        per_trial_all_LH_400trials(ID_i,trial_) = score_LH(ID_i,trial_)/6;

    end
    
    tmp_ = per_trial_all_LH_400trials(ID_i,:);
    tmp_(tmp_==0) = [];
    per_trial_all_LH(ID_i, :) = tmp_;

end


% LH 1st sample

disp('Per trial: Long horizon, 1st')

per_trial_first_LH_400trials = nan(n, Ntrials);
per_trial_first_LH = nan(n, Ntrials/2);

for ID_i = 1:n 
    
    ID = usermat_completed(ID_i);
    
    disp(strcat('User_ID=', num2str(ID)));
        
    for trial_=1:Ntrials
        
        tmp1 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABDlong.mat'));
        tmp2 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABlong.mat'));
        tmp3 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logADlong.mat'));
        tmp4 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logBDlong.mat'));

        % select only trial
        tmp1.logABDlong(tmp1.logABDlong(:,2)~=trial_,:)=[];
        tmp2.logABlong(tmp2.logABlong(:,2)~=trial_,:)=[];
        tmp3.logADlong(tmp3.logADlong(:,2)~=trial_,:)=[];
        tmp4.logBDlong(tmp4.logBDlong(:,2)~=trial_,:)=[];

        % keep only choice trials
        tmp1.logABDlong = keeponlychoice(tmp1.logABDlong);
        tmp2.logABlong = keeponlychoice(tmp2.logABlong);
        tmp3.logADlong = keeponlychoice(tmp3.logADlong);
        tmp4.logBDlong = keeponlychoice(tmp4.logBDlong);

        % Keep only 1st sample    
        it1 = tmp1.logABDlong(:,7);
        it1(tmp1.logABDlong(:,5)~=6) = []; %50

        it2 = tmp2.logABlong(:,7);
        it2(tmp2.logABlong(:,5)~=5) = []; %50

        it3 = tmp3.logADlong(:,7);
        it3(tmp3.logADlong(:,5)~=5) = []; %50

        it4 = tmp4.logBDlong(:,7);
        it4(tmp4.logBDlong(:,5)~=3) = []; %50

        per_trial_first_LH_400trials(ID_i,trial_) = sum(it1) + sum(it2) + sum(it3) + sum(it4); 

    end
    
    tmp_ = per_trial_first_LH_400trials(ID_i,:);
    tmp_(tmp_==0) = [];
    per_trial_first_LH(ID_i, :) = tmp_;

end


% SH 

disp('Per trial: Short horizon')

per_trial_score_SH_400trials = nan(n, Ntrials);
per_trial_score_SH = nan(n, Ntrials/2);

for ID_i = 1:n 
    
    ID = usermat_completed(ID_i);
    
    disp(strcat('User_ID=', num2str(ID)));
        
    for trial_=1:Ntrials

        tmp1 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABDshort.mat'));
        tmp2 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABshort.mat'));
        tmp3 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logADshort.mat'));
        tmp4 = load(strcat(dir_data, 'user_',num2str(ID),'/logs/logBDshort.mat'));

        % select only trial
        tmp1.logABDshort(tmp1.logABDshort(:,2)~=trial_,:)=[];
        tmp2.logABshort(tmp2.logABshort(:,2)~=trial_,:)=[];
        tmp3.logADshort(tmp3.logADshort(:,2)~=trial_,:)=[];
        tmp4.logBDshort(tmp4.logBDshort(:,2)~=trial_,:)=[];

        % keep only choice trials
        tmp1.logABDshort = keeponlychoice(tmp1.logABDshort);
        tmp2.logABshort = keeponlychoice(tmp2.logABshort);
        tmp3.logADshort = keeponlychoice(tmp3.logADshort);
        tmp4.logBDshort = keeponlychoice(tmp4.logBDshort);
 
        % All trials
        per_trial_score_SH_400trials(ID_i,trial_) = sum(tmp1.logABDshort(:,7)) + sum(tmp2.logABshort(:,7)) + sum(tmp3.logADshort(:,7)) + sum(tmp4.logBDshort(:,7));
        
    end
    
    tmp_ = per_trial_score_SH_400trials(ID_i,:);
    tmp_(tmp_==0) = [];
    per_trial_score_SH(ID_i, :) = tmp_;
    
end


% Save

% LH all
per_trial_score_desc = [ {'ID'} {'trials'} ];
per_trial_score = [usermat_completed' per_trial_all_LH];

save(strcat(dir_save, 'per_trial_score_LH_all_desc.mat'), 'per_trial_score_desc');
save(strcat(dir_save, 'per_trial_score_LH_all.mat'), 'per_trial_score');

clear per_trial_score;

% LH first
per_trial_score = [usermat_completed' per_trial_first_LH];

save(strcat(dir_save, 'per_trial_score_LH_1st_desc.mat'), 'per_trial_score_desc');
save(strcat(dir_save, 'per_trial_score_LH_1st.mat'), 'per_trial_score');

clear per_trial_score;

% SH
per_trial_score = [usermat_completed' per_trial_score_SH];

save(strcat(dir_save, 'per_trial_score_SH_desc.mat'), 'per_trial_score_desc');
save(strcat(dir_save, 'per_trial_score_SH.mat'), 'per_trial_score');

