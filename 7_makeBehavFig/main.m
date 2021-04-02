addpath('./fct/')

load('../usermat_completed.mat')
load('../6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

plot_EV(to_del);
plot_IG(to_del);
plot_score(to_del);
plot_score_exclusion;

plot_consistency(to_del);
plot_consistency_per_tree(to_del);

plot_high_value(to_del);
plot_medium_value(to_del);
plot_novel_value(to_del);
plot_low_value(to_del);

