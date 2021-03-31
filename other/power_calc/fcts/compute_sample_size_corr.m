function [n_sample, pow] = compute_sample_size_corr(R_corr)

mu_ = [0 0];

sigma_ = [1 1];

corr_ = [1 R_corr 
         R_corr 1];   
     
sig_ = corr2cov(sigma_, corr_);

n_sample = 100;
pow = 0;

    while pow < 0.95
        
        n_sample = n_sample + 10;

        n_perm = 100;

        for i = 1:n_perm
            data = mvnrnd(mu_,sig_,n_sample);
            [rho,pval] = corr(data);
            rho_mat(i) = rho(1,2);
            pval_mat(i) = pval(1,2);
        end

        pow = sum(pval_mat<.05)/n_perm;
        
    end

end
    
