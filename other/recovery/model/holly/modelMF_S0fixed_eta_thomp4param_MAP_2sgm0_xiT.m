function [nMAP, nLogL, mo, logL] = modelMF_S0fixed_eta_thomp4param_MAP_2sgm0_xiT(param_val,param_names,sID,settings,data,gameIDs, prior, param_names_prior, trials)
holly = 0;

%% fill in missing input arguments
if nargin < 5   % load data
    load(['./data/' int2str(sID) '_aggdata.mat'])
end


%% initialise model
mo = initialise_model_MF_S0fixed_eta_2sgm0(settings);

%% fill in parameters, model-funs etc
mo = prep_model_MF(mo,settings,param_val,param_names);

%% fill in priors if not constant
if ~isempty(mo.funs.priorfun)
    mo = mo.funs.priorfun(mo);
end

%% loop through trials (and conditions)
logL = [];
for c = 1:settings.task.N_hor
    for g = 1:settings.task.Ngames_per_hor

        % data
        clear tmp_dat
        clear tmp_trials
        
        tmp_dat = data(c,g);
        tmp_trials = trials(c,g);

        % compute model game
        [logL(c,g),mo] = model_game_MF_2sgm0_xiT(mo,tmp_dat,tmp_trials,c,g,settings.opts.TLT);
        
    end
end

%% calculate LogLikelihood
nLogL = sum(sum(logL)) * -1;

%% load priors and define densities

p_params = {prior(:).name}; params_prior = [];
for p = 1:length(param_names_prior)
    % get equivalend
    idx = find(strcmp(p_params,param_names_prior{p}));
    if isempty(idx)
        idx = find(cell2mat(strfind(p_params,param_names_prior{p}(1:end-1))));
    end
    if isempty(idx) || numel(idx)>1
        error(['error when looking for prior of ' param_names_prior{p}])
    end
    
    % get estimate
    params_prior(p) = prior(idx).pd.pdf(param_val(p).* prior(idx).scale);
end

% get rid of inf
params_prior(find(params_prior==inf)) = realmax/2;

log_params_prior = log(params_prior);
log_params_prior(find(log_params_prior==-Inf)) = realmin;

%% merge to get MAP

MAP = nLogL*-1 + sum(log_params_prior); % nlogL*-1 is neg + log(0<..<1) is neg
nMAP = -1*MAP; % nMAP is bigger than nMLE