function fit_mod8_Q0fixed(ID, data_fol, sim_dir, settings, data, gameIDs, param_bounds)

    results_dir = strcat(sim_dir, 'results/');
    
    % settings
    settings.desc = ['mod8']; 

    settings.funs.decfun            = @softmax;
    settings.funs.valuefun          = @UCB_noveltybonus; 
    settings.funs.learningfun       = @kalman_filt;
    settings.params.param_names     = {'gamma'  ''  'tau'  ''  'xi'  ''  'eta' ''};   
    settings.params.lb              = [param_bounds.gamma(1) param_bounds.gamma(1) param_bounds.tau(1) param_bounds.tau(1) param_bounds.xi(1) param_bounds.xi(1) param_bounds.eta(1) param_bounds.eta(1)];    % lower bound
    settings.params.ub              = [param_bounds.gamma(2) param_bounds.gamma(2) param_bounds.tau(2) param_bounds.tau(2) param_bounds.xi(2) param_bounds.xi(2) param_bounds.eta(2) param_bounds.eta(2)];    % upper bound

    % prior
    load(strcat(data_fol,'/priors/mod8_eta8/empirical_prior.mat'),'prior')
    param_names = {'Q0', 'gamma', 'gamma','tau', 'tau', 'xi', 'xi', 'eta', 'eta'};
    
    prior=prior(2:end);
    param_names=param_names(2:end);

    % fit model
    modelfunLL = @(x) modelMF_S0fixed_sgm0fixed_eta_Q0fixed(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_sgm0fixed_eta_UCB_MAP_Q0fixed(x,settings.params.param_names,ID,settings,data,gameIDs, prior, param_names);

    % fmincon
    options = optimoptions('fmincon','Display','off');
    a = settings.params.lb;
    b = settings.params.ub;

    mEmatparams = nan(8,size(settings.params.param_names,2));
    mEmatmle = nan(8,1);
    mEexitflag = nan(8,1);

    tic
    parfor iter=1:2 %8
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