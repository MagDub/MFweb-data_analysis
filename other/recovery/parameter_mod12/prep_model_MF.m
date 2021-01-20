function mo = prep_model_MF(mo,settings,param_val,param_names)

%% fill in new params
% parameter hygiene
param_val(param_val==inf) = realmax;
param_val(param_val==-inf) = -realmax;

% fill in
for p = 1:length(param_names)
    if strcmp(param_names{p},'')    % same as prev params
        mo.params.(param_names{p-1})(2) = param_val(p);
    elseif length(mo.params.(param_names{p})) > 2;  % if it is a vector rather than just 1 param (e.g. prior)
        mo.params.(param_names{p})(:) = param_val(p);
    else
        mo.params.(param_names{p}) = param_val(p);
    end
end

%% fill in functions
fn = fieldnames(settings.funs);
for f = 1:length(fn)
    mo.funs.(fn{f}) = settings.funs.(fn{f});
end