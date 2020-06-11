function [log_AD, mat_AD, log_AD_long, log_AD_short, desc, log_AD_long_all, log_AD_short_all] = aggregate_choices_AD(user, gameID_AD)

log_AD = [];
log_AD_long = [];
log_AD_short = [];

ind_block = 1;
ind_block_trial = 2;
ind_horizon = 3;
ind_gameID = 4;
ind_size = 10;
ind_RT = 11;

k=1;
    % take GameID where AD where presented
    for j = 1:size(gameID_AD,2)
        i=1;
        while i<=size(user.log,1)
            if gameID_AD(j) == user.log(i,4) % 4 = gameID
                [~, sorted_AAAD_ind] = sort(user.item(1,user.log(i,4)).initial_apples.tree);
                if ~isnan(user.log(i+4,12)) %checks that tree was selected / button was pressed
                    mat_AD(k,1:4) = user.log(i+2,[ind_block ind_block_trial ind_horizon ind_gameID]);
                    mat_AD(k,5:7) = user.log(i+sorted_AAAD_ind(1:3)-1,ind_size); %size A
                    mat_AD(k,8) = user.log(i+sorted_AAAD_ind(4)-1,ind_size); % size D
                    mat_AD(k,9) = find((~isnan(user.log(i+4,6:9)))); %chosen tree
                    mat_AD(k,10) = user.log(i+4,ind_size); %size of chosen apple
                    mat_AD(k,11) = user.log(i+4,ind_RT);
                    k=k+1;
                    if user.log(i,3) == 11
                        log_AD(end+1,:) = user.log(i,:);
                        log_AD(end+1,:) = user.log(i+1,:);
                        log_AD(end+1,:) = user.log(i+2,:);
                        log_AD(end+1,:) = user.log(i+3,:);
                        log_AD(end+1,:) = user.log(i+4,:);
                        for l=1:10
                            log_AD_long(end+1,:) = user.log(i+l-1,:);
                        end
                        i = i+10; % n + 6 - 1 (long horizon)
                    elseif user.log(i,3) == 6
                        log_AD(end+1,:) = user.log(i,:);
                        log_AD(end+1,:) = user.log(i+1,:);
                        log_AD(end+1,:) = user.log(i+2,:);
                        log_AD(end+1,:) = user.log(i+3,:);
                        log_AD(end+1,:) = user.log(i+4,:);
                        for l=1:5
                            log_AD_short(end+1,:) = user.log(i+l-1,:);
                        end
                        i = i+5; % n + 1 - 1 (short horizon)
                    end
                    
                else
                    disp('Not in the AD format')
                end 
            else
                i=i+1;
            end
        end
    end
    
    log_AD_long_all = log_AD_long;
    log_AD_short_all = log_AD_short;
    
    % keep only trials where had to select apple
    log_AD_long(log_AD_long(:,11)==0,:) = [];   
    log_AD_short(log_AD_short(:,11)==0,:) = [];  
    
    for i=1:size(log_AD_long, 1)
        log_AD_long_(i,1:5) = log_AD_long(i,1:5);
        log_AD_long_(i,6) = find((~isnan(log_AD_long(i,6:9))));
        log_AD_long_(i,7:9) = log_AD_long(i,10:12);
    end
    
    log_AD_long = log_AD_long_;
    
    for i=1:size(log_AD_short, 1)
        log_AD_short_(i,1:5) = log_AD_short(i,1:5);
        log_AD_short_(i,6) = find((~isnan(log_AD_short(i,6:9))));
        log_AD_short_(i,7:9) = log_AD_short(i,10:12);
    end
    
    log_AD_short = log_AD_short_;
    
    for i=1:5
        desc{i}=user.log_desc{i};
    end
    desc{6}='Tree';
    desc{7}=user.log_desc{10};
    desc{8}=user.log_desc{11};
    desc{9}=user.log_desc{12};

end
