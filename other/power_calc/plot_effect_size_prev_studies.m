
close all;
clear;
  
R_corr = 0.15;

%% Simulate power

mu_ = [0 0];

sigma_ = [1 1];

corr_ = [1 R_corr 
         R_corr 1];    

sig_ = corr2cov(sigma_, corr_);

n_subj_mat = 10:5:700;

n_perm = 10000;


% for n = 1:size(n_subj_mat,2)
%     
%     n_subj = n_subj_mat(n);
%     
% 
%     for i = 1:n_perm
%         data = mvnrnd(mu_,sig_,n_subj);
%         [rho,pval] = corr(data);
%         rho_mat(i) = rho(1,2);
%         pval_mat(i) = pval(1,2);
%     end
%     
%     % plot(data(:,1),data(:,2),'.')
%     
%     power = sum(pval_mat<.05)/n_perm;
%     power_mat(n) = power;
%     
%     if mod(n_subj,100)==0
%         disp(['Nb subjects:', num2str(n_subj), 32, 'Power: ' num2str(power,'%.3f') '%'])
%     end
%   
% end
% 
% save(strcat('power_mat_n_perm_',int2str(n_perm),'_R_corr_', num2str(R_corr,2),'.mat'), 'power_mat');


%% Plot

load('power_mat_n_perm_10000_R_corr_0.15.mat')

plot(n_subj_mat, power_mat); hold on;
plot(n_subj_mat, 0.95*ones(1,size(n_subj_mat,2)), 'r--');
plot(580*ones(1,2),[0 1], 'r-');
xticks([100:100:700])
% grid on;

xlabel('Subject Nb')
xlim([n_subj_mat(1) 700])

ylabel('Power')
ylim([0 1])

saveas(gcf,strcat('power_simulation_n_perm_',int2str(n_perm),'_R_corr_', num2str(R_corr,2),'.png'))
