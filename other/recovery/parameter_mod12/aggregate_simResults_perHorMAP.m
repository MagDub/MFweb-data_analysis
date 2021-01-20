function aggregate_simResults_perHorMAP(out_dir)
    
    sim_name = 'sim_thompson';

    % get data       
    sim_dir = strcat(out_dir,'results/');
    list = dir([sim_dir '*' sim_name '*_results.mat']);
    n_junks = length(list);

    % loop through data and assemble
    disp('aggregating data...')
    out = [];

    for i = 1:n_junks
        clear tmp tmp2
        if mod(i,1000) == 0
            disp(i)
        end

        % load
        tmp = load([sim_dir list(i).name]);

        if i == 1   % instantiate matrices
            out.org = nan(n_junks,length(tmp.settings.params.param_names));
            out.fitted = nan(n_junks,length(tmp.mE.params));
        end

        % fill in fitted
        out.fitted(tmp.ID,:) = tmp.mE.params;

        % load and fill original
        tmp2 = load([sim_dir 'sim_' int2str(tmp.ID) '.mat']);
        out.org(tmp.ID,:) = tmp2.para_vals;

    end
    
    disp(out);

    % save
    disp('saving')
    save([out_dir, 'out_' sim_name '.mat'],'out')
    

end