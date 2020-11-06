% Thompson sampling probability densities based on multivariate normals.
% see Speekenbrink & Konstantinidis 2015
function [mo] = mvnorm_Thompson_noveltybonus_etaT(mo,idx_hor,idx_g,t, trials)


    %% load parameters
    A = mo.mat.A;

    if length(mo.params.eta) > 1
        eta = mo.params.eta(idx_hor);
    else
        eta = mo.params.eta;
    end

    if length(mo.params.etaT) > 1
        etaT = mo.params.etaT(idx_hor);
    else
        etaT = mo.params.etaT;
    end

    %% load in current values
    Q = mo.mat.Q{idx_hor,idx_g}(:,t);
    sgm = mo.mat.sgm{idx_hor,idx_g}(:,t);
    n_opts = length(Q);

    %% novelty bonus on tree C
    if isempty(mo.mat.appleA{idx_hor,idx_g}) || isempty(mo.mat.appleB{idx_hor,idx_g})
        Q(2) = Q(2) + eta + etaT*(trials-200.5); % trial: 1:400 -> -199.5:199.5 (centralised)
    elseif isempty(mo.mat.appleD{idx_hor,idx_g})
        Q(3) = Q(3) + eta + etaT*(trials-200.5); 
    end

    %% Mean vector: differences of means
    dQ = [];
    for i = 1:n_opts
        dQ(:,i) = A(:,:,i)*Q;
    end
    
    %% covariance matrix
    msgm = [];
    for i = 1:n_opts
        msgm(:,:,i) = A(:,:,i)*diag(sgm.^2)*A(:,:,i)';
    end

    %% compute multivariat normal
    y = [];

    for i = 1:n_opts
        y(i) = mvncdf([0 0],-dQ(:,i)',msgm(:,:,i));  
    end
    pi = y./sum(y);

    %% write to mo
    mo.mat.pi{idx_hor,idx_g}(:,t) = pi;

end