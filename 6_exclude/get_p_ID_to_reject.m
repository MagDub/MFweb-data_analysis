function [ p_ID_to_reject ] = get_p_ID_to_reject()

    load('../../data/questionnaire/demographics/raw/p_ID.mat')
    load('../../data/questionnaire/demographics/raw/userID.mat')
    load('../../data/questionnaire/demographics/raw/demo_desc.mat')
    load('../../data/questionnaire/demographics/raw/demo.mat')
    load('../../data/questionnaire/demographics/raw/approved.mat')
    
    not_completed_quest=find(demo(:,6)==0);

    p_ID_to_reject={};
    user_ID_to_reject={};
    for i=1:size(not_completed_quest,1)
        p_ID_to_reject{end+1,1} = p_ID{not_completed_quest(i)};
        p_ID_to_reject{end,2} = userID(not_completed_quest(i));
        p_ID_to_reject{end,3} = approved(not_completed_quest(i));
    end
    
    % pID, userID, approved
    index_app = find([p_ID_to_reject{:,3}] == 1);
    p_ID_to_reject(index_app,:) = [];


end

