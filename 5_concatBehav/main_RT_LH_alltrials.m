
load('../usermat_completed.mat')
data_fold = ('../../data/');
dir_data = (strcat(data_fold,'sanity_check/'));
dir_save = (strcat(data_fold,'data_for_figs/'));

n = size(usermat_completed,2);

for ID_i = 1:n
    
    ID = usermat_completed(ID_i);
    
    disp(strcat('User_ID=', num2str(ID)));
    
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logdesc.mat'));
    
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABDlong_all.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/mat_ABD.mat'));
    
    mat_ABD_LH = mat_ABD(find(mat_ABD(:,3)==11),:);
    
    mat_ABD_LH_all = nan(size(mat_ABD_LH,1),size(mat_ABD_LH,2)+5);
    
    for i = 1:size(mat_ABD_LH,1)
    
        tmp_b = mat_ABD_LH(i,1);
        tmp_i = mat_ABD_LH(i,2);

        ind = find((logABDlong_all(:,1)==tmp_b)&(logABDlong_all(:,2)==tmp_i)&(logABDlong_all(:,11)>0));
        
        mat_ABD_LH_all(i,:) = [mat_ABD_LH(i,:) logABDlong_all(ind(2:end), 11)'];
    
    end
    
    mean_ABD_LH(ID_i, :) = mean(mat_ABD_LH_all(:,end-5:end),1);
   
end

for ID_i = 1:n
    
    ID = usermat_completed(ID_i);
    
    disp(strcat('User_ID=', num2str(ID)));
    
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logdesc.mat'));
    
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logABlong_all.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/mat_AB.mat'));
    
    mat_AB_LH = mat_AB(find(mat_AB(:,3)==11),:);
    
    mat_AB_LH_all = nan(size(mat_AB_LH,1),size(mat_AB_LH,2)+5);
    
    for i = 1:size(mat_AB_LH,1)
    
        tmp_b = mat_AB_LH(i,1);
        tmp_i = mat_AB_LH(i,2);

        ind = find((logABlong_all(:,1)==tmp_b)&(logABlong_all(:,2)==tmp_i)&(logABlong_all(:,11)>0));
        
        mat_AB_LH_all(i,:) = [mat_AB_LH(i,:) logABlong_all(ind(2:end), 11)'];
    
    end
    
    mean_AB_LH(ID_i, :) = mean(mat_AB_LH_all(:,end-5:end),1);
   
end

for ID_i = 1:n
    
    ID = usermat_completed(ID_i);
    
    disp(strcat('User_ID=', num2str(ID)));
    
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logdesc.mat'));
    
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logADlong_all.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/mat_AD.mat'));
    
    mat_AD_LH = mat_AD(find(mat_AD(:,3)==11),:);
    
    mat_AD_LH_all = nan(size(mat_AD_LH,1),size(mat_AD_LH,2)+5);
    
    for i = 1:size(mat_AD_LH,1)
    
        tmp_b = mat_AD_LH(i,1);
        tmp_i = mat_AD_LH(i,2);

        ind = find((logADlong_all(:,1)==tmp_b)&(logADlong_all(:,2)==tmp_i)&(logADlong_all(:,11)>0));
        
        mat_AD_LH_all(i,:) = [mat_AD_LH(i,:) logADlong_all(ind(2:end), 11)'];
    
    end
    
    mean_AD_LH(ID_i, :) = mean(mat_AD_LH_all(:,end-5:end),1);
   
end

for ID_i = 1:n
    
    ID = usermat_completed(ID_i);
    
    disp(strcat('User_ID=', num2str(ID)));
    
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logdesc.mat'));
    
    load(strcat(dir_data, 'user_',num2str(ID),'/logs/logBDlong.mat'));
    load(strcat(dir_data, 'user_',num2str(ID),'/mat_BD.mat'));
    
    mat_BD_LH = mat_BD(find(mat_BD(:,3)==11),:);
    
    mat_BD_LH_all = nan(size(mat_BD_LH,1),size(mat_BD_LH,2)+5);
    
    for i = 1:size(mat_BD_LH,1)
    
        tmp_b = mat_BD_LH(i,1);
        tmp_i = mat_BD_LH(i,2);

        ind = find((logBDlong(:,1)==tmp_b)&(logBDlong(:,2)==tmp_i)&(logBDlong(:,8)>0));
        
        mat_BD_LH_all(i,:) = [mat_BD_LH(i,:) logBDlong(ind(2:end), 8)'];
    
    end
    
    mean_BD_LH(ID_i, :) = mean(mat_BD_LH_all(:,end-5:end),1);
   
end



RT_all_LH = (mean_ABD_LH + mean_AB_LH + mean_BD_LH + mean_AD_LH)/4;
RT_all_LH_desc = {'LH_sample1', 'LH_sample2', 'LH_sample3', 'LH_sample4', 'LH_sample5', 'LH_sample6'};

save(strcat(dir_save, 'RT_all_LH.mat'), 'RT_all_LH');
save(strcat(dir_save, 'RT_all_LH_desc.mat'), 'RT_all_LH_desc');



