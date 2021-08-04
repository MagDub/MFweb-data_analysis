function [diff_and_prob_tree_short, diff_and_prob_tree_long, mean_and_prob_tree_short, mean_and_prob_tree_long] = plot_prob(tree_string, part_num, mat_BD_DB_short, mat_BD_DB_long, direc)

mat_s(:,1) = mat_BD_DB_short(:,1) - mat_BD_DB_short(:,2);
mat_s(:,2) = (mat_BD_DB_short(:,1) + mat_BD_DB_short(:,2))/2;
mat_s(:,3) = mat_BD_DB_short(:,3); %CHANGED
mat_l(:,1) = mat_BD_DB_long(:,1) - mat_BD_DB_long(:,2);
mat_l(:,2) = (mat_BD_DB_long(:,1) + mat_BD_DB_long(:,2))/2;
mat_l(:,3) = mat_BD_DB_long(:,3); %CHANGED

% if in function of difference: fctof = 1
% if in function of mean: fctof = 2
diff_and_prob_tree_short = make_probabilities(1, mat_s);
mean_and_prob_tree_short = make_probabilities(2, mat_s);
diff_and_prob_tree_long = make_probabilities(1, mat_l);
mean_and_prob_tree_long = make_probabilities(2, mat_l);
% column 1 : difference or mean
% column 2 to 5 : p of picking tree A,B,C,D
% column 6 : N (used for p)

