
picked_tree_mat = [];
picked_tree_mat_desc = {'gameIDs', 'PickedLH_1', 'PickedLH_2', 'PickedSH_1', 'PickedSH_2'};

data_fold = ('../../data/');
load(strcat(data_fold,'sanity_check/user_2/logs/logdesc.mat'))

col_gameID=4;
col_pickedtree=6;

consistency_mat_desc = {'gameID' 'LHisConsistent' 'SHisConsistent'};
consistency_freq_desc = {'LH_Consistent' 'SH_Consistent', 'ID'};

ID_mat = [2,4:6,9,11,13,14];

consistency_freq = nan(size(ID_mat,2),2);

for ID_i=1:size(ID_mat,2)
    
    ID = ID_mat(ID_i);
    
    if ID~=107 && ID~=119 && ID~=212 && ID~=805
    
        % AB

        load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logABlong.mat'))
        load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logABshort.mat'))

        logABlongfirstapp = logABlong(logABlong(:,5)==5,:);

        gameIDs_AB_short = unique(logABshort(:,col_gameID));
        gameIDs_AB_long = unique(logABlongfirstapp(:,col_gameID));

        for i=1:size(gameIDs_AB_long,1)
            tmpLH=find(logABlongfirstapp(:,col_gameID)==gameIDs_AB_long(i));
            tmpSH=find(logABshort(:,col_gameID)==gameIDs_AB_short(i));
            picked_tree_mat(end+1,:) = [gameIDs_AB_long(i) logABlongfirstapp(tmpLH(1),col_pickedtree) logABlongfirstapp(tmpLH(2),col_pickedtree) logABshort(tmpSH(1),col_pickedtree) logABshort(tmpSH(2),col_pickedtree)];
        end

        % ABD

        load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logABDlong.mat'))
        load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logABDshort.mat'))

        logABDlongfirstapp = logABDlong(logABDlong(:,5)==6,:);

        gameIDs_ABD_short = unique(logABDshort(:,col_gameID));
        gameIDs_ABD_long = unique(logABDlongfirstapp(:,col_gameID));

        for i=1:size(gameIDs_ABD_long,1)
            tmpLH=find(logABDlongfirstapp(:,col_gameID)==gameIDs_ABD_long(i));
            tmpSH=find(logABDshort(:,col_gameID)==gameIDs_ABD_short(i));
            picked_tree_mat(end+1,:) = [gameIDs_ABD_long(i) logABDlongfirstapp(tmpLH(1),col_pickedtree) logABDlongfirstapp(tmpLH(2),col_pickedtree) logABDshort(tmpSH(1),col_pickedtree) logABDshort(tmpSH(2),col_pickedtree)];
        end

        % AD

        load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logADlong.mat'))
        load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logADshort.mat'))

        logADlongfirstapp = logADlong(logADlong(:,5)==5,:);

        gameIDs_AD_short = unique(logADshort(:,col_gameID));
        gameIDs_AD_long = unique(logADlongfirstapp(:,col_gameID));

        for i=1:size(gameIDs_AD_long,1)
            tmpLH=find(logADlongfirstapp(:,col_gameID)==gameIDs_AD_long(i));
            tmpSH=find(logADshort(:,col_gameID)==gameIDs_AD_short(i));
            picked_tree_mat(end+1,:) = [gameIDs_AD_long(i) logADlongfirstapp(tmpLH(1),col_pickedtree) logADlongfirstapp(tmpLH(2),col_pickedtree) logADshort(tmpSH(1),col_pickedtree) logADshort(tmpSH(2),col_pickedtree)];
        end

        % BD

        load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logBDlong.mat'))
        load(strcat(data_fold, 'sanity_check/user_',num2str(ID),'/logs/logBDshort.mat'))

        logBDlongfirstapp = logBDlong(logBDlong(:,5)==3,:);

        gameIDs_BD_short = unique(logBDshort(:,col_gameID));
        gameIDs_BD_long = unique(logBDlongfirstapp(:,col_gameID));

        for i=1:size(gameIDs_BD_long,1)
            tmpLH=find(logBDlongfirstapp(:,col_gameID)==gameIDs_BD_long(i));
            tmpSH=find(logBDshort(:,col_gameID)==gameIDs_BD_short(i));
            picked_tree_mat(end+1,:) = [gameIDs_BD_long(i) logBDlongfirstapp(tmpLH(1),col_pickedtree) logBDlongfirstapp(tmpLH(2),col_pickedtree) logBDshort(tmpSH(1),col_pickedtree) logBDshort(tmpSH(2),col_pickedtree)];
        end

        for i=1:size(picked_tree_mat,1)

            if picked_tree_mat(i,2) == picked_tree_mat(i,3)
                constistentSH(i) = 1;
            else
                constistentSH(i) = 0;
            end

            if picked_tree_mat(i,4) == picked_tree_mat(i,5)
                constistentLH(i) = 1;
            else
                constistentLH(i) = 0;
            end
        end

        consistency_mat = [picked_tree_mat(:,1) constistentLH' constistentSH'];
        consistency_freq(ID_i,:) = [sum(consistency_mat(:,2:3),1)./size(consistency_mat,1)*100];

        constistentLH=[];
        constistentSH=[];
        picked_tree_mat = [];
        
    end
    
end

consistency_freq = [consistency_freq ID_mat'];

save(strcat(data_fold, 'data_for_figs/consistency_freq.mat'), 'consistency_freq')
save(strcat(data_fold, 'data_for_figs/consistency_freq_desc.mat'), 'consistency_freq_desc')