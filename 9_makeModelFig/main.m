addpath('./fct/')

load('../usermat_completed.mat')
load('../6_exclude/to_exclude.mat')

to_del = [];
for i=1:size(to_exclude,2)
    tmp = to_exclude(i);
    to_del(end+1)=find(usermat_completed==tmp);
end

%plot_param_mod12_epsilon(to_del)
%plot_param_mod12_eta(to_del)
%plot_param_mod12_sgm0(to_del)
plot_param_mod12_Q0(to_del)