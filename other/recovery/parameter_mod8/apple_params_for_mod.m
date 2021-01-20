function [params, user] = apple_params_for_mod()

params = [];
user = [];
params.task.exp.n_trialPB = 100; 
params.task.exp.n_blocks = 4;


%%
n_cond = 2;
items_per_cond = 100; 

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
visualisation = 0;

%%%%%%%%%%%%%
%%% MEANS %%%
%%%%%%%%%%%%%
% Tree A
meanA_mean = [5 7];
%meanA_mean = [6 6];
meanA_var = 0.7 ;
%meanA_var = 0 ;
% Tree B with respect to tree A => Tree A mean +- 1/2
meanB_var = [1 2]; 
%meanB_var = [1 1]; 
% Tree C with respect to tree A or B => (Tree A or B) mean +- 1/2
meanC_var = [1 2]; 
%meanC_var = [1 1]; 
% Tree D with respect to tree A => min(treeA, treeB, treeC) -1 or -2
meanD_var = [-1 -1]; 
%meanD_var = [-1 -1]; 
%%%%%%%%%%%%%
%%%% VAR %%%%
%%%%%%%%%%%%%
SD = 0.8;
%SD = 0;
inf_bound = 2;
sup_bound = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%%%%%%%%%%%% set the means %%%%%%%%%%%%
num_items = items_per_cond; % 3/4 because there's only 3 trees used each trial (not 4)

% Tree A
means = [round(randn(num_items/2,1)*2*meanA_var-meanA_var+meanA_mean(1))' round(randn(num_items/2,1)*2*meanA_var-meanA_var+meanA_mean(2))'];
means = means(randperm(length(means)));
means(means<inf_bound+2)=inf_bound+2; %changed
means(means>sup_bound-1)=sup_bound-1; %changed

% Tree B 
tmp = [meanB_var(1)*ones(1,num_items/4) -meanB_var(1)*ones(1,num_items/4) meanB_var(2)*ones(1,num_items/4) -meanB_var(2)*ones(1,num_items/4)];
tmp_means2 = means(1,:) + tmp; %changed
tmp_means2(tmp_means2<inf_bound+1)=inf_bound+1; %changed (+1 because D can be inf_bound)
tmp_means2(tmp_means2>sup_bound)=sup_bound; %changed
means(2,:) = tmp_means2; %changed

% Tree C
tmp = [meanC_var(1)*ones(1,num_items/4) -meanC_var(1)*ones(1,num_items/4) meanC_var(2)*ones(1,num_items/4) -meanC_var(2)*ones(1,num_items/4)];
tmp = tmp(randperm(length(tmp)));
tmp_means3 = [means(1,1:length(means(1,:))/2) means(2,1:length(means(2,:))/2)] + tmp ;
tmp_means3(tmp_means3<inf_bound+1)=inf_bound+1; %changed (+1 because D can be inf_bound)
tmp_means3(tmp_means3>sup_bound)=sup_bound; %changed
means(3,:) = tmp_means3; %changed

% Tree D
tmp = [meanD_var(1)*ones(1,num_items/2) meanD_var(2)*ones(1,num_items/2)];
for i=1:items_per_cond
    tmp_means4(i) = min(means(1,i), min(means(2,i), means(3,i))) + tmp(i); %changed
end
tmp_means4(tmp_means4<inf_bound)=inf_bound; %changed 
means(4,:) = tmp_means4; %changed

%%
%%%%%%%%%%%%%%%%%%% Visualisation %%%%%%%%%%%%%%%%%%%
if visualisation == 1
    figure(2)
    subplot(1,4,1); hist(means(1,:),100); axis([0 10 0 60]); title('Distribution of Tree A means'); legend(strcat('(',mat2str(meanA_mean(1)),32,'or', 32,mat2str(meanA_mean(2)),') + [-',mat2str(meanA_var),',',mat2str(meanA_var),']'))
    subplot(1,4,2); hist(means(2,:),100); axis([0 10 0 60]); title('Distribution of Tree B means'); legend(strcat('Tree A +/- ',32,'(',mat2str(meanB_var(1)),',',mat2str(meanB_var(2)),')'))
    subplot(1,4,3); hist(means(3,:),100); axis([0 10 0 60]); title('Distribution of Tree C means'); legend(strcat('(Tree A or Tree B) +/- ',32,'(',mat2str(meanC_var(1)),',',mat2str(meanC_var(2)),')'))
    subplot(1,4,4); hist(means(4,:),100); axis([0 10 0 60]); title('Distribution of Tree D means'); legend(strcat('min(Tree A, Tree C, Tree D)',32,mat2str(meanD_var(1)),'/',mat2str(meanD_var(2))))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Only 3 trees shown out of 4 every time

