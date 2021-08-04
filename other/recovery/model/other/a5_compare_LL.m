

data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');
n_sim = 100;
n_models = 12;

perc = nan(n_models,n_models);
mean_LL = nan(n_models,n_models);
std_LL = nan(n_models,n_models);


for mod=1:n_models

    file_LL = strcat(sim_fol,'mod',num2str(mod),'_normal/n_sim_',num2str(n_sim),'/results/all_LL_mat.mat');
    
    if exist(file_LL)

        occur = nan(1,n_models);
       
        tmp = load(file_LL);
        
        % find best models (lowest LL) for each sim
        [max_val, ind_max_val] = max(tmp.all_LL_mat');
        max_val = max_val';
        ind_max_val = ind_max_val';
        
        % count occurences of each model
        uv = unique(ind_max_val);
        n  = histc(ind_max_val,uv);
        occur(:,[uv]) = n; 
        
        % compute percentage
        perc(mod,:) = occur/n_sim;
       
        mean_LL(mod,:) = mean(tmp.all_LL_mat,1);
        
        [~, ind_min_val_mean] = nanmin(mean_LL');
        ind_min_val_mean = ind_min_val_mean';
        
    end

end


% Figure

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 15 15]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

legend_all{1}  = 'hybrid';
legend_all{2} = 'hybrid + \epsilon';
legend_all{3} = 'hybrid + \eta';
legend_all{4} = 'hybrid + \epsilon + \eta';

legend_all{5}  = 'UCB';
legend_all{6}  = 'UCB + \epsilon';
legend_all{7}  = 'UCB + \eta';
legend_all{8}  = 'UCB + \epsilon + \eta';

legend_all{9}  = 'thompson';
legend_all{10}  = 'thompson + \epsilon';
legend_all{11}  = 'thompson + \eta';
legend_all{12}  = 'thompson + \epsilon + \eta';

imagesc(perc);

n_mod = size(legend_all,2);

yticks([1:n_mod])
yticklabels({legend_all{1}, legend_all{2}, legend_all{3}, legend_all{4}, legend_all{5}, legend_all{6}, legend_all{7}, legend_all{8}, legend_all{9}, legend_all{10}, legend_all{11}, legend_all{12}})
ylim([0.5 n_mod+0.5])

xticks([1:n_mod])
xticklabels({legend_all{1}, legend_all{2}, legend_all{3}, legend_all{4}, legend_all{5}, legend_all{6}, legend_all{7}, legend_all{8}, legend_all{9}, legend_all{10}, legend_all{11}, legend_all{12}})
xtickangle(45)
xlim([0.5 n_mod+0.5])

a = get(gca,'XTickLabel');
set(gca,'XTickLabel',a,'fontsize',10, 'YDir', 'reverse')

inter = 100;

firstcol =[0.87058824300766 0.921568632125854 0.980392158031464];
secondcol = [0.39215686917305 0.474509805440903 0.635294139385223];

linspace_b_y_1 = [linspace(firstcol(1),secondcol(1),inter)]; 
linspace_b_y_2 = [linspace(firstcol(2),secondcol(2),inter)]; 
linspace_b_y_3 = [linspace(firstcol(3),secondcol(3),inter)]; 

mycolors = ([[linspace_b_y_1]', [linspace_b_y_2]', [linspace_b_y_3]']);

colormap(mycolors);

h = colorbar('Ticks',0:0.2:1); 
caxis([0 1])

title(h,'r','Interpreter','tex')

textStrings = num2str(perc(:), '%0.2f');       % Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  % Remove any space padding
[x, y] = meshgrid(1:n_mod);  % Create x and y coordinates for the strings

% Upper diag
for i_=1:size(x,1)-1
    x(i_,i_+1:size(x,1)) = nan;
end

% Lower diag
for i_=1:size(x,1)-1
    x(i_+1,1:i_) = nan;
end

hStrings = text(x(:), y(:), textStrings(:),'HorizontalAlignment', 'center');
midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range

t=title('LL model recovery (N_{sim}=100)','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

ylabel('Simulated model','FontName','Arial','Fontweight','bold','FontSize',12);
xlabel('Recovered model','FontName','Arial','Fontweight','bold','FontSize',12);

% Export
addpath('../../../../export_fig')
export_fig(['./fig/Fig_model_recov_LL.tif'],'-nocrop','-r200')
