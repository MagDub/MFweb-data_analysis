function [mean_, sem_, beta_] = compute_val(data_, n_part)

    n_trials = size(data_,2);

    mean_ = nanmean(data_,1);
    sem_ = nanstd(data_,1)/sqrt(n_part);
    beta_ = fct_compute_coeff(data_, n_trials);

end

