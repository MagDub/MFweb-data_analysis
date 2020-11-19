% function [n_sample, pow] = compute_effect_size_paired(n_sample, diff)

diff = EV_SH_mat-EV_LH_mat;
n_sample=130;

stdp = std(diff);

est_diff = 0;
pow = 0;

    while pow < 0.95
        
        est_diff = est_diff + 0.01;

        n_perm = 10000;

        grp1 = randn(n_sample,n_perm) .* stdp + 0;
        grp2 = randn(n_sample,n_perm) .* stdp + est_diff;
        h = ttest2(grp1,grp2);

        pow = sum(h)/n_perm;
        
    end

% end

