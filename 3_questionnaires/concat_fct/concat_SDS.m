function [SDS_mat_desc, SDS_mat, SDS_score_desc, SDS_score] = concat_SDS(quest)

n_items = 20; % number of items in the questionnaire
n_lett = 3; % number of letters of questionnaire name
first_non_repeating_letter = 'D';

space1 = 5;

start = find(quest==first_non_repeating_letter)-1; % minus 1 because it starts at 'S'

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

SDS_mat_desc = {'Item', 'Response'};
SDS_mat = [item_no; answer]';
SDS_mat = sortrows(SDS_mat,1);

% reverse scoring
items_to_reverse = [2, 5, 6, 11, 12, 14, 16, 17, 18, 20];

for i = 1:size(items_to_reverse,2)
    tmp = SDS_mat(items_to_reverse(i),2);
    SDS_mat(items_to_reverse(i),2) = 5 - tmp;
end

SDS_score_desc = {'TotalScore'};
SDS_score = sum(SDS_mat(:,2));


end

