function sim_refit_thompson_3param_noveltybonus_parhor_MAP(ID, sim_dir)

addpath('D:\MaggiesFarm\modeling_28_02\init_modelMF\')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
holly=0;
n_per_dim = 3;
param_bounds_sgm0 = [0.5,2.5];
param_bounds_Q0 = [1,6]; 
param_bounds_xi = [0,0.5];  
param_bounds_eta = [0,5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
    % settings
    settings = [];
    settings.task.N_games = 400;
    settings.task.N_hor = 2;
    settings.task.Ngames_per_hor = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees = 3; % Changed
    settings.opts.TLT       = [];
    settings.funs.decfun        = @softmax;
    settings.funs.valuefun      = @mvnorm_Thompson_noveltybonus_new; %@hybrid; % @thompson; % 
    settings.funs.priorfun      = [];
    settings.funs.learningfun   = @kalman_filt;
    settings.desc = ['sim_thompson_noveltybonus' int2str(ID)];    % description of model (settings, etc)
    settings.params.param_names = {'sgm0', '', 'Q0','xi', '', 'eta', ''};   % is same param name as prev, write ''
    settings.params.lb          = [param_bounds_sgm0(1) param_bounds_sgm0(1)  param_bounds_Q0(1)  param_bounds_xi(1) param_bounds_xi(1) param_bounds_eta(1) param_bounds_eta(1)];    % lower bound
    settings.params.ub          = [param_bounds_sgm0(2) param_bounds_sgm0(2)  param_bounds_Q0(2)  param_bounds_xi(2) param_bounds_xi(2) param_bounds_eta(2) param_bounds_eta(2)];    % upper bound


%   sim_dir = strcat('D:\MaggiesFarm\modeling_28_02\simulation_data\thompson\parhor_MAP\', int2str(n_per_dim), 'perdim_newbounds_sgm0\');


    %% load parameter values
    tmp = load([sim_dir 'inp_params_thompson.mat']);
    para_vals = tmp.inp_params(ID,:);
    
    %% initialise model
    %mo = initialise_model_MF_S0fixed_eta_2sgm0(settings);
    mo = initialise_model_MF_S0fixed_eta_2sgm0_1Q0(settings);

    %% fill in parameters, model-funs etc
    mo = prep_model_MF(mo,settings,para_vals,settings.params.param_names);
    
    %% fill in priors if not constant
    if ~isempty(mo.funs.priorfun)
        mo = mo.funs.priorfun(mo);
    end

    % Generate apple sequences
    [params, user] = apple_params_for_mod(); 
    
    % Write the log file needed for aggregation
    for b = 1:params.task.exp.n_blocks
        for g = 1:params.task.exp.n_trialPB
            [user, params] = present_applesSIM(params, user, b, g);
        end
    end

    [data,gameIDs] = aggregateDataSIM(params, user);

    %% loop through trials (and conditions) to generate behaviour
    for c = 1:settings.task.N_hor
        for g = 1:settings.task.Ngames_per_hor         
        
            % data
            tmp_dat = data(c,g);
            
            % Added
            mo.mat.appleA{c,g} = tmp_dat.a;
            mo.mat.appleB{c,g} = tmp_dat.b;
            mo.mat.appleD{c,g} = tmp_dat.d;

            if tmp_dat.unshown_tree == 1
                tmp_dat = rmfield(tmp_dat,'a');
            elseif tmp_dat.unshown_tree == 2
                tmp_dat = rmfield(tmp_dat,'b');
            elseif tmp_dat.unshown_tree == 3
                tmp_dat = rmfield(tmp_dat,'c');
            elseif tmp_dat.unshown_tree == 4
                tmp_dat = rmfield(tmp_dat,'d');
            end

            % loop through trials of game
            for t = 1:size(tmp_dat.alltrees,1)+1 
                if t == 1 % plug in priors
                    mo.mat.Q{c,g}(:,t) = mo.params.Q0(1);
                    mo.mat.sgm{c,g}(:,t) = mo.params.sgm0(c);
                end

                % see outcome and learn
                if t <= size(tmp_dat.alltrees,1) 
                    mo = mo.funs.learningfun(mo,tmp_dat,c,g,t);
                else
                    % calculate values & policy
                    mo = mo.funs.valuefun(mo,c,g,t);
                    
                        % add lapse if needed
                        if ~isempty(mo.params.xi) 
                            mo = lapse(mo,c,g,t);
                        end
                end
            end

            % make choice based on policy
            tmp_pi = nanmean(mo.mat.pi{c,g},2); 
            r = rand(1);    % random choice seed
            tmp_cPi = cumsum(tmp_pi);
            tmp_chosen = find(tmp_cPi>=r,1,'first');
            
            if isempty(tmp_chosen)
                disp('tmp_chosen is empty in test_3_params')
            end

            if data(c,g).unshown_tree == 1
                tree_vec = [2, 3, 4];
            elseif data(c,g).unshown_tree == 2
                tree_vec = [1, 3, 4];
            elseif data(c,g).unshown_tree == 3
                tree_vec = [1, 2, 4];
            elseif data(c,g).unshown_tree == 4
                tree_vec = [1, 2, 3];
            end

            data(c,g).chosen = tree_vec(tmp_chosen); % Changed       
        end
    end

    %% make results directory
    results_dir = strcat(sim_dir, 'results');

    if exist(results_dir, 'dir') == 0
        mkdir(results_dir)
    end

    % results_dir = strcat('D:\MaggiesFarm\modeling_28_02\simulation_data\thompson\parhor_MAP\', int2str(n_per_dim), 'perdim_newbounds_sgm0\results\');
    results_dir = strcat(sim_dir,'\results\');

    
    % save
    save_sim(results_dir, ID, settings, data, gameIDs, para_vals, mo);

    %% prior
    if holly == 1
        load('/home/mdubois/data/participant_data/priors/thompson_4params_sgm0_xi_eta_uni/empirical_prior.mat'); %from generate_empirical_priors.mend
    else
        load('D:/MaggiesFarm/modeling_28_02/participant_data/priors/thompson_4params_sgm0_xi_eta_uni/empirical_prior.mat','prior') %from generate_empirical_priors.mend
    end


    %% fit model
    
    modelfunLL = @(x) modelMF_S0fixed_eta_2sgm0_1Q0(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_eta_thomp4param_MAP_2sgm0_1Q0(x,settings.params.param_names,ID,settings,data,gameIDs, prior);

        %%%%%%%% fmincon %%%%%%%%
        options = optimoptions('fmincon','Display','off');
        a = settings.params.lb;
        b = settings.params.ub;
        
       mEmatparams = nan(8,7);
       mEmatmle = nan(8,1);
       mEexitflag = nan(8,1);
       
            for iter=1:8
            % starting point
            xo_fmincon = (b-a).*rand(1,1) + a; % random value in this interval     
                [mEparams, mEMAP, mEexitflag] = fmincon(modelfun,...
                    xo_fmincon,[],[],[],[],...
                    settings.params.lb,settings.params.ub,...
                    [],options);
                mEmatparams(iter,:) = mEparams;
                mEmatMAP(iter,:) = mEMAP;
                mEexitflag(iter,:) = mEexitflag;
            end

    %% tidy up
    mEsubj = ID;
    %[nLogL, mo, logL] = modelfun(mEparams);
    
    [mEMAP, ind]= min(mEmatMAP);
    mEparams  = mEmatparams(ind,:);
    mEexitflag = mEexitflag(ind);
    mEprior = prior;
    
    [mEmle, ~, ~] = modelfunLL(mEparams); %find likelihood 
    
    save_func_data(ID, settings, results_dir, mEparams, mEmle, mEMAP, mEexitflag, mEsubj, [], [], mEmatparams, [], mEprior) 
    
end