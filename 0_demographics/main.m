
clear;

tmp = dir('prolific_export_*.csv');
filename = tmp.name;
T=readtable(tmp.name);

index1 = find(strcmp(T.participant_id, '60072a91f1bbf51aed4f8e03'));
T.participant_id{index1} = '60072a91f1bbf51aed4f803'; % manually remove the folder remaining with: 60072a91f1bbf51aed4f8e03

index2 = find(strcmp(T.participant_id, '56ce42d9465e580006846f57'));
T.participant_id{index2} = '556ce42d9465e580006846f57'; % unwanted additionial 5 when gave the link manually to participant

%T = T(13:end,:); % remove the pre-pilot

for i=1:size(T.Sex,1)
    if strcmp(T.Sex(i),'Female')
        gender(i) = 1;
    elseif strcmp(T.Sex(i),'Male')
        gender(i) = 0;
    else
        gender(i) = -1;
    end
end

for i=1:size(T.status,1)
    if strcmp(T.status(i),'RETURNED')
        returned(i) = 1;
    else
        returned(i) = 0;
    end
end

for i=1:size(T.status,1)
    if strcmp(T.status(i),'APPROVED')
        approved(i) = 1;
    else
        approved(i) = 0;
    end
end
approved = approved';


for i=1:size(T.age,1)
    if ~isempty(cell2mat(T.age(i)))
        age(i) = str2num(cell2mat(T.age(i)));
    else
        age(i) = nan;
    end
end

for i=1:size(T.num_rejections,1)
    rej(i) = str2num(cell2mat(T.num_rejections(i)));
    app(i) = str2num(cell2mat(T.num_approvals(i)));
end

rejection_percetage = rej ./ (app + rej) * 100;

userID = (1:size(T,1))';

% Completed questionnaire
for i=1:size(userID,1)
    
    tmp_completed = dir(strcat('../../data/raw/user_',int2str(userID(i)),'/questionnaires/*.xls'));
    
    if ~isempty(tmp_completed)
        completed_quest(i) = 1;
    else
        completed_quest(i) = 0;
    end
end

usermat_completed = find(completed_quest==1);

% Completed task
for i=1:size(userID,1)
    
    tmp_completed = dir(strcat('../../data/raw/user_',int2str(userID(i)),'/task/block_4_*.xls'));
    
    if ~isempty(tmp_completed)
        completed_task(i) = 1;
    else
        completed_task(i) = 0;
    end
end

usermat_completed_task = find(completed_task==1);

% Completed both
for i=1:size(userID,1)
    
    tmp_completed_1 = dir(strcat('../../data/raw/user_',int2str(userID(i)),'/task/block_4_*.xls'));
    tmp_completed_2 = dir(strcat('../../data/raw/user_',int2str(userID(i)),'/questionnaires/*.xls'));
    
    if ~isempty(tmp_completed_1) && ~isempty(tmp_completed_2)
        completed_both(i) = 1;
    else
        completed_both(i) = 0;
    end
end

usermat_completed_both = find(completed_both==1);

demo_desc = {'User' 'Age', 'Gender', 'RejectionPercentage', 'Returned', 'CompletedQuest'};
demo = [userID, age', gender', rejection_percetage', returned', completed_quest'];
p_ID = T.participant_id;

started_datetime = T.started_datetime;


for i=1:size(userID,1)
    folder_path = '../../data/raw/';
    oldName = strcat(folder_path,'prolific_id_',p_ID{i});
    newName = strcat(folder_path,'user_',int2str(userID(i)));
    if exist(oldName)
        isFolder(i)=1;
        movefile(oldName,newName);
    elseif exist(newName)
        isFolder(i)=1;
    else
        isFolder(i)=0;
    end
        
end

T.userID = userID;
T.completedAll = completed_both';
T.isFolder = isFolder';
T2 = [T(:,2) T(:,end-2:end) T(:,3:end-3) T(:,1)];

usermat_completed = usermat_completed_both;

%%% TODO understand problem
id_=find(usermat_completed==199);
usermat_completed(id_)=[];

save('../usermat_completed.mat', 'usermat_completed')
save('../usermat_completed_task.mat', 'usermat_completed_task')

save('../../data/questionnaire/demographics/raw/started_datetime.mat','started_datetime')
save('../../data/questionnaire/demographics/raw/p_ID.mat','p_ID')
save('../../data/questionnaire/demographics/raw/userID.mat','userID')
save('../../data/questionnaire/demographics/raw/approved.mat','approved')

save('../../data/questionnaire/demographics/raw/demo_desc.mat','demo_desc')
save('../../data/questionnaire/demographics/raw/demo.mat','demo')


filename = 'summary.xlsx';
writetable(T2,filename,'Sheet',1)

% save as users instead of prolific ID




