
%%%% CONDITION ABD %%%%

% TODO: pour ABC ?
% mettre combien y en a sur y-axis de row 2 sur fig

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

load('means_all_cat.mat');

edges = 1:10;

subplot(2,3,1)
hist(means_all_cat(:,1),edges); hold on;
plot(nanmean(means_all_cat(:,1))*ones(1,2), [1 850], 'r', 'LineWidth', 2)
xlim([1 10])
ylim([1 850])
xlabel('\mu_A')
ylabel({'Occurence: Total=3200 ','(50 trials x 64 subjects)'})
title('Bandit A')
box off;

subplot(2,3,2)
hist(means_all_cat(:,2),edges); hold on;
plot(nanmean(means_all_cat(:,2))*ones(1,2), [1 850], 'r', 'LineWidth', 2)
xlim([1 10])
ylim([1 850])
xlabel('\mu_B')
ylabel({'Occurence: Total=3200 ','(50 trials x 64 subjects)'})
title('Bandit B')
box off;

% split
[val_m, ind_m] = max(means_all_cat');

sameV = means_all_cat(:,1)==means_all_cat(:,2);
ind_m(sameV) = 3;

valHA = val_m(ind_m==1);
valHB = val_m(ind_m==2);
valHAB = val_m(ind_m==3);

subplot(2,3,4)
hist(valHA,edges); hold on;
plot(nanmean(valHA)*ones(1,2), [1 850], 'r', 'LineWidth', 2)
xlim([1 10])
ylim([1 850])
xlabel('\mu_A')
title('Bandit A when \mu_A > \mu_B')
box off;

subplot(2,3,5)
hist(valHB,edges); hold on;
plot(nanmean(valHB)*ones(1,2), [1 850], 'r', 'LineWidth', 2)
xlim([1 10])
ylim([1 850])
xlabel('\mu_B')
title('Bandit B when \mu_B > \mu_A')
box off;

subplot(2,3,6)
hist(valHAB,edges); hold on;
plot(nanmean(valHAB)*ones(1,2), [1 850], 'r', 'LineWidth', 2)
xlim([1 10])
ylim([1 850])
xlabel('\mu')
title('\mu_A = \mu_B')
box off;


% mean of each distrib
nanmean(means_all_cat)
% mean of each
[nanmean(valHA), nanmean(valHB)]



