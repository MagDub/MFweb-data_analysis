function [nMAP, nLogL, mo, logL] = modelMF_S0fixed_eta_thomp4param_MAP_2sgm0_1Q0(param_val,param_names,sID,settings,data,gameIDs, prior)

holly = 0;

%% fill in missing input arguments
if nargin < 5   % load data
    load(['./data/' int2str(sID) '_aggdata.mat'])
end


%% initialise model
mo = initialise_model_MF_S0fixed_eta_2sgm0_1Q0(settings);

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
%         disp([int2str(c) '_' int2str(g)])
        
        % to speed things up: only calculate if same game is not already
        % played
        g_idx = find(gameIDs(c,:)==gameIDs(c,g),1,'first');
        
        % replication of previous game, and no learning enabled
        if g_idx < g %&& mo.params.Q0((c-1)*settings.task.Ngames_per_hor+g)==mo.params.Q0((c-1)*settings.task.Ngames_per_hor+g_idx)
            
            % copy matrices from first game
            fn = fieldnames(mo.mat);
            for t = 1:length(fn)
                if iscell(mo.mat.(fn{t}))
                    mo.mat.(fn{t})(c,g) = mo.mat.(fn{t})(c,g_idx);
                end
            end
            
            % calc logL based on choice
            idx_chosen = data(c,g).chosen;
            
                %%%% Added
                if data(c,g).unshown_tree == 1
                    tree_vec = [2, 3, 4];
                elseif data(c,g).unshown_tree == 2
                    tree_vec = [1, 3, 4];
                elseif data(c,g).unshown_tree == 3
                    tree_vec = [1, 2, 4];
                elseif data(c,g).unshown_tree == 4
                    tree_vec = [1, 2, 3];
                end

                idx_chosen_tmp = find(tree_vec == idx_chosen); %Changed
                tmp_mo_pi = nanmean(mo.mat.pi{c,g},2); %Changed, the policy is not always in the last column
                pi_chos = tmp_mo_pi(idx_chosen_tmp); %Changed

                %%%%
            %
            %
            %
            logL(c,g) = log(pi_chos); % Changed
            
        else
        
            % data
            clear tmp_dat
            tmp_dat = data(c,g);
        
            % compute model game
            [logL(c,g),mo] = model_game_MF_2sgm0_1Q0(mo,tmp_dat,c,g,settings.opts.TLT);
        end
    end
end

%% calculate LogLikelihood
nLogL = sum(sum(logL)) * -1;

%% load priors and define densities

param_names = {'sgm0', 'sgm0', 'Q0','xi', 'xi', 'eta', 'eta'};
p_params = {prior(:).name}; params_prior = [];
for p = 1:length(param_names)
    % get equivalend
    idx = find(strcmp(p_params,param_names{p}));
    if isempty(idx)
        idx = find(cell2mat(strfind(p_params,param_names{p}(1:end-1))));
    end
    if isempty(idx) || numel(idx)>1
        error(['error when looking for prior of ' param_names{p}])
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