function [SDS_mat_desc, SDS_mat, SDS_score_desc, SDS_score] = concat_SDS(quest)

n_items = 20; % number of items in the questionnaire
n_lett = 3; % number of letters of questionnaire name
first_non_repeating_letter = 'D';

space1 = 5;

start = find(quest==first_non_repeating_letter)-1; % minus 1 because it starts at 'S'

question = {};
answer = [];

for n = 1:n_items
    if n < 10
       fin = start(n)+n_lett+1;
    else
       fin = start(n)+n_lett+2;
    end
    question{end+1} = quest(start(n):fin);
    fin = fin + space1;
    answer(end+1) = str2double(quest(fin));
end

SDS_mat_desc = {'Item', 'Response'};
SDS_mat = [1:n_items; answer]';
SDS_score_desc = {'TotalScore'};
SDS_score = sum(answer);


end

