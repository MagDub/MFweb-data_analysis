function [IUS_mat_desc, IUS_mat, IUS_score_desc, IUS_score] = concat_IUS(quest)

% Scoring: 
% 1. unifactorial: sum 
% 2. bifactorial: 
%     factor 1 (Uncertainty has negative behavioural and self-referent implications) 
%     factor 2 (Uncertainty is unfair and spoils everything)

n_items = 27; % number of items in the questionnaire
n_lett = 3; % number of letters of questionnaire name
first_letter = 'I';

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

IUS_mat_desc = {'Item', 'Response'};
IUS_mat = [item_no; answer]';
IUS_mat = sortrows(IUS_mat,1);

factor1 = IUS_mat([1:3 9 12:17 20 22 23 24 25],2);
factor2 = IUS_mat([4:8 10 11 18 19 21 26 27],2);

IUS_score_desc = {'TotalScore', 'FactorNegative', 'FactorUnfair'};
IUS_score = [sum(answer),sum(factor1), sum(factor2)];

if sum(answer)~=(sum(factor1)+sum(factor2))
    disp('IUS: factor mismatch')
end


end

