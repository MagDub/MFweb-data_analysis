function [log_ABD, mat_ABD,  log_ABD_long, log_ABD_short, desc, log_ABD_long_all, log_ABD_short_all] = aggregate_choices_ABD(user, gameID_ABD)

log_ABD = [];
log_ABD_long = [];
log_ABD_short = [];

ind_block = 1;
ind_block_trial = 2;
ind_horizon = 3;
ind_gameID = 4;
ind_size = 10;
ind_RT = 11;

k=1;
    % take GameID where AD where presented
    for j = 1:size(gameID_ABD,2)
        i=1;
        while i<=size(user.log,1)
            if gameID_ABD(j) == user.log(i,4) % 4 = gameID
%                 %% debug
%                 if user.log(i,4) == 10
%                    disp(strcat('block trial =', 32, int2str(user.log(i,2)))) 
%                 end

                [~, sorted_AAABD_ind] = sort(user.item(1,user.log(i,4)).initial_apples.tree);
                if ~isnan(user.log(i+5,12)) %checks that tree was selected / button was pressed
%                     %% debug
%                     if user.log(i,4) == 10
%                        disp(strcat('GameID, i =', 32,int2str(i), 32, ', i+5 RT :',32,  int2str(user.log(i+5,12)), ', horizon :', 32, int2str(user.log(i,3)), ', i+12 =', 32, int2str(i+12))) 
%                     end
                
                    mat_ABD(k,1:4) = user.log(i+2,[ind_block ind_block_trial ind_horizon ind_gameID]);
                    mat_ABD(k,5:7) = user.log(i+sorted_AAABD_ind(1:3)-1,ind_size); % size A
                    mat_ABD(k,8) = user.log(i+sorted_AAABD_ind(4)-1,ind_size); % size B
                    mat_ABD(k,9) = user.log(i+sorted_AAABD_ind(5)-1,ind_size); % size D
                    mat_ABD(k,10) = find((~isnan(user.log(i+5,6:9)))); %chosen tree
                    mat_ABD(k,11) = user.log(i+5,ind_size); %size of chosen apple
                    mat_ABD(k,12) = user.log(i+5,ind_RT);
                    k=k+1;
                    
                    if user.log(i,3) == 11
                        log_ABD(end+1,:) = user.log(i,:);
                        log_ABD(end+1,:) = user.log(i+1,:);
                        log_ABD(end+1,:) = user.log(i+2,:);
                        log_ABD(end+1,:) = user.log(i+3,:);
                        log_ABD(end+1,:) = user.log(i+4,:);
                        log_ABD(end+1,:) = user.log(i+5,:);
                        for l=1:11
                            log_ABD_long(end+1,:) = user.log(i+l-1,:);
                        end
                        i = i+11; % n + 6 (long horizon) %changed 12 to 11
                    elseif user.log(i,3) == 6
                        log_ABD(end+1,:) = user.log(i,:);
                        log_ABD(end+1,:) = user.log(i+1,:);
                        log_ABD(end+1,:) = user.log(i+2,:);
                        log_ABD(end+1,:) = user.log(i+3,:);
                        log_ABD(end+1,:) = user.log(i+4,:);
                        log_ABD(end+1,:) = user.log(i+5,:);
                        for l=1:6
                            log_ABD_short(end+1,:) = user.log(i+l-1,:);
                        end
                        i = i+6; % n + 1 (short horizon) %changed 7 to 6
                    end
                                       
                else                   
                    disp(strcat('Not in the ABD format, i :', 32, int2str(i), 32, 'j :', int2str(j)))
                    break
                end
            else
                i=i+1;
            end
        end
    end
    
    log_ABD_long_all = log_ABD_long;
    log_ABD_short_all = log_ABD_short;

    % keep only trials where had to select apple
    log_ABD_long(log_ABD_long(:,11)==0,:) = [];   
    log_ABD_short(log_ABD_short(:,11)==0,:) = [];  
    
    for i=1:size(log_ABD_long, 1)
        log_ABD_long_(i,1:5) = log_ABD_long(i,1:5);
        log_ABD_long_(i,6) = find((~isnan(log_ABD_long(i,6:9))));
        log_ABD_long_(i,7:9) = log_ABD_long(i,10:12);
    end
    
    log_ABD_long = log_ABD_long_;
    
    for i=1:size(log_ABD_short, 1)
        log_ABD_short_(i,1:5) = log_ABD_short(i,1:5);
        log_ABD_short_(i,6) = find((~isnan(log_ABD_short(i,6:9))));
        log_ABD_short_(i,7:9) = log_ABD_short(i,10:12);
    end
    
    log_ABD_short = log_ABD_short_;
    
    for i=1:5
        desc{i}=user.log_desc{i};
    end
    desc{6}='Tree';
    desc{7}=user.log_desc{10};
    desc{8}=user.log_desc{11};
    desc{9}=user.log_desc{12};

end
