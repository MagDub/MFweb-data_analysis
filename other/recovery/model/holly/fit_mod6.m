function fit_mod6(ID, data_fol, sim_dir, settings, data, gameIDs)

    results_dir = strcat(sim_dir, 'results/');
    
    % settings
    settings.desc = ['mod6']; 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_gamma = [10^-8,2]; 
    param_bounds_tau = [0.25,1.75];  
    param_bounds_Q0 = [1,10]; 
    param_bounds_xi = [10^-8,0.5];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    settings.funs.decfun            = @softmax;
    settings.funs.valuefun          = @UCB; 
    settings.funs.learningfun       = @kalman_filt;
    settings.params.param_names     = {'Q0' 'gamma'  ''  'tau'  '' 'xi' ''};   
    settings.params.lb              = [param_bounds_Q0(1) param_bounds_gamma(1) param_bounds_gamma(1) param_bounds_tau(1) param_bounds_tau(1) param_bounds_xi(1) param_bounds_xi(1)];    % lower bound
    settings.params.ub              = [param_bounds_Q0(2) param_bounds_gamma(2) param_bounds_gamma(2) param_bounds_tau(2) param_bounds_tau(2) param_bounds_xi(2) param_bounds_xi(2)];    % upper bound

    % prior
    load(strcat(data_fol,'/priors/mod6/empirical_prior.mat'),'prior')
    param_names = {'Q0', 'gamma', 'gamma','tau', 'tau', 'xi', 'xi'};

    % fit model
    modelfunLL = @(x) modelMF_S0fixed_sgm0fixed(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_sgm0fixed_UCB_MAP(x,settings.params.param_names,ID,settings,data,gameIDs, prior, param_names);
    
    % fmincon
    options = optimoptions('fmincon','Display','off');
    a = settings.params.lb;
    b = settings.params.ub;

    mEmatparams = nan(8,size(settings.params.param_names,2));
    mEmatmle = nan(8,1);
    mEexitflag = nan(8,1);

    tic
    for iter=1:8
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