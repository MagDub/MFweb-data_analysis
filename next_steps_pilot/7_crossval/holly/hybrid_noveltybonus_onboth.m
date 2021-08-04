function [mo] = hybrid_noveltybonus_onboth(mo,idx_hor,idx_g,t)

if length(mo.params.w_hyb) > 1
    w_hyb = mo.params.w_hyb(idx_hor);
else
    w_hyb = mo.params.w_hyb;
end

%w_hyb = mo.params.w_hyb(idx_hor);

mo_thompson = mvnorm_Thompson_noveltybonus_new(mo,idx_hor,idx_g,t);
mo_UCB = UCB_noveltybonus(mo,idx_hor,idx_g,t);

pi_thomp = mo_thompson.mat.pi{idx_hor,idx_g}(:,t);
pi_UCB = mo_UCB.mat.pi{idx_hor,idx_g}(:,t);

pi_ = [];
for i = 1:length(pi_thomp)
    pi_ = w_hyb.* pi_thomp + (1-w_hyb).* pi_UCB;
end

mo.mat.pi{idx_hor,idx_g}(:,t) = pi_;

end
