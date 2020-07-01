function [ASRS_mat_desc, ASRS_mat, ASRS_score_desc, ASRS_score] = compute_ASRS_score(ASRS_mat)

% ASRS_mat = [item_no answer(1:5)]


ASRS_n_shaded = [];
for i=1:size(ASRS_mat,1)
    if (((i<=3 || i==9 || i==12 || i==16 || i==18) ...
            && ASRS_mat(i,2)>=3) ||...
        ((i==4 || i==5 || i==6 || i==7|| i==8|| i==10|| i==11|| i==13|| i==14|| i==15|| i==17)...
            && ASRS_mat(i,2)>=4))
        ASRS_n_shaded(i) = 1;
    else 
        ASRS_n_shaded(i) = 0;
    end
end

id_inattention = [7,8,9,1,2,4,10,11,3];
id_hyper_impu = [5,12,13,14,6,15,16,17,18];

for i=1:size(ASRS_mat,1)
    tmp_i= sort(id_inattention);
    tmp_h= sort(id_hyper_impu);
    ASRS_mat_inat(i)=(~isempty(find(tmp_i==ASRS_mat(i,1))));
    ASRS_mat_hyper(i)=(~isempty(find(tmp_h==ASRS_mat(i,1))));
end

ASRS_mat_A = [ones(1,6), zeros(1,size(ASRS_mat,1)-6)]'; % 1:6
ASRS_mat_B = [zeros(1,6), ones(1,size(ASRS_mat,1)-6)]'; % 7:18

ASRS_mat_desc = {'Item', 'Response', 'ResponseInShaded', 'InattentionItem', 'HyperactivityImpulsivityItem', 'PartA', 'PartB'};
ASRS_mat = [ASRS_mat ASRS_n_shaded' ASRS_mat_inat' ASRS_mat_hyper' ASRS_mat_A ASRS_mat_B];

ASRS_score_desc = {'Sum', 'ShadedNb',...
                    'SumA', 'ShadedNbA', 'PassThreshold'... %Threshold for diagnosis is 4 or more shaded boxes in part A
                    'SumInattention', 'SumHyperImpuls',...
                    'ShadedNbInattention', 'ShadedNbHyperImpuls'};
                
ASRS_score = [sum(ASRS_mat(:,2)) sum(ASRS_mat(:,3))...
                    sum(ASRS_mat([1:6],2))  sum(ASRS_mat([1:6],3)) (sum(ASRS_mat([1:6],3))>=4)...
                    sum(ASRS_mat(id_inattention,2)) sum(ASRS_mat(id_hyper_impu,2))...
                    sum(ASRS_mat(id_inattention,3)) sum(ASRS_mat(id_hyper_impu,3))];


end