unused_tree = [1*ones(1,items_per_cond/4) 2*ones(1,items_per_cond/4) 3*ones(1,items_per_cond/4) 4*ones(1,items_per_cond/4)];
unused_tree = unused_tree(randperm(length(unused_tree)));


%%
user.means = means';

%%%%%%%%%%%% set up SDs %%%%%%%%%%%%

% draw 9 apples (maximum apples possible for tree_A -> 3 initial + 6 picked)
hor = [9 4];
for t = 1:items_per_cond
    for tree=1:4
        r=[];
        r = user.means(t,tree) + SD.*randn(1,hor(1));
        if tree==1 || tree == 2 || tree == 3 %Whole loop changed
            for i=1:size(r,2)
                if r(1,i)<inf_bound+1 
                    r(1,i) = inf_bound+1;
                elseif r(1,i)>sup_bound
                    r(1,i) = sup_bound;
                end
            end
        elseif tree == 4    
            for i=1:size(r,2)
                if r(1,i)<inf_bound 
                    r(1,i) = inf_bound;
                elseif r(1,i)>sup_bound
                    r(1,i) = sup_bound;
                end
            end
        end
        user.item(1,t).sequences(tree,:) = round(r(1,:));
        
%         % Changed -> Make sure that D is the smallest
         for col = 1:size(user.item(1,t).sequences,2)
             minimas = find(user.item(1,t).sequences(:,col) == min(user.item(1,t).sequences(:,col)));
                 while size(minimas,1)~=1 || (size(minimas,1)==1 && minimas~=4)
                     user.item(1,t).sequences(4,col) = min(user.item(1,t).sequences(:,col))-1;
                     minimas = find(user.item(1,t).sequences(:,col) == min(user.item(1,t).sequences(:,col)));
                 end
         end
    end
end

%%
%%%%%%%%%%%%%%%%%%% Visualisation %%%%%%%%%%%%%%%%%%%
if visualisation == 1
    figure(3)
    bins=50;
    subplot(1,4,1); all = user.item(1,1).sequences(1,:);
    for t=2:items_per_cond
        all = horzcat(all,user.item(1,t).sequences(1,:));
    end
    mean_ = user.item(1,1).tree_distribution(1).mu;
    for t=2:items_per_cond
        mean_ = horzcat(mean_,user.item(1,t).tree_distribution(1).mu);
    end
    hist(all,bins); clear all; title({'Apples from tree A',strcat('Mean of means = ',32,mat2str(mean(mean_))),strcat('Var of means = ',32,mat2str(round(var(mean_),3))),strcat('Var of each mean',32, mat2str(SD))}); legend('trials = 100, horizon = 9 <=> 900 apples/tree');
    clear mean_;
    
    subplot(1,4,2); all = user.item(1,1).sequences(2,:);
    for t=2:items_per_cond
        all = horzcat(all,user.item(1,t).sequences(2,:));
    end
    mean_ = user.item(1,1).tree_distribution(2).mu;
    for t=2:items_per_cond
        mean_ = horzcat(mean_,user.item(1,t).tree_distribution(2).mu);
    end
    hist(all,bins); clear all; title({'Apples from tree B',strcat('Mean of means = ',32,mat2str(mean(mean_))),strcat('Var of means = ',32,mat2str(round(var(mean_),3))),strcat('Var of each mean',32, mat2str(SD))});
    clear mean_;
    
    subplot(1,4,3); all = user.item(1,1).sequences(3,:);
    mean_ = user.item(1,1).tree_distribution(3).mu;
    for t=2:items_per_cond
        all = horzcat(all,user.item(1,t).sequences(3,:));
    end
    for t=2:items_per_cond
        mean_ = horzcat(mean_,user.item(1,t).tree_distribution(3).mu);
    end
    hist(all,bins); clear all; title({'Apples from tree C',strcat('Mean of means = ',32,mat2str(mean(mean_))),strcat('Var of means = ',32,mat2str(round(var(mean_),3))),strcat('Var of each mean',32, mat2str(SD))});
    clear mean_;
    
    subplot(1,4,4); all = user.item(1,1).sequences(4,:);
    mean_ = user.item(1,1).tree_distribution(4).mu;
    for t=2:items_per_cond
        all = horzcat(all,user.item(1,t).sequences(4,:));
    end
    for t=2:items_per_cond
        mean_ = horzcat(mean_,user.item(1,t).tree_distribution(4).mu);
    end
    hist(all,bins); clear all; title({'Apples from tree D',strcat('Mean of means = ',32,mat2str(mean(mean_))),strcat('Var of means = ',32,mat2str(round(var(mean_),3))),strcat('Var of each mean',32, mat2str(SD))});
    clear mean_;
end

%%
%%%%%%%%%%%% Pick apples %%%%%%%%%%%%

