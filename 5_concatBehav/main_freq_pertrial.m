addpath('./functions/')

load('../usermat_completed.mat')
data_fold = ('../../data/');
dir_data = (strcat(data_fold,'sanity_check/'));
dir_save = (strcat(data_fold,'data_for_figs/'));

Ntrials = 400;
n = size(usermat_completed,2);

% LH

disp('Per trial: Long horizon')

per_trial_freq_LH_400 = nan(n, Ntrials);

per_trial_freq_LH_A_400 = nan(n, Ntrials);
per_trial_freq_LH_B_400 = nan(n, Ntrials);
per_trial_freq_LH_C_400 = nan(n, Ntrials);
per_trial_freq_LH_D_400 = nan(n, Ntrials);

per_trial_freq_LH_A = nan(n, Ntrials/2);
per_trial_freq_LH_B = nan(n, Ntrials/2);
per_trial_freq_LH_C = nan(n, Ntrials/2);
per_trial_freq_LH_D = nan(n, Ntrials/2);

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
        it1 = tmp1.logABDlong(:,6); % selected tree
        it1(tmp1.logABDlong(:,5)~=6) = []; %50

        it2 = tmp2.logABlong(:,6);
        it2(tmp2.logABlong(:,5)~=5) = []; %50

        it3 = tmp3.logADlong(:,6);
        it3(tmp3.logADlong(:,5)~=5) = []; %50

        it4 = tmp4.logBDlong(:,6);
        it4(tmp4.logBDlong(:,5)~=3) = []; %50

        warning('off')
        it_all = [it1, it2, it3, it4];
        
        if ~isempty(it_all)
            per_trial_freq_LH_400(ID_i,trial_) = it_all; 
        end
        
        if it_all==1
            per_trial_freq_LH_A_400(ID_i,trial_) = 1; 
            per_trial_freq_LH_B_400(ID_i,trial_) = 0;
            per_trial_freq_LH_C_400(ID_i,trial_) = 0;
            per_trial_freq_LH_D_400(ID_i,trial_) = 0;
        elseif it_all==2
            per_trial_freq_LH_A_400(ID_i,trial_) = 0; 
            per_trial_freq_LH_B_400(ID_i,trial_) = 1; 
            per_trial_freq_LH_C_400(ID_i,trial_) = 0;
            per_trial_freq_LH_D_400(ID_i,trial_) = 0; 
        elseif it_all==3
            per_trial_freq_LH_A_400(ID_i,trial_) = 0; 
            per_trial_freq_LH_B_400(ID_i,trial_) = 0;
            per_trial_freq_LH_C_400(ID_i,trial_) = 1; 
            per_trial_freq_LH_D_400(ID_i,trial_) = 0;  
        elseif it_all==4
            per_trial_freq_LH_A_400(ID_i,trial_) = 0; 
            per_trial_freq_LH_B_400(ID_i,trial_) = 0;
            per_trial_freq_LH_C_400(ID_i,trial_) = 0;
            per_trial_freq_LH_D_400(ID_i,trial_) = 1; 
        end

    end
    
    tmp_A = per_trial_freq_LH_A_400(ID_i,:);
    tmp_B = per_trial_freq_LH_B_400(ID_i,:);
    tmp_C = per_trial_freq_LH_C_400(ID_i,:);
    tmp_D = per_trial_freq_LH_D_400(ID_i,:);
        
    tmp_A(isnan(tmp_A)) = []; 
    tmp_B(isnan(tmp_B)) = []; 
    tmp_C(isnan(tmp_C)) = [];
    tmp_D(isnan(tmp_D)) = [];
    
    for trial_=1:Ntrials/2 
         tmp_A_freq(trial_) = sum(tmp_A(1:trial_))/trial_;
         tmp_B_freq(trial_) = sum(tmp_B(1:trial_))/trial_;
         tmp_C_freq(trial_) = sum(tmp_C(1:trial_))/trial_;
         tmp_D_freq(trial_) = sum(tmp_D(1:trial_))/trial_;
    end
    
    per_trial_freq_LH_A(ID_i, :) = tmp_A_freq*100;
    per_trial_freq_LH_B(ID_i, :) = tmp_B_freq*100;
    per_trial_freq_LH_C(ID_i, :) = tmp_C_freq*100;
    per_trial_freq_LH_D(ID_i, :) = tmp_D_freq*100;
    
    tmp_all = per_trial_freq_LH_400(ID_i,:);
    tmp_all(isnan(tmp_all)) = []; 
    per_trial_LH_all_ABCD(ID_i, :) = tmp_all;

end




% SH

disp('Per trial: Short horizon')

per_trial_freq_SH_400 = nan(n, Ntrials);

per_trial_freq_SH_A_400 = nan(n, Ntrials);
per_trial_freq_SH_B_400 = nan(n, Ntrials);
per_trial_freq_SH_C_400 = nan(n, Ntrials);
per_trial_freq_SH_D_400 = nan(n, Ntrials);

