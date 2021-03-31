function [CFS_mat_desc, CFS_mat, CFS_score_desc, CFS_score] = concat_CFS(quest)

    n_items = 12; % number of items in the questionnaire
    n_lett = 2; % number of letters of questionnaire name
    second_letter = 'F';

    space1 = 5;

    start = find(quest==second_letter);

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
        
        if sum(item_no(n) == ind_to_reverse)>0 % needs to be reversed
            
            val_tmp=str2double(quest(fin));
            
            if val_tmp==1
                answer(end+1)=6;
            elseif val_tmp==2
                answer(end+1)=5;
            elseif val_tmp==3
                answer(end+1)=4;
            elseif val_tmp==4
                answer(end+1)=3;
            elseif val_tmp==5
                answer(end+1)=2;
            elseif val_tmp==6
                answer(end+1)=1;
            end
        
        else
            answer(end+1) = str2double(quest(fin));
        end 
        
    end
       
    
    CFS_mat_desc = {'Item', 'Response'};
    CFS_mat = [item_no; answer]';
    CFS_mat = sortrows(CFS_mat,1);
    
    CFS_score_desc = {'TotalScore'};
    CFS_score = sum(answer);
    

end

