function [log_BD, mat_BD, log_BD_long, log_BD_short, desc, log_BD_long_all, log_BD_short_all] = aggregate_choices_BD_new(user, gameID_BD)

log_BD = [];
log_BD_long = [];
log_BD_short = [];

ind_block = 1;
ind_block_trial = 2;
ind_horizon = 3;
ind_gameID = 4;
ind_size = 10;
ind_RT = 11;

k=1;
    % take GameID where BD where presented
    for j = 1:size(gameID_BD,2)
        i=1;
        while i<=size(user.log,1)
            if gameID_BD(j) == user.log(i,4) % 4 = gameID     
                
                %gameID_BD(1)==user.log(50,4)==1
                %gameID_BD(2)==user.log(441,4)==3
                
                [~, sorted_BD_ind] = sort(user.item(1,user.log(i,4)).initial_apples.tree);
                if ~isnan(user.log(i+2,11)) %checks that tree was selected / button was pressed
                    mat_BD(k,1:4) = user.log(i+2,[ind_block ind_block_trial ind_horizon ind_gameID]);
                    mat_BD(k,5) = user.log(i+sorted_BD_ind(1)-1,ind_size); %size B
                    mat_BD(k,6) = user.log(i+sorted_BD_ind(2)-1,ind_size); % size D
                    mat_BD(k,7) = find((~isnan(user.log(i+2,6:9)))); %chosen tree
                    mat_BD(k,8) = user.log(i+2,ind_size); %size of chosen apple
                    mat_BD(k,9) = user.log(i+2,ind_RT);
                    k=k+1;
                    if user.log(i,3) == 11
                        log_BD(end+1,:) = user.log(i,:);
                        log_BD(end+1,:) = user.log(i+1,:);
                        log_BD(end+1,:) = user.log(i+2,:);
                        for l=1:8
                            log_BD_long(end+1,:) = user.log(i+l-1,:);
                        end
                        i = i+8; % n + 6 - 1 (long horizon)
                    elseif user.log(i,3) == 6
                        log_BD(end+1,:) = user.log(i,:);
                        log_BD(end+1,:) = user.log(i+1,:);
                        log_BD(end+1,:) = user.log(i+2,:);
                        for l=1:3
                            log_BD_short(end+1,:) = user.log(i+l-1,:);
                        end
                        i = i+3; % n + 1 - 1 (short horizon)
                    end
                    
                else
                    disp('Not in the BD format')
                end
            else
                i=i+1;
            end
        end
    end

    log_BD_long_all = log_BD_long;
    log_BD_short_all = log_BD_short;
    
    % keep only trials where had to select apple
    log_BD_long(log_BD_long(:,11)==0,:) = [];   
    log_BD_short(log_BD_short(:,11)==0,:) = [];  
    
    for i=1:size(log_BD_long, 1)
        log_BD_long_(i,1:5) = log_BD_long(i,1:5);
        log_BD_long_(i,6) = find((~isnan(log_BD_long(i,6:9))));
        log_BD_long_(i,7:9) = log_BD_long(i,10:12);
    end
    
    log_BD_long = log_BD_long_;
    
    for i=1:size(log_BD_short, 1)
        log_BD_short_(i,1:5) = log_BD_short(i,1:5);
        log_BD_short_(i,6) = find((~isnan(log_BD_short(i,6:9))));
        log_BD_short_(i,7:9) = log_BD_short(i,10:12);
    end
    
    log_BD_short = log_BD_short_;
    
    for i=1:5
        desc{i}=user.log_desc{i};
    end
    desc{6}='Tree';
    desc{7}=user.log_desc{10};
    desc{8}=user.log_desc{11};
    desc{9}=user.log_desc{12};

end
