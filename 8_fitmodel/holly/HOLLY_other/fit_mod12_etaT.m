function fit_mod12_etaT(ID, data_fol)

    algo = 'mod12_etaT';
    results_dir = strcat(data_fol, '/modelfit/',algo,'/results/');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_sgm0 = [0.01,6];
    param_bounds_Q0 = [1,10]; 
    param_bounds_eta = [0,5];
    param_bounds_etaT = [0,5];
    param_bounds_xi = [10^-8,0.5];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % settings
    settings = [];
    settings.task.N_games           = 400;
    settings.task.N_hor             = 2;
    settings.task.Ngames_per_hor    = settings.task.N_games / settings.task.N_hor;
    settings.task.N_trees           = 3;
    settings.opts.TLT               = [];
    settings.funs.decfun            = @softmax;
    settings.funs.valuefun          = @mvnorm_Thompson_noveltybonus_etaT; 
    settings.funs.priorfun          = [];
    settings.funs.learningfun       = @kalman_filt;
    settings.desc                   = ['thompson'];    
    settings.params.param_names     = {'sgm0', '', 'Q0', 'eta', '', 'etaT', '', 'xi', ''}; 
    settings.params.lb              = [param_bounds_sgm0(1) param_bounds_sgm0(1)  param_bounds_Q0(1)  param_bounds_eta(1) param_bounds_eta(1) param_bounds_etaT(1) param_bounds_etaT(1) param_bounds_xi(1) param_bounds_xi(1)];    
    settings.params.ub              = [param_bounds_sgm0(2) param_bounds_sgm0(2)  param_bounds_Q0(2)  param_bounds_eta(2) param_bounds_eta(2) param_bounds_etaT(2) param_bounds_etaT(2) param_bounds_xi(2) param_bounds_xi(2)];    

    % get data
    data_dir = strcat(data_fol, 'concat_data/');
    [data,gameIDs,blocks, trials] = aggregateData_BT(ID,data_dir);

    % prior
    load(strcat(data_fol,'/priors/mod12_etaT/empirical_prior.mat'),'prior')
    param_names = {'sgm0', 'sgm0', 'Q0','eta', 'eta', 'etaT', 'etaT', 'xi', 'xi'};

    % fit model
    modelfunLL = @(x) modelMF_S0fixed_eta_2sgm0_etaT(x,settings.params.param_names,ID,settings,data,gameIDs,trials);
    modelfun = @(x) modelMF_S0fixed_eta_thomp4param_MAP_2sgm0_etaT(x,settings.params.param_names,ID,settings,data,gameIDs, prior, param_names,trials);

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