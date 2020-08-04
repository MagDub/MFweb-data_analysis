function [mo] = UCB(mo,idx_hor,idx_g,t)

%% load parameters
if length(mo.params.gamma) > 1
    gamma = mo.params.gamma(idx_hor);
else
    gamma = mo.params.gamma;
end
if isempty(gamma) || isnan(gamma) || isinf(abs(gamma))
    error('gamma parameter not set properly for UCB')
end

%gamma = mo.params.gamma(idx_hor);

%% load in current values
Q = mo.mat.Q{idx_hor,idx_g}(:,t);
sgm = mo.mat.sgm{idx_hor,idx_g}(:,t);
% 
% disp('in UCB')
% mo.mat.Q{idx_hor,idx_g}
% mo.mat.appleA{idx_hor,idx_g}
% mo.mat.appleB{idx_hor,idx_g}
% mo.mat.appleD{idx_hor,idx_g}
% disp(Q)

%% compute values
V = [];
for i = 1:length(Q)
    V(i) = Q(i) + (gamma*sgm(i));
end

%% calculate policy (only important for actual decision)
if strcmp(func2str(mo.funs.decfun),'softmax_argmax')
    pi = mo.funs.decfun(V,mo,idx_hor,idx_g);
else
    pi = mo.funs.decfun(V,mo,idx_hor);
end

%% write to mo
mo.mat.V_UCB{idx_hor,idx_g}(:,t) = V;
mo.mat.pi{idx_hor,idx_g}(:,t) = pi;



