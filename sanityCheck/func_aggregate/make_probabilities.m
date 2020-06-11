function [fctof_and_prob_tree] = make_probabilities(fctof, mat)

mat=sortrows(mat,fctof);
mat = round(mat);
uc1 = unique(mat(:,fctof));

tmp_mat = [];
uc1_ind = 1;
categ = uc1(uc1_ind);
for i=1:size(mat,1)
    if categ ~= mat(i,fctof)
        occurence(uc1_ind) = size(tmp_mat,1);
        counts(uc1_ind,:) = nan(1,4); %always 4 trees
        tree_count = accumarray(tmp_mat(:,3), 1)';
        for j=1:size(tree_count,2)
            counts(uc1_ind,j) = tree_count(j);
        end
        tmp_mat = [];
        uc1_ind = uc1_ind + 1;
        categ = uc1(uc1_ind);
    end
    
    tmp_mat(end+1,:) = mat(i,:); 
    
    if i==size(mat,1)
        occurence(uc1_ind) = size(tmp_mat,1);
        counts(uc1_ind,:) = nan(1,4); %always 4 trees
        tree_count = accumarray(tmp_mat(:,3), 1)';
        for j=1:size(tree_count,2)
            counts(uc1_ind,j) = tree_count(j);
        end
        tmp_mat = [];
    end
end

% 1st column: difference (mat(:,1))
% 2nd, 3rd, 4th, 5th : tree A, B, C, D
fctof_and_tree = [uc1 counts];
fctof_and_tree(isnan(fctof_and_tree)) = 0;

fctof_and_prob_tree = fctof_and_tree;
for col=2:5
    fctof_and_prob_tree(:,col) = fctof_and_tree(:,col) ./ sum(fctof_and_tree(:,2:5),2);
end

fctof_and_prob_tree(:,end+1) = occurence';

end
