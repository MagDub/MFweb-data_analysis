function [data,gameIDs] = aggregateDataSIM(params, user)

%% loop through games and aggregate
data = []; i6 = 1; i11 = 1;
gameIDs = [];

%user.log = {'Block','Blocktrial','Horizon','GameID','Trial','TreeA','TreeB','TreeC','TreeD','Size','RT','PressedKey', 'Unused Tree'};
tmp_user_log = user.log(user.log(:,5)==1,:);
size(unique(tmp_user_log(:,4)));

% if size(unique(tmp_user_log(:,4)),1)~=100
%     disp('Should be 100 in aggregateSim!!')
% end

for b = 1:params.task.exp.n_blocks
    for g = 1:params.task.exp.n_trialPB
        
        % index of trials in this games
        idx = find(user.log(:,1) == b & user.log(:,2) == g);
        
        % determine condition (horizon)
        if user.log(idx(1),3) == 6
            i = i6;
            i6 = i6 + 1;
            h_idx = 1;  % index for horizon
        elseif user.log(idx(1),3) == 11
            i = i11;
            i11 = i11 + 1;
            h_idx = 2;  % index for horizon
        else
            error('unknown horizon')
        end
              
        % aggregate previous trees
        idx_nonchos = idx(find(isnan(user.log(idx,12))));
        
        gameIDs(h_idx,i) = user.log(idx_nonchos(1),4);
        
        % tree A
        idx_a = idx_nonchos(find(user.log(idx_nonchos,6)==1));
        if ~isempty(idx_a)
            data(h_idx,i).a = user.log(idx_a,10);
        else
            data(h_idx,i).a = [];
        end
        
        % tree B
        idx_b = idx_nonchos(find(user.log(idx_nonchos,7)==1));
        if ~isempty(idx_b)
            data(h_idx,i).b = user.log(idx_b,10);
        else
            data(h_idx,i).b = [];
        end
        
        % tree C
        idx_c = idx_nonchos(find(user.log(idx_nonchos,8)==1));
        if ~isempty(idx_c)
            data(h_idx,i).c = user.log(idx_c,10);
        else
            data(h_idx,i).c = [];
        end
        
        % tree D
        idx_d = idx_nonchos(find(user.log(idx_nonchos,9)==1));
        if ~isempty(idx_d)
            data(h_idx,i).d = user.log(idx_d,10);
        else
            data(h_idx,i).d = [];
        end
        
        data(h_idx,i).unshown_tree = unique(user.log(idx_nonchos,13));
        
        % all non-choices in one matrix
        data(h_idx,i).alltrees = user.log(idx_nonchos,6:10); % trees a-d chosen, value obtained
        
        % alltrees without the unswhon_tree
        tmp_alltrees = data(h_idx,i).alltrees;
        tmp_alltrees(:,data(h_idx,i).unshown_tree) = [];
        data(h_idx,i).allshowntrees = tmp_alltrees; 
        
        % overall game number
        data(h_idx,i).gameNo = (b-1)*params.task.exp.n_trialPB + g;
    end
end