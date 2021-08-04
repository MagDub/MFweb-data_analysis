function [ data ] = make_mat( n_trials, data_str, n_col )

    data_1d = convert2num(data_str);
    
    for trial = 1:n_trials
        data(trial,:) = data_1d(n_col*(trial-1)+1:n_col*trial);
    end

end

