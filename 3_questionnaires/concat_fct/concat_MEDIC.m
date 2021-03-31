function [MEDIC_mat_desc, MEDIC_mat] = concat_MEDIC(quest)

    n_items = 2; % number of items in the questionnaire
    n_lett = 5; % number of letters of questionnaire name
    first_letter = 'M';

    space1 = 5;

    start = find(quest==first_letter);

    question = {};
    answer = [];
    
    for n = 1:n_items
        if isnan(str2double(quest(start(n)+n_lett+2)))
           fin = start(n)+n_lett+1;
        else
           fin = start(n)+n_lett+2;
        end
        
        tmp = quest(start(n):fin);
        item_no(n) = str2double(tmp(n_lett+2:end));
        fin = fin + space1;
        
        answer(end+1) = str2double(quest(fin));
        
    end
       
    MEDIC_mat_desc = {'Item', 'Response'};
    MEDIC_mat = [item_no; answer]';
    MEDIC_mat = sortrows(MEDIC_mat,1);
    

end