per_trial_freq_SH_A = nan(n, Ntrials/2);
per_trial_freq_SH_B = nan(n, Ntrials/2);
per_trial_freq_SH_C = nan(n, Ntrials/2);
per_trial_freq_SH_D = nan(n, Ntrials/2);

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

        % Keep only 1st sample    
        it1 = tmp1.logABDshort(:,6); % selected tree
        it1(tmp1.logABDshort(:,5)~=6) = []; %50

        it2 = tmp2.logABshort(:,6);
        it2(tmp2.logABshort(:,5)~=5) = []; %50

        it3 = tmp3.logADshort(:,6);
        it3(tmp3.logADshort(:,5)~=5) = []; %50

        it4 = tmp4.logBDshort(:,6);
        it4(tmp4.logBDshort(:,5)~=3) = []; %50

        warning('off')
        it_all = [it1, it2, it3, it4];
        
        if ~isempty(it_all)
            per_trial_freq_SH_400(ID_i,trial_) = it_all; 
        end
        
        if it_all==1
            per_trial_freq_SH_A_400(ID_i,trial_) = 1; 
            per_trial_freq_SH_B_400(ID_i,trial_) = 0;
            per_trial_freq_SH_C_400(ID_i,trial_) = 0;
            per_trial_freq_SH_D_400(ID_i,trial_) = 0;
        elseif it_all==2
            per_trial_freq_SH_A_400(ID_i,trial_) = 0; 
            per_trial_freq_SH_B_400(ID_i,trial_) = 1; 
            per_trial_freq_SH_C_400(ID_i,trial_) = 0;
            per_trial_freq_SH_D_400(ID_i,trial_) = 0; 
        elseif it_all==3
            per_trial_freq_SH_A_400(ID_i,trial_) = 0; 
            per_trial_freq_SH_B_400(ID_i,trial_) = 0;
            per_trial_freq_SH_C_400(ID_i,trial_) = 1; 
            per_trial_freq_SH_D_400(ID_i,trial_) = 0;  
        elseif it_all==4
            per_trial_freq_SH_A_400(ID_i,trial_) = 0; 
            per_trial_freq_SH_B_400(ID_i,trial_) = 0;
            per_trial_freq_SH_C_400(ID_i,trial_) = 0;
            per_trial_freq_SH_D_400(ID_i,trial_) = 1; 
        end

    end
    
    tmp_A = per_trial_freq_SH_A_400(ID_i,:);
    tmp_B = per_trial_freq_SH_B_400(ID_i,:);
    tmp_C = per_trial_freq_SH_C_400(ID_i,:);
    tmp_D = per_trial_freq_SH_D_400(ID_i,:);
    
    tmp_A(isnan(tmp_A)) = []; 
    tmp_B(isnan(tmp_B)) = []; 
    tmp_C(isnan(tmp_C)) = [];
    tmp_D(isnan(tmp_D)) = [];
    
    
    for trial_=1:Ntrials/2 
         tmp_A_freq(trial_) = sum(tmp_A(1:trial_))/trial_;
         tmp_B_freq(trial_) = sum(tmp_B(1:trial_))/trial_;
         tmp_C_freq(trial_) = sum(tmp_C(1:trial_))/trial_;
         tmp_D_freq(trial_) = sum(tmp_D(1:trial_))/trial_;
    end
    
    per_trial_freq_SH_A(ID_i, :) = tmp_A_freq*100;
    per_trial_freq_SH_B(ID_i, :) = tmp_B_freq*100;
    per_trial_freq_SH_C(ID_i, :) = tmp_C_freq*100;
    per_trial_freq_SH_D(ID_i, :) = tmp_D_freq*100;
    
    tmp_all = per_trial_freq_SH_400(ID_i,:);
    tmp_all(isnan(tmp_all)) = []; 
    per_trial_SH_all_ABCD(ID_i, :) = tmp_all;

end
 
% mean(per_trial_freq_SH_C(:,end))
% mean(per_trial_freq_LH_C(:,end))


% Save

per_trial_freq_desc = ['ID' 'frequency over trial x'];

save(strcat(dir_save, 'per_trial_freq_desc.mat'), 'per_trial_freq_desc');

per_trial_SH_all_ABCD = [usermat_completed' per_trial_SH_all_ABCD];
per_trial_LH_all_ABCD = [usermat_completed' per_trial_LH_all_ABCD];

per_trial_freq_SH_A = [usermat_completed' per_trial_freq_SH_A];
per_trial_freq_SH_B = [usermat_completed' per_trial_freq_SH_B];
per_trial_freq_SH_C = [usermat_completed' per_trial_freq_SH_C];
per_trial_freq_SH_D = [usermat_completed' per_trial_freq_SH_D];

per_trial_freq_LH_A = [usermat_completed' per_trial_freq_LH_A];
per_trial_freq_LH_B = [usermat_completed' per_trial_freq_LH_B];
per_trial_freq_LH_C = [usermat_completed' per_trial_freq_LH_C];
per_trial_freq_LH_D = [usermat_completed' per_trial_freq_LH_D];

save(strcat(dir_save, 'per_trial_SH_all_ABCD.mat'), 'per_trial_SH_all_ABCD');
save(strcat(dir_save, 'per_trial_LH_all_ABCD.mat'), 'per_trial_LH_all_ABCD');

save(strcat(dir_save, 'per_trial_freq_SH_A.mat'), 'per_trial_freq_SH_A');
save(strcat(dir_save, 'per_trial_freq_LH_A.mat'), 'per_trial_freq_LH_A');

save(strcat(dir_save, 'per_trial_freq_SH_B.mat'), 'per_trial_freq_SH_B');
save(strcat(dir_save, 'per_trial_freq_LH_B.mat'), 'per_trial_freq_LH_B');

save(strcat(dir_save, 'per_trial_freq_SH_C.mat'), 'per_trial_freq_SH_C');
save(strcat(dir_save, 'per_trial_freq_LH_C.mat'), 'per_trial_freq_LH_C');

save(strcat(dir_save, 'per_trial_freq_SH_D.mat'), 'per_trial_freq_SH_D');
save(strcat(dir_save, 'per_trial_freq_LH_D.mat'), 'per_trial_freq_LH_D');

