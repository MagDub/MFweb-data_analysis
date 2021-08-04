
%%%% CONDITION ABD %%%%

cond = 'AB';

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 20]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

col_(1,:) = [0.803921580314636 0.878431379795074 0.968627452850342]; 
col_(2,:) = [0.39215686917305 0.474509805440903 0.635294139385223];

load(strcat('concat_data/means_all_cat_',cond,'.mat'));

edges = 0.5:1:11;

subplot(2,3,1)
histogram(means_all_cat(:,1),'BinEdges', edges, 'FaceColor', col_(1,:)); hold on;
plot(nanmean(means_all_cat(:,1))*ones(1,2), [1 1000],':','Color', col_(2,:), 'LineWidth', 3);
w=plot(12,1,'w.');
xlim([1 10.2])
xticks(1:1:10)
ylim([1 950])
xlabel('\mu_A','FontName','Arial','Fontweight','bold','FontSize',14);
ylabel({'Total=3200 ','(50 trials x 64 subjects)'},'FontName','Arial','Fontweight','bold','FontSize',12);
legend(w, {strcat('$\bar{\mu_A}$=', num2str(nanmean(means_all_cat(:,1)),3))},'Interpreter','latex','FontSize',14); 
legend boxoff;
title('Bandit A means','FontSize',13)
box off;

subplot(2,3,2)
histogram(means_all_cat(:,2),'BinEdges', edges, 'FaceColor', col_(1,:)); hold on;
plot(nanmean(means_all_cat(:,2))*ones(1,2), [1 1000],':','Color', col_(2,:), 'LineWidth', 3);
w=plot(12,1,'w.');
xlim([1 10.2])
xticks(1:1:10)
ylim([1 950])
xlabel('\mu_B','FontName','Arial','Fontweight','bold','FontSize',14);
ylabel({'Total=3200 ','(50 trials x 64 subjects)'},'FontName','Arial','Fontweight','bold','FontSize',12);
legend(w, {strcat('$\bar{\mu_B}$=', num2str(nanmean(means_all_cat(:,2)),3))},'Interpreter','latex','FontSize',14); 
legend boxoff;
title('Bandit B means','FontSize',13)
box off;

% split
[val_m, ind_m] = max(means_all_cat');

sameV = means_all_cat(:,1)==means_all_cat(:,2);
ind_m(sameV) = 3;

valHA = val_m(ind_m==1);
valHB = val_m(ind_m==2);
valHAB = val_m(ind_m==3);

subplot(2,3,4)
histogram(valHA,'BinEdges', edges, 'FaceColor', col_(1,:)); hold on;
plot(nanmean(valHA)*ones(1,2), [1 1000],':','Color', col_(2,:), 'LineWidth', 3);
w=plot(12,1,'w.');
xlim([1 10.2])
xticks(1:1:10)
ylim([1 950])
xlabel('\mu_A','FontName','Arial','Fontweight','bold','FontSize',14);
ylabel(strcat('Total=', num2str(size(valHA,2))),'FontName','Arial','Fontweight','bold','FontSize',12);
legend(w, {strcat('$\bar{\mu_A}$=', num2str(nanmean(valHA),3))},'Interpreter','latex','FontSize',14, 'Location', 'NorthEast');
legend boxoff;
title('Bandit A means when \mu_A > \mu_B','FontSize',13)
box off;

subplot(2,3,5)
histogram(valHB,'BinEdges', edges, 'FaceColor', col_(1,:)); hold on;
plot(nanmean(valHB)*ones(1,2), [1 1000],':','Color', col_(2,:), 'LineWidth', 3);
w=plot(12,1,'w.');
xlim([1 10.2])
xticks(1:1:10)
ylim([1 950])
xlabel('\mu_B','FontName','Arial','Fontweight','bold','FontSize',14);
ylabel(strcat('Total=', num2str(size(valHB,2))),'FontName','Arial','Fontweight','bold','FontSize',12);
legend(w, {strcat('$\bar{\mu_B}$=', num2str(nanmean(valHB),3))},'Interpreter','latex','FontSize',14, 'Location', 'NorthWest');
legend boxoff;
title('Bandit B means when \mu_B > \mu_A','FontSize',13)
box off;

subplot(2,3,6)
histogram(valHAB,'BinEdges', edges, 'FaceColor', col_(1,:)); hold on;
plot(nanmean(valHAB)*ones(1,2), [1 1000],':','Color', col_(2,:), 'LineWidth', 3);
w=plot(12,1,'w.');
xlim([1 10.2])
xticks(1:1:10)
ylim([1 950])
xlabel('\mu','FontName','Arial','Fontweight','bold','FontSize',14);
ylabel(strcat('Total=', num2str(size(valHAB,2))),'FontName','Arial','Fontweight','bold','FontSize',12);
legend(w, {strcat('$\bar{\mu}$=', num2str(nanmean(valHAB),3))},'Interpreter','latex','FontSize',14, 'Location', 'NorthEast');
legend boxoff;
title('Means when \mu_A = \mu_B','FontSize',13)
box off;


% Export
addpath('../../../export_fig')
export_fig(['./Fig/Fig_visualisation_ABC.tif'],'-nocrop','-r200')


