function [nLogL, mo, logL] = modelMF_S0fixed_eta_2sgm0_etaT(param_val,param_names,sID,settings,data,gameIDs,trials)

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
        [logL(c,g),mo] = model_game_MF_2sgm0_T(mo,tmp_dat,tmp_trials,c,g,settings.opts.TLT);
        
    end
end

%% calculate LogLikelihood
nLogL = sum(sum(logL)) * -1;