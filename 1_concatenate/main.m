
% User 12 did not do last block !!

usermat = [2,4:6,9,11,13,14];

for i=1:length(usermat)
        
    userID = usermat(i);
    
    disp(['userID:', 32, num2str(userID)])

    path_ = strcat('../../data/raw/user_',int2str(userID),'/task/');
    task_folder = strcat(path_,'*.xls');
    FolderInfo = dir(task_folder);
    file_names = {};
    
    for block_i = 1:size(FolderInfo,1)
        file_names{end+1}=FolderInfo(block_i).name;
    end
    
    n_trials = 100;

    if size(file_names,2)~=4
        disp('Problem ! Not 4 blocks !')

    else
        user_log = [];
        user_log_desc = {'Block', 'Blocktrial', 'Horizon', 'Item', 'Sample', ...
                            'TreeA', 'TreeB', 'TreeC', 'TreeD', ...
                                'Size', 'RT', 'PressedKey', 'UnusedTree',...
                                    'TreeColGroup', 'AppleCol1', 'AppleCol2', 'AppleCol3', ...
                                        'BlockDuration', 'InfoRequestNo'};

        ItemMatAllBlocks = [];
        InitialSamplesSizeMatAllBlocks = [];
        InitialSamplesTreeMatAllBlocks = [];
        UnusedTreeMatAllBlocks = [];

        for block_i = 1:4

            file_ = strcat(path_,string(file_names(block_i)));

            T = readtable(char(file_));

            % Convert
            TrialMat=convert2num(T.TrialNo);
            HorizonMat=convert2num(T.Horizon);
            ItemMat=convert2num(T.ItemNo);
            InitialSamplesNbMat=convert2num(T.InitialSamplesNb);
            TreeColoursMat=convert2num(T.TreeColours);
            UnusedTreeMat=convert2num(T.UnusedTree);
            
            % Check if column name exists
            Exist_Column = strcmp('InfoRequestNo',T.Properties.VariableNames);
            val = Exist_Column(Exist_Column==1);
            if val
                InfoRequestNo=str2double(T.InfoRequestNo);
            else
                InfoRequestNo=nan;
            end

            pressedMat = make_mat(n_trials, T.AllKeyPressed, 6);    
            InitialSamplesSizeMat = make_mat(n_trials, T.InitialSamplesSize, 5);
            InitialSamplesTreeMat = make_mat(n_trials, T.InitialSamplesTree, 5);
            ChosenTreeMat = make_mat(n_trials, T.ChosenTree, 6); 
            ChosenAppleSizeMat = make_mat(n_trials, T.ChosenAppleSize, 6); 

            for i = 1:100
                ItemMatAllBlocks(end+1) = ItemMat(i);
                UnusedTreeMatAllBlocks(end+1) = UnusedTreeMat(i);
                InitialSamplesSizeMatAllBlocks(end+1,:) = InitialSamplesSizeMat(i,:);
                InitialSamplesTreeMatAllBlocks(end+1,:) = InitialSamplesTreeMat(i,:);
            end

            % reaction times
            tmp_RTMat = make_mat(n_trials, T.ReactionTimes, 7);      
            for trial = 1:n_trials
                for hor = 1:HorizonMat(trial)
                    RTMat(trial, hor) = tmp_RTMat(trial, hor+1)-tmp_RTMat(trial, hor);
                end
            end

            % Elapsed time (in sec) per block
            tmpStart=str2mat(T.BlockStartTime);
            tmpFinish=str2mat(T.BlockFinishTime);
            Start=tmpStart(1:8);
            Finish=tmpFinish(1:8);

            % Date is default, only works if it was done in the same day !!!
            t1={strcat('01-Oct-2011',32, mat2str(Start))};
            t2={strcat('01-Oct-2011',32, mat2str(Finish))};
            t11=datevec(datenum(t1));
            t22=datevec(datenum(t2));
            elapsed_time_s = etime(t22,t11);

            for trial = 1:n_trials

                % displayed
                for sample = 1:InitialSamplesNbMat(trial)

                    if ~find(InitialSamplesTreeMat(trial,:)==UnusedTreeMat(trial))
                        disp('MISMATCH ! UNUSED TREE IS DISPLAYED')
                    end

                    trees = nan(1,4);
                    tree = InitialSamplesTreeMat(trial,sample);
                    trees(tree)=1;

                    init_samp = InitialSamplesSizeMat(trial,sample);

                    rt = nan;
                    pressed = nan;

                    % TODO
                    apple_col = nan(1,3);

                    user_log(end+1, :) = [T.BlockNo, TrialMat(trial), HorizonMat(trial)+5, ItemMat(trial), sample,...
                                          trees, init_samp, rt, pressed, ...
                                          UnusedTreeMat(trial), TreeColoursMat(trial), ...
                                          apple_col, ...
                                          elapsed_time_s,...
                                          InfoRequestNo];
                end

                % selected
                for choice = 1:HorizonMat(trial)

                    rt = RTMat(trial,choice);
                    pressed = pressedMat(trial,choice);
                    init_samp = ChosenAppleSizeMat(trial,choice);

                    if ~find(ChosenTreeMat(trial,:)==UnusedTreeMat(trial))
                        disp('MISMATCH ! UNUSED TREE IS CHOSEN')
                    end

                    trees = nan(1,4);
                    tree = ChosenTreeMat(trial,choice);
                    trees(tree)=1;

                    user_log(end+1, :) = [T.BlockNo, TrialMat(trial), HorizonMat(trial)+5, ItemMat(trial), InitialSamplesNbMat(trial)+choice,...
                          trees, init_samp, rt, pressed, ...
                          UnusedTreeMat(trial), TreeColoursMat(trial), ...
                          apple_col, ...
                          elapsed_time_s, ...
                          InfoRequestNo];

                end
            end
        end
    end

    user = [];
    user.log = user_log;
    user.log_desc = user_log_desc;

    [v, ind] = sort(ItemMatAllBlocks);
    [fin, fin_ind] = unique(v);
    tmp_unused_trees = UnusedTreeMatAllBlocks([ind(fin_ind)]);
    tmp_initial_apples_sizes = InitialSamplesSizeMatAllBlocks([ind(fin_ind)],:);
    tmp_initial_apples_trees = InitialSamplesTreeMatAllBlocks([ind(fin_ind)],:);

    user.unused_tree = tmp_unused_trees;

    for it_ = 1:100    
        for app = 1:5

            init_samp = tmp_initial_apples_sizes(it_, app);
            if init_samp > 0
                user.item(1,it_).initial_apples.size(app) = init_samp;
                user.item(2,it_).initial_apples.size(app) = init_samp;
            end

            tree = tmp_initial_apples_trees(it_, app);
            if tree > 0
                user.item(1,it_).initial_apples.tree(app) = tree;
                user.item(2,it_).initial_apples.tree(app) = tree;
            end
        end    
    end

    save(strcat('../../data/concat_data/user_',int2str(userID),'.mat'), 'user')
          
end