user.unused_tree = unused_tree;

% sequence with the indexes of apples that will be chosen for each tree
for trial = 1:items_per_cond
    
    for tree_=1:4
    rand_=randperm(9);
        for cond_=1:2
            user.item(cond_,trial).chosen_idx(tree_,:) = rand_;
        end
    end

% ix = seen apples
if user.unused_tree(trial) == 3
    ix = randperm(5);
elseif (user.unused_tree(trial) == 4 || user.unused_tree(trial) == 2)
    ix = randperm(4);
elseif (user.unused_tree(trial) == 1)
    ix = randperm(2);
end
    
    %%% INIITIAL APPLES PICKED %%%
    % 3 apples from tree A, 1 from tree B, 0 from tree C and 1 from tree D
    user.item(1,trial).initial_apples.size = [];
    user.item(1,trial).initial_apples.tree = [];
    
    % Tree A
    if user.unused_tree(trial) ~= 1
        for i = 1:3
            user.item(1,trial).initial_apples.size(end+1) = user.item(1,trial).sequences(1,user.item(1,trial).chosen_idx(1,i));
            user.item(1,trial).initial_apples.tree(end+1) = 1;
        end
    end
    
    % Tree B
    if user.unused_tree(trial) ~= 2
        user.item(1,trial).initial_apples.size(end+1) = user.item(1,trial).sequences(2,user.item(1,trial).chosen_idx(2,1));
        user.item(1,trial).initial_apples.tree(end+1) = 2;
    end
    
    % Tree D
    if user.unused_tree(trial) ~= 4
        user.item(1,trial).initial_apples.size(end+1) = user.item(1,trial).sequences(4,user.item(1,trial).chosen_idx(4,1));
        user.item(1,trial).initial_apples.tree(end+1) = 4;
    end
    
    %randomize order of A, B, D  
    user.item(1,trial).initial_apples.size = user.item(1,trial).initial_apples.size(ix);
    user.item(1,trial).initial_apples.tree = user.item(1,trial).initial_apples.tree(ix);      

    %%% FUTURE APPLES PICKED %%%
    user.item(1,trial).future_apples.tree(:,:) = nan(4,9);
    % Tree A
    user.item(1,trial).future_apples.tree(1,1:6) = user.item(1,trial).sequences(1,user.item(1,1).chosen_idx(1,4:hor(1)));
    % Tree B
    user.item(1,trial).future_apples.tree(2,1:8) = user.item(1,trial).sequences(2,user.item(1,1).chosen_idx(2,2:hor(1)));
    % Tree C
    user.item(1,trial).future_apples.tree(3,:) = user.item(1,trial).sequences(3,user.item(1,1).chosen_idx(3,1:hor(1)));
    % Tree D
    user.item(1,trial).future_apples.tree(4,1:8) = user.item(1,trial).sequences(4,user.item(1,1).chosen_idx(4,2:hor(1)));
    
    % tree that is not used has all its values replaced by nans
    for tree_=1:4
        if user.unused_tree(trial) == tree_
          user.item(1,trial).sequences(tree_,:) = nan(1,9);
          user.item(1,trial).future_apples.tree(tree_,:) = nan(1,9);
        end
    end
end

%% duplicate and split in 2 horizons
for cond=1:n_cond
    for t = 1:items_per_cond
        user.item(cond,t) = user.item(1,t);
        if cond == 1
            user.item(cond,t).hor = 11;
        else
            user.item(cond,t).hor = 6;
        end
    end
end

%% shuffle items for each condition
for c = 1:n_cond
    item_idxs{c,1} = randperm(items_per_cond);
    item_idxs{c,2} = randperm(items_per_cond);
end

%% set up trial order (balance conditions in each block)

N_cond_per_block = params.task.exp.n_trialPB / n_cond;
conds = repmat(1:n_cond,1,N_cond_per_block);

%% fill in condition and item for each block
for b = 1:params.task.exp.n_blocks
    user.block(b).item(:,1) = conds(randperm(length(conds)));    % condition
    for c = 1:n_cond
        idx = find(user.block(b).item(:,1)==c);
        if b < 3    % first half of experiment
            user.block(b).item(idx,2) = item_idxs{c,1}(1:length(idx));    % item number assignment
            item_idxs{c,1}(1:length(idx)) = []; % prevent multiple usages
        else        % second half of exp
            user.block(b).item(idx,2) = item_idxs{c,2}(1:length(idx));    % item number assignment
            item_idxs{c,2}(1:length(idx)) = []; % prevent multiple usages
        end
    end
end


%% prepare logfile
user.log_desc = {'Block','Blocktrial','Horizon','GameID','Trial','TreeA','TreeB','TreeC','TreeD','Size','RT', 'PressedKey'};
user.log = [];

%end