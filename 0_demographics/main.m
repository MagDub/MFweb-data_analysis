
tmp = dir('prolific_export_*.csv');
filename = tmp.name;
T=readtable(tmp.name);

for i=1:size(T.Sex,1)
    if strcmp(T.Sex(i),'Female')
        gender(i) = 1;
    elseif strcmp(T.Sex(i),'Male')
        gender(i) = 0;
    else
        gender(i) = -1;
    end
end

age = str2num(cell2mat(T.age));

for i=1:size(T.num_rejections,1)
    rej(i) = str2num(cell2mat(T.num_rejections(i)));
    app(i) = str2num(cell2mat(T.num_approvals(i)));
    rejection_percetage(i) = rej(i) ./ (app(i) + rej(i))*100;
end

p_ID = T.participant_id;

demo_desc = {'Age', 'Gender', 'RejectionPercentage'};
demo = [age, gender', rejection_percetage'];

save('../../data/questionnaire/demographics/raw/p_ID.mat','p_ID')
save('../../data/questionnaire/demographics/raw/demo_desc.mat','demo_desc')
save('../../data/questionnaire/demographics/raw/demo.mat','demo')
