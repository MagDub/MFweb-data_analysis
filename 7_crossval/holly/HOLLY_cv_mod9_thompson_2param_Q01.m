function HOLLY_cv_mod9_thompson_2param_Q01(ID, data_fol)

    %%%%%%% k-fold validation indexes %%%%%%%
    tot_trials = 200; %% CHANGED
    Kf = 10; %% CHANGED
    
    trials_tested_on = tot_trials / Kf;
    trials_trained_on = tot_trials - trials_tested_on ;

    range_test_mat = nan(Kf,trials_tested_on);
    range_train_mat = nan(Kf,trials_trained_on);

    for i =1:Kf
        k=i-1;
        range_train_mat(i,:) = [1:trials_tested_on*k, ...
            trials_tested_on*k+trials_tested_on+1:tot_trials];
        range_test_mat(i,:) = [trials_tested_on*k+1:trials_tested_on*k+trials_tested_on];
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for k = 1:Kf
        range_test = range_test_mat(k,:);
        range_train = range_train_mat(k,:);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        param_bounds_sgm0 = [0.01,6];
        param_bounds_Q0 = [1,10]; 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        algo = 'mod_9';
        
        results_dir = strcat(data_fol, '/crossval/',algo,'/results/'); 
        
        if ~exist(results_dir)
            mkdir(results_dir) %% CHANGED
        end

        % settings
        settings = [];
        settings.task.N_games = 400;
        settings.task.N_hor = 2;
        settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
        settings.task.N_trees = 3;
        settings.opts.TLT       = [];
        settings.funs.decfun        = @softmax;
        settings.funs.valuefun      = @mvnorm_Thompson; 
        settings.funs.priorfun      = [];
        settings.funs.learningfun   = @kalman_filt;
        settings.desc = ['thompson'];    % description of model (settings, etc)
        settings.params.param_names = {'sgm0', '', 'Q0'};   % is same param name as prev, write ''
        settings.params.lb          = [param_bounds_sgm0(1) param_bounds_sgm0(1)  param_bounds_Q0(1)];    % lower bound
        settings.params.ub          = [param_bounds_sgm0(2) param_bounds_sgm0(2)  param_bounds_Q0(2)];    % upper bound


        %% get data
        data_dir = strcat(data_fol, 'concat_data/'); %CHANGED
        [data,gameIDs] = aggregateData(ID,data_dir); %CHANGED


        %% fit model

        data_train = data(1:2,range_train);
        gameIDs_train = gameIDs(1:2,range_train);
    
        modelfun = @(x) modelMF_S0fixed_crossval_2sgm0(x,settings.params.param_names,ID,settings,data_train,gameIDs_train, 1, trials_trained_on);  

        %%%%%%%% fmincon %%%%%%%%
        options = optimoptions('fmincon','Display','off');
        a = settings.params.lb;
        b = settings.params.ub;
        
        mEmatparams = nan(8,3);
        mEmatmle = nan(8,1);
        mEexitflag = nan(8,1);
       
        parfor iter=1:8
        % starting point
            xo_fmincon = (b-a).*rand(1,1) + a; % random value in this interval     
            [mEparams, mEmle, mEexitflag] = fmincon(modelfun,...
                xo_fmincon,[],[],[],[],...
                settings.params.lb,settings.params.ub,...
                [],options);
            mEmatparams(iter,:) = mEparams;
            mEmatmle(iter,:) = mEmle;
            mEexitflag(iter,:) = mEexitflag;
        end

        %% tidy up  
        mEsubj = ID;

        [mEmle, ind]= min(mEmatmle);
        mEparams  = mEmatparams(ind,:);
        mEexitflag = mEexitflag(ind);

        % save
        save_func_data(ID+k*1000, settings, results_dir, mEparams, mEmle, [], mEexitflag, mEsubj, [], [], mEmatparams, mEmatmle,[])

        %% test model

        data_test = data(1:2,range_test);
        gameIDs_test = gameIDs(1:2,range_test);

        [test_nLogL, ~, ~] = modelMF_S0fixed_crossval_2sgm0(mEparams,settings.params.param_names,ID,settings,data_test,gameIDs_test, 1, trials_tested_on);
        average_prob(k) = exp(-test_nLogL/(2*trials_tested_on));
    end

save([results_dir 'aver_prob_' settings.desc '_' int2str(ID) '.mat'],'average_prob')

end