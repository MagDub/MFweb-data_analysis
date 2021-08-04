
addpath('./func_aggregate/')
addpath('./func_plot/')

load('../usermat_completed.mat')

% Initiate
number_particip = length(usermat_completed);

matBD = initiate_mat(number_particip);
matAD = initiate_mat(number_particip);
matAB = initiate_mat(number_particip);
matABD = initiate_mat(number_particip);
matAB_fromABD = initiate_mat(number_particip);

for part_ind=1:length(usermat_completed)
    
    close all;
        
    userID = usermat_completed(part_ind);
    
    %if userID~=17 

        user_num = num2str(userID);

        disp(['userID:', 32, num2str(userID)])

        part_file = strcat('../../data/concat_data/user_',user_num,'.mat');

        load(part_file, 'user');  
        direc = strcat('../../data/sanity_check/user_', user_num);

        if ~exist(direc)

            mkdir(direc)

            rejected=[];

            initial_apples_BD = [];
            initial_apples_DB = [];
            rejected_BD = [];
            rejected_DB = [];
            gameID_BD = [];
            gameID_DB = [];

            initial_apples_AD = [];
            rejected_AD = [];
            gameID_AD = [];

            initial_apples_ABD = [];
            rejected_ABD = [];
            gameID_ABD = [];

            initial_apples_AB = [];
            rejected_AB = [];
            gameID_AB = [];

            %
            for i=1:size(user.unused_tree,2)

                %%%%% A is the unused tree %%%%%
                if user.unused_tree(i) == 1
                    if user.item(1,i).initial_apples.tree(1) == 2 && user.item(1,i).initial_apples.tree(2) == 4
                            if user.item(1,i).initial_apples.size(2) < user.item(1,i).initial_apples.size(1)
                                initial_apples_BD(:,end+1) = user.item(1,i).initial_apples.size';
                                gameID_BD(end+1) = i;
                            else
                                rejected_BD(end+1) = i;
                            end
                    elseif user.item(1,i).initial_apples.tree(1) == 4 && user.item(1,i).initial_apples.tree(2) == 2
                            if user.item(1,i).initial_apples.size(1) < user.item(1,i).initial_apples.size(2)
                                initial_apples_DB(:,end+1) = user.item(1,i).initial_apples.size';
                                gameID_DB(end+1) = i;
                            else
                                rejected_DB(end+1)  = i;
                            end
                    else
                        disp('mismatch between unused_tree and initial_apples (BD)')
                    end

                %%%%% B is the unused tree %%%%%
                elseif user.unused_tree(i) == 2
                    [min_size,ind_min]=min(user.item(1,i).initial_apples.size); %find where D is
                    all_min = find(user.item(1,i).initial_apples.size==min_size);
                    [sorted_AAAD, sorted_AAAD_ind] = sort(user.item(1,i).initial_apples.tree);
                    if all((sorted_AAAD) == [1 1 1 4]) %checks that we are in this scenario
                            if find(user.item(1,i).initial_apples.tree==4) == ind_min && size(all_min,2)==1 %checks that D is THE smallest
                                initial_apples_AD(:,end+1) = user.item(1,i).initial_apples.size(sorted_AAAD_ind)'; %D is always in position 4
                                gameID_AD(end+1) = i;
                            else %if D is not, we won't use it
                                rejected_AD(end+1) = i;
                            end
                    else
                        disp('mismatch between unused_tree and initial_apples (AD)')
                    end

                %%%%% C is the unused tree %%%%%  
                elseif user.unused_tree(i) == 3
                    [min_size,ind_min]=min(user.item(1,i).initial_apples.size); %find where D is
                    all_min = find(user.item(1,i).initial_apples.size==min_size);
                    [sorted_AAABD, sorted_AAABD_ind] = sort(user.item(1,i).initial_apples.tree);
                    if all((sorted_AAABD) == [1 1 1 2 4]) %checks that we are in this scenario
                            if find(user.item(1,i).initial_apples.tree==4) == ind_min && size(all_min,2)==1 %checks that D THE smallest
                                initial_apples_ABD(:,end+1) = user.item(1,i).initial_apples.size(sorted_AAABD_ind)'; % B in pos 4, D in post 5
                                gameID_ABD(end+1) = i;
                            else %if D is not, we won't use it
                                rejected_ABD(end+1) = i;
                            end
                    else
                        disp('mismatch between unused_tree and initial_apples (ABD)')
                    end

                %%%%% D is the unused tree %%%%%  
                elseif user.unused_tree(i) == 4
                    [sorted_AAAB, sorted_AAAB_ind] = sort(user.item(1,i).initial_apples.tree);
                    if all((sorted_AAAB) == [1 1 1 2]) %checks that we are in this scenario
                        initial_apples_AB(:,end+1) = user.item(1,i).initial_apples.size(sorted_AAAB_ind)'; % B in pos 4, D in post 5
                        gameID_AB(end+1) = i;
                    else
                        disp('mismatch between unused_tree and initial_apples (ABD)')
                    end
                end
            end

            %%%%% Split data by category and aggregate it %%%%%
            [log_BD, mat_BD, logBDlong, logBDshort, logdesc, logBDlong_all, logBDshort_all]= aggregate_choices_BD_new(user, sort([gameID_BD gameID_DB]));
            [log_AD, mat_AD, logADlong, logADshort, ~, logADlong_all, logADshort_all] = aggregate_choices_AD(user, gameID_AD);
            [log_ABD, mat_ABD, logABDlong, logABDshort, ~, logABDlong_all, logABDshort_all] = aggregate_choices_ABD(user, gameID_ABD);
            [log_AB, mat_AB, logABlong, logABshort, ~, logABlong_all, logABshort_all] = aggregate_choices_AB(user, gameID_AB);

            fol_log = strcat(direc, '/logs');
            % Make the log folder

            if ~exist(fol_log)
                mkdir(fol_log)
            end

            % save logs
            save(strcat(fol_log, '/logdesc'), 'logdesc') 

            save(strcat(fol_log, '/logBDshort'), 'logBDshort')
            save(strcat(fol_log, '/logBDlong'), 'logBDlong') 
            save(strcat(fol_log, '/logBDshort_all'), 'logBDshort_all')
            save(strcat(fol_log, '/logBDlong_all'), 'logBDlong_all') 

            save(strcat(fol_log, '/logADshort'), 'logADshort')
            save(strcat(fol_log, '/logADlong'), 'logADlong')
            save(strcat(fol_log, '/logADshort_all'), 'logADshort_all')
            save(strcat(fol_log, '/logADlong_all'), 'logADlong_all')

            save(strcat(fol_log, '/logABDshort'), 'logABDshort')
            save(strcat(fol_log, '/logABDlong'), 'logABDlong')
            save(strcat(fol_log, '/logABDshort_all'), 'logABDshort_all')
            save(strcat(fol_log, '/logABDlong_all'), 'logABDlong_all')

            save(strcat(fol_log, '/logABshort'), 'logABshort')
            save(strcat(fol_log, '/logABlong'), 'logABlong')
            save(strcat(fol_log, '/logABshort_all'), 'logABshort_all')
            save(strcat(fol_log, '/logABlong_all'), 'logABlong_all')

            % mat_ABD %%%
        %     1 : ind_block 
        %     2 : ind_block_trial 
        %     3 : ind_horizon 
        %     4 : ind_gameID
        %     5 : size A
        %     6 : size A
        %     7 : size A
        %     8 : size B
        %     9 : size D
        %     10 : chosen_tree
        %     11 : size of chosen apple
        %     12 : RT

            tmp_ABD = mat_ABD;
            %%%% Plot and store the important things %%%%%
            [matBD, RT_BD_SH, RT_BD_LH] = plot_all_BD(user_num, mat_BD, direc);
            [matAD, RT_AD_SH, RT_AD_LH] = plot_all_AD(user_num, mat_AD, direc);
            [matABD, RT_ABD_SH, RT_ABD_LH] = plot_all_ABD(user_num, tmp_ABD, direc);
            [matAB, RT_AB_SH, RT_AB_LH] = plot_all_AB(user_num, mat_AB, direc);
            matAB_ABD = plot_all_AB_ABD(user_num, tmp_ABD, direc); 

            % RT on 1st trials
            RT_all_1st_trial_SH = [RT_BD_SH; RT_AD_SH; RT_ABD_SH; RT_AB_SH];
            RT_all_1st_trial_LH = [RT_BD_LH; RT_AD_LH; RT_ABD_LH; RT_AB_LH];

            % pressed key
            tmp_pressed_key_all = user.log(:,12);
            pressed_key_all = tmp_pressed_key_all(~isnan(tmp_pressed_key_all));

            % save
            save(strcat(direc, '/matBD'), 'matBD')
            save(strcat(direc, '/matAD'), 'matAD')
            save(strcat(direc, '/matABD'), 'matABD')
            save(strcat(direc, '/matAB'), 'matAB')
            save(strcat(direc, '/matAB_ABD'), 'matAB_ABD')

            save(strcat(direc, '/mat_BD'), 'mat_BD')
            save(strcat(direc, '/mat_AD'), 'mat_AD')
            save(strcat(direc, '/mat_ABD'), 'mat_ABD')
            save(strcat(direc, '/mat_AB'), 'mat_AB')

            save(strcat(direc, '/RT_all_1st_trial_SH'), 'RT_all_1st_trial_SH')
            save(strcat(direc, '/RT_all_1st_trial_LH'), 'RT_all_1st_trial_LH')

            save(strcat(direc, '/pressed_key_all'), 'pressed_key_all')

            rejected(end+1,:) = [size(rejected_BD,2), size(rejected_DB,2), size(rejected_AD,2), size(rejected_ABD,2), size(rejected_AB,2)];

            make_hist_figure(mat_AB, mat_ABD, mat_AD, mat_BD, user_num, direc);    

    %         average_rej_trials_per_part = mean(sum(rejected,2));
    %         disp(['Average rejected trials per participant:', 32, num2str(average_rej_trials_per_part)])
    %         disp('---------------------------------')

        end
    %end

    
end



 