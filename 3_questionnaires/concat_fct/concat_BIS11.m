function [BIS11_mat_desc, BIS11_mat, BIS11_score_desc, BIS11_score] = concat_BIS11(quest)

% Score: sum (52-71: normal; more: impulsive; less: over-controlled)

n_items = 30; % number of items in the questionnaire
n_lett = 5; % number of letters of questionnaire name

space1 = 5;

start = find(quest=='B');

question = {};
answer = [];

ind_to_reverse = [1,7,8,9,10,12,13,15,20,29,30];

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
                answer(end+1)=4;
            elseif val_tmp==2
                answer(end+1)=3;
            elseif val_tmp==3
                answer(end+1)=2;
            elseif val_tmp==4
                answer(end+1)=1;
            end
        
            else
                answer(end+1) = str2double(quest(fin));
            end
end

BIS11_mat_desc = {'Item', 'Response'};

BIS11_mat = [item_no; answer]';
BIS11_mat = sortrows(BIS11_mat,1);

BIS11_score_desc = {'TotalScore', 'Attentional', 'Motor', 'NonPlanning', 'Motor_Motor', 'Motor_Perseverance'};

BIS_attentional=sum(BIS11_mat([5,6,9,11,20,24,26,28],2));

BIS_motor=sum(BIS11_mat([2,3,4,16,17,19,21,22,23,25,30],2));

BIS_motor_motor=sum(BIS11_mat([2,3,4,17,19,22,25],2));

BIS_motor_perseverance=sum(BIS11_mat([16,21,23,30],2));

BIS_nonplanning=sum(BIS11_mat([1,7,8,10,12,13,14,15,18,27,29],2));

BIS11_score = [sum(answer), BIS_attentional, BIS_motor, BIS_nonplanning, BIS_motor_motor, BIS_motor_perseverance];

end

