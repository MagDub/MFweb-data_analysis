function fit_mod7(ID, data_fol, sim_dir, settings, data, gameIDs)

    results_dir = strcat(sim_dir, 'results/');
    
    % settings
    settings.desc = ['mod7']; 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_gamma = [10^-8,2]; 
    param_bounds_tau = [10^-8,2]; 
    param_bounds_Q0 = [1,6]; 
    param_bounds_eta = [0,5];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    settings.funs.decfun            = @softmax;
    settings.funs.valuefun          = @UCB_noveltybonus; 
    settings.funs.learningfun       = @kalman_filt;
    settings.params.param_names     = {'Q0' 'gamma'  ''  'tau'  ''  'eta' ''};   
    settings.params.lb              = [param_bounds_Q0(1) param_bounds_gamma(1) param_bounds_gamma(1) param_bounds_tau(1) param_bounds_tau(1) param_bounds_eta(1) param_bounds_eta(1)];    % lower bound
    settings.params.ub              = [param_bounds_Q0(2) param_bounds_gamma(2) param_bounds_gamma(2) param_bounds_tau(2) param_bounds_tau(2) param_bounds_eta(2) param_bounds_eta(2)];    % upper bound
    
    % prior
    load(strcat(data_fol,'/priors/mod7/empirical_prior.mat'),'prior')
    param_names = {'Q0', 'gamma', 'gamma','tau', 'tau', 'eta', 'eta'};

    % fit model
    modelfunLL = @(x) modelMF_S0fixed_sgm0fixed_eta(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_sgm0fixed_eta_UCB_MAP(x,settings.params.param_names,ID,settings,data,gameIDs, prior, param_names);
    
    % fmincon
    options = optimoptions('fmincon','Display','off');
    a = settings.params.lb;
    b = settings.params.ub;

    mEmatparams = nan(8,size(settings.params.param_names,2));
    mEmatmle = nan(8,1);
    mEexitflag = nan(8,1);

    tic
    parfor iter=1:8
        xo_fmincon = (b-a).*rand(1,1) + a; % random value in this interval     
        [mEparams, mEMAP, mEexitflag] = fmincon(modelfun,xo_fmincon,[],[],[],[],...
            settings.params.lb,settings.params.ub,[],options);
        mEmatparams(iter,:) = mEparams;
        mEmatMAP(iter,:) = mEMAP;
        mEexitflag(iter,:) = mEexitflag;
    end
    toc

    % tidy up
    mEsubj = ID;
    [mEMAP, ind]= min(mEmatMAP);
    mEparams  = mEmatparams(ind,:);
    mEexitflag = mEexitflag(ind);
    mEprior = prior;

    [mEmle, ~, ~] = modelfunLL(mEparams); %find likelihood 

    if ~exist(results_dir)
        mkdir(results_dir)
    end

    % save
    save_func_data(ID, settings, results_dir, mEparams, mEmle, mEMAP, mEexitflag, mEsubj, [], [], mEmatparams, [], mEprior)

end