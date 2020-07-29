addpath('./functions/')

picked_tree_mat = [];
picked_tree_mat_desc = {'gameIDs', 'PickedLH_1', 'PickedLH_2', 'PickedSH_1', 'PickedSH_2'};

data_fold = ('../../data/');
load(strcat(data_fold,'sanity_check/user_2/logs/logdesc.mat'))

col_gameID=4;
col_sample=5;
col_pickedtree=6;

consistency_mat_desc = {'gameID' 'LHisConsistent' 'SHisConsistent'};
consistency_freq_desc = {'LH_Consistent' 'SH_Consistent', 'ID'};

load('../usermat_completed_task.mat')

consistency_freq = nan(size(usermat_completed_task,2),2);

for ID_i=1:size(usermat_completed_task,2)
    
    ID = usermat_completed_task(ID_i);
        
    % AB

    load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logABlong.mat'))
    load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logABshort.mat'))

    logABlongfirstapp = logABlong(logABlong(:,col_sample)==5,:);
    gameIDs_AB = unique(logABshort(:,col_gameID));

    for i=1:size(gameIDs_AB,1)
        tmpLH=find(logABlongfirstapp(:,col_gameID)==gameIDs_AB(i));
        tmpSH=find(logABshort(:,col_gameID)==gameIDs_AB(i));
        picked_tree_mat(end+1,:) = [gameIDs_AB(i) logABlongfirstapp(tmpLH(1),col_pickedtree) logABlongfirstapp(tmpLH(2),col_pickedtree) logABshort(tmpSH(1),col_pickedtree) logABshort(tmpSH(2),col_pickedtree)];
    end

    % ABD

    load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logABDlong.mat'))
    load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logABDshort.mat'))

    logABDlongfirstapp = logABDlong(logABDlong(:,col_sample)==6,:);
    gameIDs_ABD = unique(logABDshort(:,col_gameID));

    for i=1:size(gameIDs_ABD,1)
        tmpLH=find(logABDlongfirstapp(:,col_gameID)==gameIDs_ABD(i));
        tmpSH=find(logABDshort(:,col_gameID)==gameIDs_ABD(i));
        picked_tree_mat(end+1,:) = [gameIDs_ABD(i) logABDlongfirstapp(tmpLH(1),col_pickedtree) logABDlongfirstapp(tmpLH(2),col_pickedtree) logABDshort(tmpSH(1),col_pickedtree) logABDshort(tmpSH(2),col_pickedtree)];
    end

    % AD

    load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logADlong.mat'))
    load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logADshort.mat'))

    logADlongfirstapp = logADlong(logADlong(:,col_sample)==5,:);
    gameIDs_AD = unique(logADshort(:,col_gameID));

    for i=1:size(gameIDs_AD,1)
        tmpLH=find(logADlongfirstapp(:,col_gameID)==gameIDs_AD(i));
        tmpSH=find(logADshort(:,col_gameID)==gameIDs_AD(i));
        picked_tree_mat(end+1,:) = [gameIDs_AD(i) logADlongfirstapp(tmpLH(1),col_pickedtree) logADlongfirstapp(tmpLH(2),col_pickedtree) logADshort(tmpSH(1),col_pickedtree) logADshort(tmpSH(2),col_pickedtree)];
    end

    % BD

    load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logBDlong.mat'))
    load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logBDshort.mat'))

    logBDlongfirstapp = logBDlong(logBDlong(:,col_sample)==3,:);
    gameIDs_BD = unique(logBDshort(:,col_gameID));

    for i=1:size(gameIDs_BD,1)
        tmpLH=find(logBDlongfirstapp(:,col_gameID)==gameIDs_BD(i));
        tmpSH=find(logBDshort(:,col_gameID)==gameIDs_BD(i));
        picked_tree_mat(end+1,:) = [gameIDs_BD(i) logBDlongfirstapp(tmpLH(1),col_pickedtree) logBDlongfirstapp(tmpLH(2),col_pickedtree) logBDshort(tmpSH(1),col_pickedtree) logBDshort(tmpSH(2),col_pickedtree)];
    end

    % picked_tree_mat = [subject, pickedLH, pickedLH, pickedSH, pickedSH]
    
    consistentSH = zeros(1,100);
    consistentLH = zeros(1,100);
    
    consistentLH_A = zeros(1,100);
    consistentLH_B = zeros(1,100);
    consistentLH_C = zeros(1,100);
    consistentLH_D = zeros(1,100);
    
    consistentSH_A = zeros(1,100);
    consistentSH_B = zeros(1,100);
    consistentSH_C = zeros(1,100);
    consistentSH_D = zeros(1,100);
    
    for i=1:size(picked_tree_mat,1)

        if picked_tree_mat(i,2) == picked_tree_mat(i,3)
            
            consistentLH(i) = 1;
            
            if picked_tree_mat(i,2) == 1
               consistentLH_A(i) = 1; 
            elseif picked_tree_mat(i,2) == 2
               consistentLH_B(i) = 1; 
            elseif picked_tree_mat(i,2) == 3
               consistentLH_C(i) = 1; 
            elseif picked_tree_mat(i,2) == 4
               consistentLH_D(i) = 1; 
            end
        end

        if picked_tree_mat(i,4) == picked_tree_mat(i,5)
            
            consistentSH(i) = 1;
            
            if picked_tree_mat(i,4) == 1
               consistentSH_A(i) = 1; 
            elseif picked_tree_mat(i,4) == 2
               consistentSH_B(i) = 1; 
            elseif picked_tree_mat(i,4) == 3
               consistentSH_C(i) = 1; 
            elseif picked_tree_mat(i,4) == 4
               consistentSH_D(i) = 1; 
            end
        end
    end

    consistency_mat = [picked_tree_mat(:,1) consistentLH' consistentSH'];
    consistency_A_mat = [picked_tree_mat(:,1) consistentLH_A' consistentSH_A'];
    consistency_B_mat = [picked_tree_mat(:,1) consistentLH_B' consistentSH_B'];
    consistency_C_mat = [picked_tree_mat(:,1) consistentLH_C' consistentSH_C'];
    consistency_D_mat = [picked_tree_mat(:,1) consistentLH_D' consistentSH_D'];
    
    % LH / SH
    consistency_freq(ID_i,:) = [sum(consistency_mat(:,2:3),1)./size(consistency_mat,1)*100];
    consistency_A_freq(ID_i,:) = [sum(consistency_A_mat(:,2:3),1)./size(consistency_A_mat,1)*100];
    consistency_B_freq(ID_i,:) = [sum(consistency_B_mat(:,2:3),1)./size(consistency_B_mat,1)*100];
    consistency_C_freq(ID_i,:) = [sum(consistency_C_mat(:,2:3),1)./size(consistency_C_mat,1)*100];
    consistency_D_freq(ID_i,:) = [sum(consistency_D_mat(:,2:3),1)./size(consistency_D_mat,1)*100];
    
    picked_tree_mat = [];
            
