function pi = softmax(Vs,mo,idx_hor)

    %% get params
    % temperature parameter
    if length(mo.params.tau) > 1
        tau = mo.params.tau(idx_hor);
    else
        tau = mo.params.tau;
    end

    %% data hygiene
    VsT = (Vs - max(Vs)) ./ tau; % remove max to avoid numerical overflow (cf Friston spm_softmax)

    %% softmax transformation 
    pi = (exp(VsT) / sum(exp(VsT)));
    
end