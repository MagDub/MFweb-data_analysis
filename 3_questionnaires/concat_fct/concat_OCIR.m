function [OCIR_mat_desc, OCIR_mat, OCIR_score_desc, OCIR_score] = concat_OCIR(quest)

n_items = 18; % number of items in the questionnaire
n_lett = 4; % number of letters of questionnaire name
first_letter = 'O';

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

OCIR_mat_desc = {'Item', 'Response'};
OCIR_mat = [item_no; answer]';
OCIR_mat = sortrows(OCIR_mat,1);

OCIR_total = sum(answer);
OCIR_washing=sum(OCIR_mat([5,11,17],2));
OCIR_checking=sum(OCIR_mat([2,8,14],2));
OCIR_ordering=sum(OCIR_mat([3,9,15],2));
OCIR_obsessions=sum(OCIR_mat([6,12,18],2));
OCIR_hoarding=sum(OCIR_mat([1,7,13],2));
OCIR_neutralising=sum(OCIR_mat([4,10,16],2));

OCIR_score_desc = {'TotalScore', 'Washing', 'Checking', 'Ordering', 'Obsessions', 'Hoarding', 'Neutralising'};
OCIR_score = [OCIR_total, OCIR_washing, OCIR_checking, OCIR_ordering, OCIR_obsessions, OCIR_hoarding, OCIR_neutralising];

end