end

sum_LH = consistency_A_freq(:,1)+consistency_B_freq(:,1)+consistency_C_freq(:,1)+consistency_D_freq(:,1);

tmp = (sum_LH == round(consistency_freq(:,1)));
if sum(double(sum_LH == round(consistency_freq(:,1))))~=size(consistency_freq(:,1),1)
    disp('consistency mismatch')
end

consistency_freq = [consistency_freq usermat_completed_task'];
consistency_freq_per_tree = [consistency_A_freq consistency_B_freq consistency_C_freq consistency_D_freq usermat_completed_task'];
consistency_freq_per_tree_desc = {'A_LH_Consistent', 'A_SH_Consistent', 'B_LH_Consistent', 'B_SH_Consistent', 'C_LH_Consistent', 'C_SH_Consistent', 'D_LH_Consistent', 'D_SH_Consistent', 'ID'};

save(strcat(data_fold, 'data_for_figs/consistency_freq.mat'), 'consistency_freq')
save(strcat(data_fold, 'data_for_figs/consistency_freq_desc.mat'), 'consistency_freq_desc')

save(strcat(data_fold, 'data_for_figs/consistency_freq_per_tree.mat'), 'consistency_freq_per_tree')
save(strcat(data_fold, 'data_for_figs/consistency_freq_per_tree_desc.mat'), 'consistency_freq_per_tree_desc')