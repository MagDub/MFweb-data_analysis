function [] = make_hist_figure(mat_AB, mat_ABD, mat_AD, mat_BD, part_num, direc)

figure()
hist_centers = 1:0.25:4;
mat_all_picked_apples(1,:) = [mat_AB(:,3)', mat_ABD(:,3)', mat_AD(:,3)',mat_BD(:,3)'];
mat_all_picked_apples(2,:) = [mat_AB(:,end-2)', mat_ABD(:,end-2)', mat_AD(:,end-2)',mat_BD(:,end-2)'];

subplot(2,3,1)
[hist_AB_short, hist_AB_long] = make_hist_data(mat_AB);
histogram(hist_AB_short-0.15,hist_centers-0.15, 'Normalization', 'probability'); hold on;
histogram(hist_AB_long+0.15,hist_centers+0.15, 'Normalization', 'probability');
set(gca, 'XTick', 1.1:1:4.1);
xticklabels({'A','B','C','D'})
xlabel('Tree')
ylabel('Probability')
legend('Short horizon', 'Long horizon')
title('AB trials')

subplot(2,3,2)
[hist_ABD_short, hist_ABD_long] = make_hist_data(mat_ABD);
histogram(hist_ABD_short-0.15,hist_centers-0.15, 'Normalization', 'probability'); hold on;
histogram(hist_ABD_long+0.15,hist_centers+0.15, 'Normalization', 'probability');
set(gca, 'XTick', 1.1:1:4.1);
xticklabels({'A','B','C','D'})
xlabel('Tree')
ylabel('Probability')
legend('Short horizon', 'Long horizon')
title('ABD trials')

subplot(2,3,4)
[hist_AD_short, hist_AD_long] = make_hist_data(mat_AD);
histogram(hist_AD_short-0.15,hist_centers-0.15, 'Normalization', 'probability'); hold on;
histogram(hist_AD_long+0.15,hist_centers+0.15, 'Normalization', 'probability');
set(gca, 'XTick', 1.1:1:4.1);
xticklabels({'A','B','C','D'})
xlabel('Tree')
ylabel('Probability')
legend('Short horizon', 'Long horizon')
title('AD trials')

subplot(2,3,5)
[hist_BD_short, hist_BD_long] = make_hist_data(mat_BD);
histogram(hist_BD_short-0.15,hist_centers-0.15, 'Normalization', 'probability'); hold on;
histogram(hist_BD_long+0.15,hist_centers+0.15, 'Normalization', 'probability');
set(gca, 'XTick', 1.1:1:4.1);
xticklabels({'A','B','C','D'})
xlabel('Tree')
ylabel('Probability')
legend('Short horizon', 'Long horizon')
title('BD trials')

subplot(2,3,3)
[hist_all_short, hist_all_long] = make_hist_data_all(mat_all_picked_apples');
histogram(hist_all_short-0.15,hist_centers-0.15, 'Normalization', 'probability'); hold on;
histogram(hist_all_long+0.15,hist_centers+0.15, 'Normalization', 'probability');
set(gca, 'XTick', 1.1:1:4.1);
xticklabels({'A','B','C','D'})
xlabel('Tree')
ylabel('Probability')
legend('Short horizon', 'Long horizon')
title('All trials')

subplot(2,3,6)
bar([size(mat_AB,1), size(hist_AB_short,2), size(hist_AB_long,2), ...
    size(mat_ABD,1), size(hist_ABD_short,2), size(hist_ABD_long,2), ...
    size(mat_AD,1), size(hist_AD_short,2), size(hist_AD_long,2), ...
    size(mat_BD,1), size(hist_BD_short,2), size(hist_BD_long,2)]);
xticklabels({'AB','short', 'long','ABD','short', 'long', 'AD','short', 'long', 'ABD','short', 'long'})
ylabel('Number of trials')
xlabel('Trial type')
title('Number of trials')

title(strcat('Participant', 32, part_num))    
savefig(strcat(direc, '/histograms.fig'))
saveas(gcf, strcat(direc, '/histograms.png'))

%%% SAVE

% AB
hist_AB_mat(1,:) = hist_AB_short;
hist_AB_mat(2,:) = hist_AB_long;
save(strcat(direc, '/hist_AB'), 'hist_AB_mat')
% ABD
hist_ABD_mat(1,:) = hist_ABD_short;
hist_ABD_mat(2,:) = hist_ABD_long;
save(strcat(direc, '/hist_ABD'), 'hist_ABD_mat')
% AD
hist_AD_mat(1,:) = hist_AD_short;
hist_AD_mat(2,:) = hist_AD_long;
save(strcat(direc, '/hist_AD'), 'hist_AD_mat')
% BD
hist_BD_mat(1,:) = hist_BD_short;
hist_BD_mat(2,:) = hist_BD_long;
save(strcat(direc, '/hist_BD'), 'hist_BD_mat')
% all
hist_all_mat(1,:) = hist_all_short;
hist_all_mat(2,:) = hist_all_long;
save(strcat(direc, '/hist_all'), 'hist_all_mat')


end
