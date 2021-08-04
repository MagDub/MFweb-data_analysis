function [] = plot_RT(direc, tree_string, part_num, mat_long, new_mat_long, mat_short, new_mat_short)

    % new mat short
    % 1: difference between B and D
    % 2: mean RT
    % 3: std RT
    % 4: occurences
% if ~strcmp(tree_string, 'AB_ABD')
%     
%     fig = figure(); 
%     max_value=max(max(mat_short(:,4)), max(mat_long(:,4)));
%     
%     % Only long horizon
%     subplot(2,2,1)
%     plot_mat_long = plot(new_mat_long(:,1), new_mat_long(:,2));
%     hold on;
%     plot(mat_long(:,1), mat_long(:,4), 'b*');
%     hold on;
%     shadedErrorBar(new_mat_long(:,1),new_mat_long(:,2),new_mat_long(:,3),'lineprops','b');
%     
%     if strcmp(tree_string, 'BD')
%         xlabel('Size difference between apple B and D')
%     elseif strcmp(tree_string, 'AD')
%         xlabel('Size difference between apple mean(A) and D')
%     elseif strcmp(tree_string, 'AB')
%         xlabel('Size difference between apple mean(A) and B')
%     elseif strcmp(tree_string, 'ABD')
%         xlabel('Size difference between apple mean(A,B) and D')
%     end
%     
%     ylabel('RT')
%     title('Long Horizon')
%     %set(gca,'XTick',1:20)
%     ylim([0 max_value])
%     for n = 1:size(new_mat_long,1)
%         t=text(new_mat_long(n,1),new_mat_long(n,2)+400,int2str(new_mat_long(n,4)));
%         t.FontSize = 12;
%     end
% 
%     % Only short horizon
%     subplot(2,2,2)
%     plot(new_mat_short(:,1), new_mat_short(:,2), 'r'); hold on;
%     plot(mat_short(:,1), mat_short(:,4), 'r*'); hold on;
% %     shadedErrorBar(new_mat_short(:,1),new_mat_short(:,2),new_mat_short(:,3),'lineprops','r');
%     if strcmp(tree_string, 'BD')
%         xlabel('Size difference between apple B and D')
%     elseif strcmp(tree_string, 'AD')
%         xlabel('Size difference between apple mean(A) and D')
%     elseif strcmp(tree_string, 'AB')
%         xlabel('Size difference between apple mean(A) and B')
%     elseif strcmp(tree_string, 'ABD')
%         xlabel('Size difference between apple mean(A,B) and D')
%     end
%     ylabel('RT')
%     title('Short Horizon')
%     %set(gca,'XTick',1:20)
%     ylim([0 max_value])
%     for n = 1:size(new_mat_short,1)
%         t=text(new_mat_short(n,1),new_mat_short(n,2)+400,int2str(new_mat_short(n,4)));
%         t.FontSize = 12;
%     end
% 
%     subplot(2,2,[3 4])
%     plot_short = plot(new_mat_short(:,1), new_mat_short(:,2), 'r'); hold on;
%     shadedErrorBar(new_mat_short(:,1), new_mat_short(:,2), new_mat_short(:,3),'lineprops','r');
%     plot_long = plot(new_mat_long(:,1), new_mat_long(:,2), 'b');
%     shadedErrorBar(new_mat_long(:,1), new_mat_long(:,2), new_mat_long(:,3),'lineprops','b');
%     legend([plot_short plot_long],{'Short horizon','Long horizon'},'Location','best')
%     %set(gca,'XTick',1:20)
%     if strcmp(tree_string, 'BD')
%         xlabel('Size difference between apple B and D')
%     elseif strcmp(tree_string, 'AD')
%         xlabel('Size difference between apple mean(A) and D')
%     elseif strcmp(tree_string, 'AB')
%         xlabel('Size difference between apple mean(A) and B')
%     elseif strcmp(tree_string, 'ABD')
%         xlabel('Size difference between apple mean(A,B) and D')
%     end
%     ylabel('RT')
%     title(strcat('Participant', 32, part_num))
%     
%     if strcmp(tree_string, 'BD')
%         savefig(strcat(direc, '/RT_BD.fig'))
%     elseif strcmp(tree_string, 'AD')
%         savefig(strcat(direc, '/RT_AD.fig'))
%     elseif strcmp(tree_string, 'AB')
%         savefig(strcat(direc, '/RT_AB.fig'))
%     elseif strcmp(tree_string, 'ABD')
%         savefig(strcat(direc, '/RT_ABD.fig'))
%     end
%     
% end

end
