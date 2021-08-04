
addpath('./func_aggregate/')
addpath('./func_plot/')

load('../usermat_completed_task.mat')

% Initiate
number_particip = length(usermat_completed_task);

for part_ind=1:length(usermat_completed_task)
    
    close all;
        
    userID = usermat_completed_task(part_ind);
    user_num = num2str(userID);
    
    disp(['userID:', 32, num2str(userID)])

    part_file = strcat('../../data/concat_data/user_',user_num,'.mat');

    load(part_file, 'user');  
    direc = strcat('../../data/sanity_check/user_', user_num);

    if ~exist(direc)
        mkdir(direc)
    end

    all_1st = user.log(user.log(:,5)==1,:); % keep all first trials
    all_1st_d = all_1st(all_1st(:,13)~=4,:); % keep all first trials
    tmp_d = all_1st_d(:,9);
    tmp_d(isnan(tmp_d))=0;
    %data_1st_d = [all_1st_d(:,2), tmp_d];
    data_1st_d(part_ind,:) = tmp_d';
   
    % save
%     save(strcat(direc, '/matBD'), 'matBD')
    
end

% plot(data_1st_d(:,1), data_1st_d(:,2))

n_part = 10;

plot((1:20), data_1st_d(1:n_part,1:20)+rand(n_part,20)/10, '*'); 




 