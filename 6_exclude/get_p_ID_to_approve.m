function [ p_ID_to_approve ] = get_p_ID_to_approve()

    load('../../data/questionnaire/demographics/raw/p_ID.mat')
    load('../../data/questionnaire/demographics/raw/userID.mat')
    load('../../data/questionnaire/demographics/raw/demo_desc.mat')
    load('../../data/questionnaire/demographics/raw/demo.mat')
    load('../../data/questionnaire/demographics/raw/approved.mat')
    
    completed_quest=find(demo(:,6)==1);

    p_ID_to_approve={};
    user_ID_to_approve={};
    for i=1:size(completed_quest,1)
        p_ID_to_approve{end+1,1} = p_ID{completed_quest(i)};
        p_ID_to_approve{end,2} = userID(completed_quest(i));
        p_ID_to_approve{end,3} = approved(completed_quest(i));
    end
    
    % pID, userID, approved
    index_app = find([p_ID_to_approve{:,3}] == 1);
    p_ID_to_approve(index_app,:) = [];


end

