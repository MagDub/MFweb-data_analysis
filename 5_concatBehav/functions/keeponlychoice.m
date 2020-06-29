function [ log ] = keeponlychoice( log )

    log(isnan(log(:,8)),:) = []; 

end

