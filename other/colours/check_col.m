figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 30 10]);
set(gca,'FontName','Arial','FontSize',10)
hold on;

data_fold = ('../../../data/');

load('../../usermat_completed.mat')

id_Block = 1;
id_Blocktrial = 2;
id_Horizon = 3;
id_Item = 4;
id_Sample = 5;
id_UnusedTree = 13;
id_TreeColGroup = 14;
id_TreeLeft = 15;
id_TreeMiddle = 16;
id_TreeRight = 17;
    
data_desc = {'Block', 'BlockTrial', 'Horizon', 'Item', 'UnusedTree', 'TreeColGroup', 'TreeLeft', 'TreeMiddle', 'TreeRight'};

for ID_i=1:size(usermat_completed,2)
    
    ID = usermat_completed(ID_i);
    
    load(strcat(data_fold, 'concat_data/user_',num2str(ID),'.mat'));
    
    tmp = user.log(user.log(:,id_Sample)==1,:); % keep only 1st sample of each trial
    
    data_col = tmp(:, [15:17]);
    
    pos_ABCD=nan(size(data_col,1), 4);
    for trial = 1:size(data_col,1)
        for i=1:4
            if i~=tmp(trial,13)
                pos_ABCD(trial, i) = find(data_col(trial,:)==i);
            end
        end
    end
    
    col_combination = [tmp(:, [1:3]) tmp(:, 14)*10+pos_ABCD(:,1) tmp(:, 14)*10+pos_ABCD(:,2) tmp(:, 14)*10+pos_ABCD(:,3) tmp(:, 14)*10+pos_ABCD(:,4)];
    
    colA = col_combination(:,4); colA(isnan(colA))=[];
    colB = col_combination(:,5); colB(isnan(colB))=[];
    colC = col_combination(:,6); colC(isnan(colC))=[];
    colD = col_combination(:,7); colD(isnan(colD))=[];
    
    cols = [11:13, 21:23, 31:33, 41:43, 51:53, 61:63, 71:73, 81:83];
    
    [occurA,~]=hist(colA,cols);
    [occurB,~]=hist(colB,cols);
    [occurC,~]=hist(colC,cols);
    [occurD,~]=hist(colD,cols);
        
    %[colA, colB, colC, colD]
    occurABCD(:, :, ID_i) = [cols', occurA', occurB', occurC', occurD'];
    
    occurcol24(ID_i, :) = [occurA, occurB, occurC, occurD];
    
end

occurcol24_desc = {...
    'col1_A', 'col2_A', 'col3_A', 'col4_A', 'col5_A', 'col6_A', 'col7_A', 'col8_A', 'col9_A', 'col10_A', 'col11_A', 'col12_A', ...
    'col13_A', 'col14_A', 'col15_A', 'col16_A', 'col17_A', 'col18_A', 'col19_A', 'col20_A', 'col21_A', 'col22_A', 'col23_A', 'col24_A', ...
    'col1_B', 'col2_B', 'col3_B', 'col4_B', 'col5_B', 'col6_B', 'col7_B', 'col8_B', 'col9_B', 'col10_B', 'col11_B', 'col12_B', ...
    'col13_B', 'col14_B', 'col15_B', 'col16_B', 'col17_B', 'col18_B', 'col19_B', 'col20_B', 'col21_B', 'col22_B', 'col23_B', 'col24_B', ...
    'col1_C', 'col2_C', 'col3_C', 'col4_C', 'col5_C', 'col6_C', 'col7_C', 'col8_C', 'col9_C', 'col10_C', 'col11_C', 'col12_C', ...
    'col13_C', 'col14_C', 'col15_C', 'col16_C', 'col17_C', 'col18_C', 'col19_C', 'col20_C', 'col21_C', 'col22_C', 'col23_C', 'col24_C', ...
    'col1_D', 'col2_D', 'col3_D', 'col4_D', 'col5_D', 'col6_D', 'col7_D', 'col8_D', 'col9_D', 'col10_D', 'col11_D', 'col12_D', ...
    'col13_D', 'col14_D', 'col15_D', 'col16_D', 'col17_D', 'col18_D', 'col19_D', 'col20_D', 'col21_D', 'col22_D', 'col23_D', 'col24_D'};

occurABCD_mean = mean(occurABCD,3);
occurABCD_std = std(occurABCD,[],3);
 
width_=0.18;

bar([1:24], occurABCD_mean(:,2), 'b', 'BarWidth', width_);  hold on;
bar([1:24]+width_, occurABCD_mean(:,3), 'r', 'BarWidth', width_);  hold on;
bar([1:24]+2*width_, occurABCD_mean(:,4), 'g', 'BarWidth', width_);  hold on;
bar([1:24]+3*width_, occurABCD_mean(:,5), 'y', 'BarWidth', width_); 
xlim([0.5,24+3*width_+0.5])

col_data = [[1:24]', occurABCD_mean(:,[2:end])];