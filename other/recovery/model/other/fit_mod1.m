function fit_mod1(ID, data_fol, sim_dir, settings, data, gameIDs)

    results_dir = strcat(sim_dir, 'results/');
    
    % settings
    settings.desc = ['mod1']; 

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_sgm0 = [0.01,6];
    param_bounds_gamma = [10^-8,10]; 
    param_bounds_tau = [10^-8,7]; 
    param_bounds_Q0 = [1,10]; 
    param_bounds_w_hyb = [0,1];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    settings.funs.decfun            = @softmax;
    settings.funs.valuefun          = @hybrid; 
    settings.funs.learningfun       = @kalman_filt;
    settings.params.param_names     = {'Q0' 'sgm0' '' 'gamma'  ''  'tau'  ''  'w_hyb'};   
    settings.params.lb              = [param_bounds_Q0(1) param_bounds_sgm0(1) param_bounds_sgm0(1) param_bounds_gamma(1) param_bounds_gamma(1) param_bounds_tau(1) param_bounds_tau(1) param_bounds_w_hyb(1)];    % lower bound
    settings.params.ub              = [param_bounds_Q0(2) param_bounds_sgm0(2) param_bounds_sgm0(2) param_bounds_gamma(2) param_bounds_gamma(2) param_bounds_tau(2) param_bounds_tau(2) param_bounds_w_hyb(2)];    % upper bound

    % prior
    load(strcat(data_fol,'/priors/mod1/empirical_prior.mat'),'prior')
    param_names = {'Q0' 'sgm0' 'sgm0' 'gamma'  'gamma'  'tau'  'tau'  'w_hyb'};

    % fit model
    modelfunLL = @(x) modelMF_S0fixed_eta_2sgm0(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_eta_hybrid_MAP_2sgm0(x,settings.params.param_names,ID,settings,data,gameIDs, prior, param_names);
    
    % fmincon
    options = optimoptions('fmincon','Display','off');
    a = settings.params.lb;
    b = settings.params.ub;

    mEmatparams = nan(8,size(settings.params.param_names,2));
    mEmatmle = nan(8,1);
    mEexitflag = nan(8,1);

    tic
    parfor iter=1:2%8
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