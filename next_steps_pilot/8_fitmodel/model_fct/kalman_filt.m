function mo = kalman_filt(mo,data,idx_hor,idx_g,t)

%% load in current values
Q = mo.mat.Q{idx_hor,idx_g}(:,t);
sgm = mo.mat.sgm{idx_hor,idx_g}(:,t);
S = mo.params.S0(1);
    
%% update mean and variance
idx = find(~isnan(data.allshowntrees(t,1:3))); % Changed

% prediction error
da = data.alltrees(t,5) - Q(idx); %size of apple at time t

% Kalman Gain
K = sgm(idx)^2 / (sgm(idx)^2 + S^2);

% update Q-value
Q(idx) = Q(idx) + K * da;

% update variance
sgm(idx) = sqrt(sgm(idx)^2 - K * sgm(idx)^2);

%% write to mat
mo.mat.Q{idx_hor,idx_g}(:,t+1) = Q;
mo.mat.sgm{idx_hor,idx_g}(:,t+1) = sgm;
mo.mat.da{idx_hor,idx_g}(t) = da;
mo.mat.unshown_tree{idx_hor,idx_g} = data.unshown_tree;