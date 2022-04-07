function [ log ] = keeppriorsamples( log )

    log(~isnan(log(:,8)),:) = []; 

end

