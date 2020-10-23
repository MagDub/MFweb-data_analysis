
addpath('fcts/')

% Compute sample size for at least 95% power - correlation
R_corr = 0.15; 
[n_sample_corr, pow_cor] = compute_sample_size_corr(R_corr);





