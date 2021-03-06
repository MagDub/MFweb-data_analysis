function [n_sample, pow] = compute_sample_size_paired(diff)

m1 = 0;
m2 = mean(diff);

stdp = std(diff);

n_sample = 10;
pow = 0;

    while pow < 0.95
        
        n_sample = n_sample + 10;

        n_perm = 10000;

        grp1 = randn(n_sample,n_perm) .* stdp + m1;
        grp2 = randn(n_sample,n_perm) .* stdp + m2;
        h = ttest2(grp1,grp2);

        pow = sum(h)/n_perm;
        
    end

end

