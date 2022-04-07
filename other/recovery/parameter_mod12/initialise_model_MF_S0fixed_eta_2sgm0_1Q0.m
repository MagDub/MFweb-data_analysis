function mo = initialise_model_MF_S0fixed_eta_2sgm0_1Q0(settings)


%% set up model structure
mo = [];

%% set up parameters
mo.params.tau           = [];   % decision temperature
mo.params.eta           = [];
mo.params.xi            = [];   % lapse rate
mo.params.gamma         = [];   % variance scaling factor for UCB
mo.params.S0            = 0.8*ones(settings.task.N_games,1); % prior draw std (set up, so that learning can be implemented
mo.params.sgm0          = []; % prior mean std (set up, so that learning can be implemented
mo.params.Q0            = [];  % nan(settings.task.N_games,1); % prior mean (set up, so that learning can be implemented
mo.params.alpha         = []; % variance scaling factor for the simple model 
mo.params.w_hyb         = [];

%% set up matrices
mo.mat.Q(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(settings.task.N_trees,6)};   % Q-value(mean) - 4 trees, 6 draws (5 passive, 1 active)
mo.mat.sgm(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(settings.task.N_trees,6)};  % sigma: standard deviation
mo.mat.pi(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(settings.task.N_trees,6)};   % policy
mo.mat.k(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(6,1)};    % Kalman Gain
mo.mat.da(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(6,1)};    % prediction error
mo.mat.V_UCB = mo.mat.Q; % values for UCB
mo.mat.V_simple = mo.mat.Q; % values for the simple model 

mo.mat.appleA(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(settings.task.N_trees,3)}; 
mo.mat.appleB(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(settings.task.N_trees,1)}; 
mo.mat.appleD(1:settings.task.N_hor,1:settings.task.Ngames_per_hor) = {nan(settings.task.N_trees,1)}; 

% A matrix (to be computed to calculate difference scores for Thompson)
A = zeros(settings.task.N_trees-1,settings.task.N_trees,settings.task.N_trees);
for i = 1:settings.task.N_trees
    A(:,i,i) = 1;
    tmp = 1;
    for ii = 1:settings.task.N_trees
        if i ~= ii
            A(tmp,ii,i) = -1;
            tmp = tmp + 1;
        end
    end
end
mo.mat.A = A;

%% set up functions
mo.funs.decfun          = [];           % decision function default: softmax (only when UCB)
mo.funs.valuefun        = [];           % UCB, etc
mo.funs.priorfun        = [];           % how priors are set up
mo.funs.learningfun     = @kalman_filt; % learning model

%% other fun things
mo.warnings = {};