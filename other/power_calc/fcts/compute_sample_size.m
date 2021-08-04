function [n_sample, pow] = compute_sample_size(data1, data2)

m1 = mean(data1);
m2 = mean(data2);

std1 = std(data1);
std2 = std(data2);

n_sample = 10;
pow = 0;

    while pow < 0.95
        
        n_sample = n_sample + 10;

        n_perm = 10000;

        grp1 = randn(n_sample,n_perm) .* std1 + m1;
        grp2 = randn(n_sample,n_perm) .* std2 + m2;
        h = ttest2(grp1,grp2);

        pow = sum(h)/n_perm;
        
    end

end

