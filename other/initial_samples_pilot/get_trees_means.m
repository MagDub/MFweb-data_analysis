function [trees_, means_] = get_trees_means(data_tree, data_size)

   trees_ = unique(data_tree);

    for tr = 1:size(trees_, 2)
       means_(tr) = mean(data_size(data_tree==trees_(tr)));
    end
        
end

