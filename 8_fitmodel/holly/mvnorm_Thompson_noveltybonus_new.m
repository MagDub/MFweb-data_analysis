% Thompson sampling probability densities based on multivariate normals.
% see Speekenbrink & Konstantinidis 2015
function [mo] = mvnorm_Thompson_noveltybonus_new(mo,idx_hor,idx_g,t)






%% load parameters
A = mo.mat.A;

%% load in current values
Q = mo.mat.Q{idx_hor,idx_g}(:,t);
sgm = mo.mat.sgm{idx_hor,idx_g}(:,t);
n_opts = length(Q);


%% novelty bonus on tree C
if length(mo.params.eta) > 1
    eta = mo.params.eta(idx_hor);
else
    eta = mo.params.eta;
end

if isempty(mo.mat.appleA{idx_hor,idx_g}) || isempty(mo.mat.appleB{idx_hor,idx_g})
    Q(2) = Q(2) + eta; 
elseif isempty(mo.mat.appleD{idx_hor,idx_g})
    Q(3) = Q(3) + eta; 
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

% slow way of doing it
% [Gx Gy Gz]= meshgrid(x,x,x);
% Gx= Gx(:); Gy=Gy(:); Gz=Gz(:);
% for i = 1:n_opts
%     y(:,i) = sum(mvnpdf([Gx Gy Gz],dQ(:,i)',msgm(:,:,i))); 
% end

% fast
for i = 1:n_opts
    y(i) = mvncdf([0 0],-dQ(:,i)',msgm(:,:,i));   % double as fast than next line!!!
%     y(i) = mvncdf([0 0 0],[inf inf inf],dQ(:,i)',msgm(:,:,i));
end
pi = y./sum(y);

%% write to mo
mo.mat.pi{idx_hor,idx_g}(:,t) = pi;