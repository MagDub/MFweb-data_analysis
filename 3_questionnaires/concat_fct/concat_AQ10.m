function [AQ10_mat_desc, AQ10_mat, AQ10_score_desc, AQ10_score] = concat_AQ10(quest)

    n_items = 10; % number of items in the questionnaire
    n_lett = 4; % number of letters of questionnaire name
    first_letter = 'A';

    space1 = 5;

    start = find(quest==first_letter);

    question = {};
    answer = [];

    ind_to_reverse = [2,3,5,10];
    
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
       
    AQ10_mat_desc = {'Item', 'Response'};
    AQ10_mat = [item_no; answer]';
    AQ10_mat = sortrows(AQ10_mat,1);
    
    list1=[1,7,8,10];
    list2=[2:6,9];
    
    new_AQ10_mat = AQ10_mat(:,2);
    
    for i=1:size(list1,2)
        
        tmp_val=AQ10_mat(list1(i));
        
        if tmp_val == 1 || tmp_val == 2
            new_AQ10_mat(list1(i))=1;
        else
            new_AQ10_mat(list1(i))=0;
        end
    end
    
    for i=1:size(list2,2)
        
        tmp_val=AQ10_mat(list2(i));
        
        if tmp_val == 3 || tmp_val == 4
            new_AQ10_mat(list2(i))=1;
        else
            new_AQ10_mat(list2(i))=0;
        end
    end
    
    AQ10_score_desc = {'TotalScore'};
    AQ10_score = sum(new_AQ10_mat);
    

end

