function fit_mod12(ID, data_fol, sim_dir, settings, data, gameIDs)
    
    results_dir = strcat(sim_dir, 'results/');

    % settings
    settings.desc = ['mod12']; 
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param_bounds_sgm0 = [0.01,6];
    param_bounds_Q0 = [1,10]; 
    param_bounds_eta = [0,5];
    param_bounds_xi = [10^-8,0.5];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % settings
    settings.funs.decfun            = @softmax;
    settings.funs.valuefun          = @mvnorm_Thompson_noveltybonus_new; 
    settings.funs.learningfun       = @kalman_filt;
    settings.params.param_names     = {'sgm0', '', 'Q0', 'eta', '', 'xi', ''}; 
    settings.params.lb              = [param_bounds_sgm0(1) param_bounds_sgm0(1)  param_bounds_Q0(1)  param_bounds_eta(1) param_bounds_eta(1) param_bounds_xi(1) param_bounds_xi(1)];    
    settings.params.ub              = [param_bounds_sgm0(2) param_bounds_sgm0(2)  param_bounds_Q0(2)  param_bounds_eta(2) param_bounds_eta(2) param_bounds_xi(2) param_bounds_xi(2)];    

    % prior
    load(strcat(data_fol,'/priors/mod12/empirical_prior.mat'),'prior')
    param_names = {'sgm0', 'sgm0', 'Q0','eta', 'eta', 'xi', 'xi'};

    % fit model
    modelfunLL = @(x) modelMF_S0fixed_eta_2sgm0(x,settings.params.param_names,ID,settings,data,gameIDs);
    modelfun = @(x) modelMF_S0fixed_eta_thomp4param_MAP_2sgm0(x,settings.params.param_names,ID,settings,data,gameIDs, prior, param_names);

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