% figure()
% 
% if strcmp(tree_string, 'BD')
%     tree_num_mat = [3,4,5];
% elseif strcmp(tree_string, 'AD')
%     tree_num_mat = [2,4,5];
% elseif strcmp(tree_string, 'AB')
%     tree_num_mat = [2,3,4];
% elseif strcmp(tree_string, 'ABD') || strcmp(tree_string, 'AB_ABD')
%     tree_num_mat = [2,3,5];
% end
% 
% % in terms of the difference
% for tree_num=1:3 % For Tree B, C, D
%     subplot(2,3,tree_num)
%     plot(diff_and_prob_tree_short(:,1), diff_and_prob_tree_short(:,tree_num_mat(tree_num)), 'b'); hold on;
%     plot(diff_and_prob_tree_long(:,1), diff_and_prob_tree_long(:,tree_num_mat(tree_num)), 'r');
%     for n = 1:size(diff_and_prob_tree_long,1)
%         t=text(diff_and_prob_tree_long(n,1), 1, int2str(diff_and_prob_tree_long(n,6)));
%         t.FontSize = 12;
%     end
%     ylim([0 1])
%     
%     if strcmp(tree_string, 'BD')
%         if tree_num_mat(tree_num) == 3
%             ylabel('P(tree B)')
%         elseif tree_num_mat(tree_num) == 4
%             ylabel('P(tree C)')
%         elseif tree_num_mat(tree_num) == 5
%             ylabel('P(tree D)')
%         end
%         
%         xlabel('Difference between tree B and D')
%         
%     elseif strcmp(tree_string, 'AD')
%         if tree_num_mat(tree_num) == 2
%             ylabel('P(tree A)')
%         elseif tree_num_mat(tree_num) == 4
%             ylabel('P(tree C)')
%         elseif tree_num_mat(tree_num) == 5
%             ylabel('P(tree D)')
%         end
%         
%         xlabel('Difference between tree mean(A) and D')
% 
%     elseif strcmp(tree_string, 'AB')
%         if tree_num_mat(tree_num) == 2
%             ylabel('P(tree A)')
%         elseif tree_num_mat(tree_num) == 3
%             ylabel('P(tree B)')
%         elseif tree_num_mat(tree_num) == 4
%             ylabel('P(tree C)')
%         end
%         
%         xlabel('Difference between tree mean(A) and B')
%         
%     elseif strcmp(tree_string, 'ABD')
%         if tree_num_mat(tree_num) == 2
%             ylabel('P(tree A)')
%         elseif tree_num_mat(tree_num) == 3
%             ylabel('P(tree B)')
%         elseif tree_num_mat(tree_num) == 5
%             ylabel('P(tree D)')
%         end
%         
%         xlabel('Difference between tree mean(A,B) and D')
%     
%     elseif strcmp(tree_string, 'AB_ABD')
%         if tree_num_mat(tree_num) == 2
%             ylabel('P(tree A)')
%         elseif tree_num_mat(tree_num) == 3
%             ylabel('P(tree B)')
%         elseif tree_num_mat(tree_num) == 5
%             ylabel('P(tree D)')
%         end
%         
%         xlabel('Difference between tree mean(A) and B')
%         
%     end
%     
%     
%     legend('short horizon', 'long horizon')
%     %set(gca,'XTick',1:20)
%     
% end
% 
% % in terms of the mean
% for tree_num=1:3 % for the trees
%     subplot(2,3,tree_num+3)
%     plot(mean_and_prob_tree_short(:,1), mean_and_prob_tree_short(:,tree_num_mat(tree_num)), 'b'); hold on;
%     plot(mean_and_prob_tree_long(:,1), mean_and_prob_tree_long(:,tree_num_mat(tree_num)), 'r');
%     for n = 1:size(mean_and_prob_tree_long,1)
%         t=text(mean_and_prob_tree_long(n,1), 1, int2str(mean_and_prob_tree_long(n,6)));
%         t.FontSize = 12;
%     end
%     ylim([0 1])
%     
%     if strcmp(tree_string, 'BD')
%         if tree_num_mat(tree_num) == 3
%             ylabel('P(tree B)')
%         elseif tree_num_mat(tree_num) == 4
%             ylabel('P(tree C)')
%         elseif tree_num_mat(tree_num) == 5
%             ylabel('P(tree D)')
%         end
%         
%         xlabel('Difference between tree B and D')
%         
%     elseif strcmp(tree_string, 'AD')
%         if tree_num_mat(tree_num) == 2
%             ylabel('P(tree A)')
%         elseif tree_num_mat(tree_num) == 4
%             ylabel('P(tree C)')
%         elseif tree_num == 5
%             ylabel('P(tree D)')
%         end
%         
%         xlabel('Mean of tree mean(A) and D')
% 
%     elseif strcmp(tree_string, 'AB')
%         if tree_num_mat(tree_num) == 2
%             ylabel('P(tree A)')
%         elseif tree_num_mat(tree_num) == 3
%             ylabel('P(tree B)')
%         elseif tree_num_mat(tree_num) == 4
%             ylabel('P(tree C)')
%         end
%         
%         xlabel('Mean of tree mean(A) and B')
%         
%     elseif strcmp(tree_string, 'ABD')
%         if tree_num_mat(tree_num) == 2
%             ylabel('P(tree A)')
%         elseif tree_num_mat(tree_num) == 3
%             ylabel('P(tree B)')
%         elseif tree_num_mat(tree_num) == 5
%             ylabel('P(tree D)')
%         end
%         
%         xlabel('Mean of tree mean(A,B) and D')
%     
%   elseif strcmp(tree_string, 'AB_ABD')
%         if tree_num_mat(tree_num) == 2
%             ylabel('P(tree A)')
%         elseif tree_num_mat(tree_num) == 3
%             ylabel('P(tree B)')
%         elseif tree_num_mat(tree_num) == 5
%             ylabel('P(tree D)')
%         end
%         
%         xlabel('Mean of tree mean(A) and B')  
%         
%         
%     end
%     
%     
%     legend('short horizon', 'long horizon')
%     
%     %set(gca,'XTick',mean_and_prob_tree_long(:,1)')
%     
% end
% 
% title(strcat('Participant', 32, part_num))
% 
% if strcmp(tree_string, 'BD')
%     savefig(strcat(direc, '/probBD.fig'))
% elseif strcmp(tree_string, 'AD')
%     savefig(strcat(direc, '/probAD.fig'))
% elseif strcmp(tree_string, 'AB')
%     savefig(strcat(direc, '/probAB.fig'))
% elseif strcmp(tree_string, 'ABD')
%     savefig(strcat(direc, '/probABD.fig'))
% elseif strcmp(tree_string, 'AB_ABD')
%     savefig(strcat(direc, '/probAB_ABD.fig'))
% end

end
