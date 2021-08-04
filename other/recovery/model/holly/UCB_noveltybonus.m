function [mo] = UCB_noveltybonus(mo,idx_hor,idx_g,t)

%% load parameters
if length(mo.params.gamma) > 1
    gamma = mo.params.gamma(idx_hor);
else
    gamma = mo.params.gamma;
end

if length(mo.params.eta) > 1
    eta = mo.params.eta(idx_hor);
else
    eta = mo.params.eta;
end

%eta = mo.params.eta;

if isempty(gamma) || isnan(gamma) || isinf(abs(gamma))
    error('gamma parameter not set properly for UCB')
end

%gamma = mo.params.gamma(idx_hor);

%% load in current values
Q = mo.mat.Q{idx_hor,idx_g}(:,t);
sgm = mo.mat.sgm{idx_hor,idx_g}(:,t);
 
% disp('in UCB')
% %mo.mat.Q{idx_hor,idx_g}
% disp(Q)

%% compute values
V = [];

if isempty(mo.mat.appleA{idx_hor,idx_g}) || isempty(mo.mat.appleB{idx_hor,idx_g})
    %disp('no A - BCD || no B - ACD')
    V(1) = Q(1) + (gamma*sgm(1));
    V(2) = Q(2) + (gamma*sgm(2)) + eta; %novelty bonus on tree C
    V(3) = Q(3) + (gamma*sgm(3)); 
elseif isempty(mo.mat.appleD{idx_hor,idx_g})
    %disp('no D - ABC')
    V(1) = Q(1) + (gamma*sgm(1));
    V(2) = Q(2) + (gamma*sgm(2));
    V(3) = Q(3) + (gamma*sgm(3)) + eta; %novelty bonus on tree C
else
    %disp('no C')
    for i = 1:length(Q)
        V(i) = Q(i) + (gamma*sgm(i));
    end
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



