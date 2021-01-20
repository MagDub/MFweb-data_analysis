function [ output_args ] = fct_plot_log_reg(data_per_trial, categories_)

data_per_trial_1 = changem(data_per_trial,[1 0 0 0],categories_);
% data_per_trial_2 = changem(data_per_trial,[0 1 0 0],categories_);
% data_per_trial_3 = changem(data_per_trial,[0 0 1 0],categories_);
% data_per_trial_4 = changem(data_per_trial,[0 0 0 1],categories_);

n_trials = 200;

x = 1:n_trials;
y = data_per_trial_1';

[b,dev,stats] = glmfit(x,y,'binomial','link','logit');

linear_comp = b(1) + (x * b(2));
fct_ = 1 ./ (1 + exp(-linear_comp));

close all;
plot(x,y,'o'); hold on
plot(x, fct_);
xlabel('Trial');
ylabel('High-value is chosen')

end

