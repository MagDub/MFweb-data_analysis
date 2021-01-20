function [b] = fct_compute_coeff(data_, n_trials)

    % Linear regression
    % score(=y) = bo + b1 * trial(=x)
    % Y = XB 
    % B = X\Y (mldivide operator = solves linear equation)
    
    x = (1:n_trials)';
    X = [ones(length(x),1) x]; % to have 2 coeff
    y = data_';
    b = X\y;

end

