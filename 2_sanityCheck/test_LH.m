
addpath('./func_aggregate/')
addpath('./func_plot/')

load('../usermat_completed_task.mat')

% Initiate
number_particip = length(usermat_completed_task);

for part_ind=1%:length(usermat_completed_task)
    
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

    all_LH = user.log(user.log(:,3)==11,:); % keep all LH
    all_LH_choice = all_LH(~isnan(all_LH(:,11)),:); % keep all first trials
    
    data = [(1:size(all_LH_choice,1))',all_LH_choice(:,11)];
    
    filename = strcat('../../../GPSS/resources/RT/user', user_num, '.csv');
    csvwrite(filename, data)
end

 