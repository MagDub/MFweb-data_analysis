function [mean_, sem_, beta_] = compute_val_mov_av(data_, n_part, window_)
    
    data_new = movmean(data_,window_,2); % 2: over columns

    n_trials = size(data_new,2);

    mean_ = nanmean(data_new,1);
    sem_ = nanstd(data_new,1)/sqrt(n_part);
    beta_ = fct_compute_coeff(data_new, n_trials);

end

