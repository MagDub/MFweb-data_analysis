cond = [];

addpath('./functions/')

data_fold = ('../../data/');

dir_data = (strcat(data_fold,'sanity_check/'));
dir_save = (strcat(data_fold,'data_for_figs/'));

load('../usermat_completed.mat')

cond_mat = [];

n_ = size(usermat_completed,2);

for ID_n = 1:n_
    
    ID = usermat_completed(ID_n);
    
        %%% cond AB

        cond{ID_n}.AB = [];

        load(strcat(dir_data, 'user_',int2str(ID),'/mat_AB.mat'));

        short_ind = find(mat_AB(:,3)==6);
        long_ind = find(mat_AB(:,3)==11);

        tmp = short_ind;
        cond{ID_n}.AB(1:4) = [size(find(mat_AB(tmp,9)==1),1),size(find(mat_AB(tmp,9)==2),1), size(find(mat_AB(tmp,9)==3),1), size(find(mat_AB(tmp,9)==4),1)];

        tmp = long_ind;
        cond{ID_n}.AB(5:8) = [size(find(mat_AB(tmp,9)==1),1),size(find(mat_AB(tmp,9)==2),1), size(find(mat_AB(tmp,9)==3),1), size(find(mat_AB(tmp,9)==4),1)];

        %%% cond BD

        cond{ID_n}.BD = [];

        load(strcat(dir_data, 'user_',int2str(ID),'/mat_BD.mat'));

        short_ind = find(mat_BD(:,3)==6);
        long_ind = find(mat_BD(:,3)==11);

        tmp = short_ind;
        cond{ID_n}.BD(1:4) = [size(find(mat_BD(tmp,7)==1),1),size(find(mat_BD(tmp,7)==2),1), size(find(mat_BD(tmp,7)==3),1), size(find(mat_BD(tmp,7)==4),1)];

        tmp = long_ind;
        cond{ID_n}.BD(5:8) = [size(find(mat_BD(tmp,7)==1),1),size(find(mat_BD(tmp,7)==2),1), size(find(mat_BD(tmp,7)==3),1), size(find(mat_BD(tmp,7)==4),1)];


        %%% cond ABD

        cond{ID_n}.ABD = []; 

        load(strcat(dir_data, 'user_',int2str(ID),'/mat_ABD.mat'));

        short_ind = find(mat_ABD(:,3)==6);
        long_ind = find(mat_ABD(:,3)==11);

        tmp = short_ind;
        cond{ID_n}.ABD(1:4) = [size(find(mat_ABD(tmp,10)==1),1),size(find(mat_ABD(tmp,10)==2),1), size(find(mat_ABD(tmp,10)==3),1), size(find(mat_ABD(tmp,10)==4),1)];

        tmp = long_ind;
        cond{ID_n}.ABD(5:8) = [size(find(mat_ABD(tmp,10)==1),1),size(find(mat_ABD(tmp,10)==2),1), size(find(mat_ABD(tmp,10)==3),1), size(find(mat_ABD(tmp,10)==4),1)];


        %%% cond AD

        cond{ID_n}.AD = []; 

        load(strcat(dir_data, 'user_',int2str(ID),'/mat_AD.mat'));

        short_ind = find(mat_AD(:,3)==6);
        long_ind = find(mat_AD(:,3)==11);

        tmp = short_ind;
        cond{ID_n}.AD(1:4) = [size(find(mat_AD(tmp,9)==1),1),size(find(mat_AD(tmp,9)==2),1), size(find(mat_AD(tmp,9)==3),1), size(find(mat_AD(tmp,9)==4),1)];

        tmp = long_ind;
        cond{ID_n}.AD(5:8) = [size(find(mat_AD(tmp,9)==1),1),size(find(mat_AD(tmp,9)==2),1), size(find(mat_AD(tmp,9)==3),1), size(find(mat_AD(tmp,9)==4),1)];

        % desc
        cond{ID_n}.desc = {'A_short', 'B_short', 'C_short', 'D_short', 'A_long', 'B_long', 'C_long', 'D_long'};

end

for ID_n = 1:n_
    
    ID = usermat_completed(ID_n);
    
       cond_mat(ID_n, 1:8) = cond{ID_n}.AB; 
       cond_mat(ID_n, 9:16) = cond{ID_n}.BD; 
       cond_mat(ID_n, 17:24) = cond{ID_n}.ABD; 
       cond_mat(ID_n, 25:32) = cond{ID_n}.AD; 
end

all_A_short = cond_mat(:,1) + cond_mat(:,9) + cond_mat(:,17) + cond_mat(:,25);
all_B_short = cond_mat(:,2) + cond_mat(:,10) + cond_mat(:,18) + cond_mat(:,26);
all_C_short = cond_mat(:,3) + cond_mat(:,11) + cond_mat(:,19) + cond_mat(:,27);
all_D_short = cond_mat(:,4) + cond_mat(:,12) + cond_mat(:,20) + cond_mat(:,28);

all_A_long = cond_mat(:,5) + cond_mat(:,13) + cond_mat(:,21) + cond_mat(:,29);
all_B_long = cond_mat(:,6) + cond_mat(:,14) + cond_mat(:,22) + cond_mat(:,30);
all_C_long = cond_mat(:,7) + cond_mat(:,15) + cond_mat(:,23) + cond_mat(:,31);
all_D_long = cond_mat(:,8) + cond_mat(:,16) + cond_mat(:,24) + cond_mat(:,32);

all_short = [all_A_short, all_B_short, all_C_short, all_D_short];
all_long = [all_A_long, all_B_long, all_C_long, all_D_long];

frequencies = [all_short all_long];
frequencies_desc = [{'all_A_short'} {'all_B_short'} {'all_C_short'} {'all_D_short'} ...
                {'all_A_long'} {'all_B_long'} {'all_C_long'} {'all_D_long'}];
            
save(strcat(dir_save, 'frequencies.mat'), 'frequencies');
save(strcat(dir_save, 'frequencies_desc.mat'), 'frequencies_desc');