
load('../usermat_completed.mat')

n = length(usermat_completed);

data_fol = '/Users/magdadubois/MFweb/data/questionnaire/';

% todo: LSAS

for i=1:n
        
    userID = usermat_completed(i);
        
    disp(['userID:', 32, num2str(userID)])
    
    load(strcat(data_fol, 'user_', num2str(userID), '/AQ10_mat.mat'));
    load(strcat(data_fol, 'user_', num2str(userID), '/BIS11_mat.mat'));
    load(strcat(data_fol, 'user_', num2str(userID), '/ASRS_mat.mat'));
    load(strcat(data_fol, 'user_', num2str(userID), '/CFS_mat.mat'));
    load(strcat(data_fol, 'user_', num2str(userID), '/OCIR_mat.mat'));
    load(strcat(data_fol, 'user_', num2str(userID), '/SDS_mat.mat'));
    load(strcat(data_fol, 'user_', num2str(userID), '/STAI_mat.mat'));
    load(strcat(data_fol, 'user_', num2str(userID), '/IUS_mat.mat'));
    load(strcat(data_fol, 'user_', num2str(userID), '/LSAS_mat.mat'));
    
    AQ10_items(i,:) = AQ10_mat(:,2)';
    BIS_items(i,:)  = BIS11_mat(:,2)';
    ASRS_items(i,:) = ASRS_mat(:,2)';
    CFS_items(i,:) = CFS_mat(:,2)';
    OCIR_items(i,:) = OCIR_mat(:,2)';
    SDS_items(i,:) = SDS_mat(:,2)';
    STAI_items(i,:) = STAI_mat(:,2)';
    IUS_items(i,:) = IUS_mat(:,2)';
    LSAS_fear_items(i,:) = LSAS_mat(:,2)';
    LSAS_avoidance_items(i,:) = LSAS_mat(:,3)';
    
end
                    
BIS_items_desc={};
AQ10_items_desc={};
ASRS_items_desc={};
CFS_items_desc={};
OCIR_items_desc={};
STAI_items_desc={};
IUS_items_desc={};
SDS_items_desc={};
LSAS_items_desc={};

for i=1:size(BIS_items,2)
    BIS_items_desc{end+1} = strcat('BIS_item_',num2str(i));
end

for i=1:size(AQ10_items,2)
    AQ10_items_desc{end+1} = strcat('AQ10_item_',num2str(i));
end

for i=1:size(ASRS_items,2)
    ASRS_items_desc{end+1} = strcat('ASRS_item_',num2str(i));
end

for i=1:size(CFS_items,2)
    CFS_items_desc{end+1} = strcat('CFS_item_',num2str(i));
end

for i=1:size(OCIR_items,2)
    OCIR_items_desc{end+1} = strcat('OCIR_item_',num2str(i));
end

for i=1:size(SDS_items,2)
    SDS_items_desc{end+1} = strcat('SDS_item_',num2str(i));
end

for i=1:size(STAI_items,2)
    STAI_items_desc{end+1} = strcat('STAI_item_',num2str(i));
end

for i=1:size(IUS_items,2)
    IUS_items_desc{end+1} = strcat('IUS_item_',num2str(i));
end

for i=1:size(LSAS_fear_items,2)
    LSAS_items_desc{end+1} = strcat('LSAS_item_',num2str(i));
end

% Concatenate everything

all_items_desc = [BIS_items_desc, ASRS_items_desc, AQ10_items_desc, CFS_items_desc, OCIR_items_desc, SDS_items_desc, ... 
                    STAI_items_desc, IUS_items_desc, LSAS_items_desc];

all_items = [BIS_items, ASRS_items, AQ10_items, CFS_items, OCIR_items, SDS_items, ...
                STAI_items, IUS_items, (LSAS_fear_items+LSAS_avoidance_items)/2];

% save
save(strcat(data_fol, 'all/all_items.mat'), 'all_items')
save(strcat(data_fol, 'all/all_items_desc.mat'), 'all_items_desc')


