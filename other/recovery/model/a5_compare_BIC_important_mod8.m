

data_fol = '../../../../data/';
sim_fol=strcat(data_fol, 'sim_model_recov/');
n_sim = 100;

model_string={'mod5', 'mod6', 'mod7', 'mod8', ... % 5:8
                'mod9', 'mod10', 'mod11', 'mod12', ... % 9:12
                    'mod5_t1', 'mod6_t1', 'mod7_t1', 'mod8_t1'}; % 13:16
                
model_mat = 5:16;                    
                    
n_models = size(model_string,2);

perc = nan(n_models,n_models);
mean_BIC = nan(n_models,n_models);
std_BIC = nan(n_models,n_models);


for mod_n=1:n_models
    
    mod_s = model_string{mod_n};
    
    file_BIC = strcat(sim_fol,mod_s,'_normal/n_sim_',num2str(n_sim),'/results/all_BIC_mat.mat');
    
    if exist(file_BIC)

        occur = nan(1,n_models);
        
        tmp = load(file_BIC);
        
        disp(mod_s)
        disp(tmp.all_BIC_mat)
        
        % keep only important models
        BIC_mat = tmp.all_BIC_mat(:,model_mat);
        
        % find best models (lowest BIC) for each sim
        [min_val, ind_min_val] = min(BIC_mat');
        min_val = min_val';
        ind_min_val = ind_min_val';
        
        % count occurences of each model
        uv = unique(ind_min_val);
        n  = histc(ind_min_val,uv);
        occur(:,[uv]) = n; 
        
        % compute percentage
        perc(mod_n,:) = occur/n_sim;
        
        
    end

end

perc(isnan(perc))=0;

save('../../../../data/data_for_figs/model_recov_perc.mat', 'perc');


% Figure

figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 15 15]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

legend_all{1}  = 'UCB';
legend_all{2}  = 'UCB + \epsilon';
legend_all{3}  = 'UCB + \eta';
legend_all{4}  = 'UCB + \epsilon + \eta';

legend_all{5}  = 'thompson';
legend_all{6}  = 'thompson + \epsilon';
legend_all{7}  = 'thompson + \eta';
legend_all{8}  = 'thompson + \epsilon + \eta';

legend_all{9}  = 'UCB_{\tau=1}';
legend_all{10}  = 'UCB_{\tau=1} + \epsilon';
legend_all{11}  = 'UCB_{\tau=1} + \eta';
legend_all{12}  = 'UCB_{\tau=1} + \epsilon + \eta';

% order_ = [9,5,13,...
%             10,6,14,...
%                 11,7,15,...
%                     12,8,16]-4;

%perc = perc(order_,order_);

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
% for i_=1:size(x,1)-1
%     x(i_,i_+1:size(x,1)) = nan;
% end
% 
% Lower diag
% for i_=1:size(x,1)-1
%     x(i_+1,1:i_) = nan;
% end

textStrings_=textStrings(:);

for i=1:size(textStrings_,1)
    a=textStrings_{i};
    if strcmp(a,'0.00')   
        textStrings_{i}='';
    elseif strcmp(a,'1.00')   
        textStrings_{i}='1.0';
    else
        tmp = textStrings_{i};
        textStrings_{i}=tmp(2:end);
    end
end
   
hStrings = text(x(:), y(:), textStrings_,'HorizontalAlignment', 'center');
midValue = mean(get(gca, 'CLim'));  % Get the middle value of the color range

t=title('BIC model recovery (N_{sim}=100)','FontSize', 18, 'FontName','Arial', 'Fontweight','normal');

ylabel('Simulated model','FontName','Arial','Fontweight','bold','FontSize',12);
xlabel('Recovered model','FontName','Arial','Fontweight','bold','FontSize',12);

% Export
addpath('../../../../export_fig')
export_fig(['./fig/Fig_model_recov_BIC.tif'],'-nocrop','-r200')


