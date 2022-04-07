
% T = readtable('../../10_stats/web_data_completed.xlsx');
% data = T(T.exclude==false,:);
% writetable(data,'data.txt'); 

%data_tmp = readtable('data.txt'); 

variables = {'age' 'gender', 'IQscore', 'BIS11_TotalScore', 'AQ10_TotalScore', 'ASRS_Sum', 'CFS_TotalScore', ...
                'OCIR_TotalScore', 'STAI_TotalScore', 'IUS_TotalScore', 'SDS_TotalScore', 'LSAS_TotalScore'};
            
data = data_tmp(:,variables);

% variable names
var_tmp={};
var_tmp{1,1} = strcat('age');
var_tmp{2,1} = strcat('gender');
var_tmp{3,1} = strcat('ICAR sample test (IQ)');
var_tmp{4,1} = strcat('BIC (impulsivity)');
var_tmp{5,1} = strcat('ASRS (ADHD)');
var_tmp{6,1} = strcat('AQ10 (autism)');
var_tmp{7,1} = strcat('CFS (cognitive flexibility)');
var_tmp{8,1} = strcat('OCIR (OCD)');
var_tmp{9,1} = strcat('STAI (trait anxiety)');
var_tmp{10,1} = strcat('IUS (uncertainty intolerance)');
var_tmp{11,1} = strcat('SDS (depression)');
var_tmp{12,1} = strcat('LSAS (social anxiety)');

% mean (std)
demo_tmp={};
demo_tmp{1,1} = strcat(num2str(nanmean(data.age),3),'(', num2str(nanstd(data.age),3), ')');
demo_tmp{2,1} = strcat(num2str(size(data.gender(data.gender==1),1)),32,'female');
                                 %',', 32, num2str(size(data.gender(data.gender==0),1)),32,'is0,',...
                                      %32, num2str(size(data.gender(data.gender==-1),1)),32,'is-1');
demo_tmp{3,1} = strcat(num2str(nanmean(data.IQscore*10),3),'%(', num2str(nanstd(data.IQscore*10),3), '%)');
demo_tmp{4,1} = strcat(num2str(nanmean(data.BIS11_TotalScore),3),'(', num2str(nanstd(data.BIS11_TotalScore),3), ')');
demo_tmp{5,1} = strcat(num2str(nanmean(data.ASRS_Sum),3),'(', num2str(nanstd(data.ASRS_Sum),3), ')');
demo_tmp{6,1} = strcat(num2str(nanmean(data.AQ10_TotalScore),3),'(', num2str(nanstd(data.AQ10_TotalScore),3), ')');
demo_tmp{7,1} = strcat(num2str(nanmean(data.CFS_TotalScore),3),'(', num2str(nanstd(data.CFS_TotalScore),3), ')');
demo_tmp{8,1} = strcat(num2str(nanmean(data.OCIR_TotalScore),3),'(', num2str(nanstd(data.OCIR_TotalScore),3), ')');
demo_tmp{9,1} = strcat(num2str(nanmean(data.STAI_TotalScore),3),'(', num2str(nanstd(data.STAI_TotalScore),3), ')');
demo_tmp{10,1} = strcat(num2str(nanmean(data.IUS_TotalScore),3),'(', num2str(nanstd(data.IUS_TotalScore),3), ')');
demo_tmp{11,1} = strcat(num2str(nanmean(data.SDS_TotalScore),3),'(', num2str(nanstd(data.SDS_TotalScore),3), ')');
demo_tmp{12,1} = strcat(num2str(nanmean(data.LSAS_TotalScore),3),'(', num2str(nanstd(data.LSAS_TotalScore),3), ')');

% range
range_tmp={};
range_tmp{1,1} = strcat('[',num2str(min(data.age),3),',',num2str(max(data.age),3),']');
range_tmp{2,1} = strcat('-');

range_tmp{3,1} = strcat('[',num2str(min(data.IQscore*10),3),',',... 
                            num2str(max(data.IQscore*10),3),']');
                        
range_tmp{4,1} = strcat('[',num2str(min(data.BIS11_TotalScore),3),',',...
                            num2str(max(data.BIS11_TotalScore),3),']');
                        
range_tmp{5,1} = strcat('[',num2str(min(data.ASRS_Sum),3),',',...
                            num2str(max(data.ASRS_Sum),3), ']');
                        
range_tmp{6,1} = strcat('[',num2str(min(data.AQ10_TotalScore),3),',',...
                            num2str(max(data.AQ10_TotalScore),3), ']');
                        
range_tmp{7,1} = strcat('[',num2str(min(data.CFS_TotalScore),3),',',...
                            num2str(max(data.CFS_TotalScore),3), ']');
                        
range_tmp{8,1} = strcat('[',num2str(min(data.OCIR_TotalScore),3),',',...
                            num2str(max(data.OCIR_TotalScore),3), ']');
                        
range_tmp{9,1} = strcat('[',num2str(min(data.STAI_TotalScore),3),',',...
                            num2str(max(data.STAI_TotalScore),3), ']');
                        
range_tmp{10,1} = strcat('[',num2str(min(data.IUS_TotalScore),3),',',...
                             num2str(max(data.IUS_TotalScore),3), ']');
                         
range_tmp{11,1} = strcat('[',num2str(min(data.SDS_TotalScore),3),',',...
                             num2str(max(data.SDS_TotalScore),3), ']');
                         
range_tmp{12,1} = strcat('[',num2str(min(data.LSAS_TotalScore),3),',',...
                             num2str(max(data.LSAS_TotalScore),3), ']');


demo_table = table;
demo_table.variable = var_tmp;
demo_table.mean = demo_tmp;
demo_table.range = range_tmp;

disp(demo_table)