%% Import the data
[~, ~, raw] = xlsread('/Users/magdadubois/MF/load_db/id1.xls','id1');
raw = raw(end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};
cellVectors = raw(:,[4,5,6,7,8,9,10,11,12,13,14,15,16,17,18]);
raw = raw(:,[1,2,3]);

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Allocate imported array to column variable names
id = data(:,1);
UserNo = data(:,2);
BlockNo = data(:,3);
BlockStartTime = cellVectors(:,1);
BlockFinishTime = cellVectors(:,2);
TreeColours = str2mat(cellVectors(:,3));
ChosenTree = cellVectors(:,4);
ChosenAppleSize = cellVectors(:,5);
AllKeyPressed = cellVectors(:,6);
ReactionTimes = cellVectors(:,7);
Horizon = cellVectors(:,8);
ItemNo = cellVectors(:,9);
TrialNo = cellVectors(:,10);
UnusedTree = cellVectors(:,11);
InitialSamplesNb = cellVectors(:,12);
InitialSamplesTree = cellVectors(:,13);
InitialSamplesSize = cellVectors(:,14);
TreePositions = cellVectors(:,15);

%% Clear temporary variables
clearvars data raw cellVectors;

%%
a = str2mat(ChosenTree);
ChosenTreeMat = nan(2,6);
ChosenTreeMat(1,:) = [str2double(a(3)), str2double(a(6)), str2double(a(9)), str2double(a(12)) , str2double(a(15)) , str2double(a(18))];
ChosenTreeMat(2,:) = [str2double(a(23)), str2double(a(26)), str2double(a(29)), str2double(a(32)) , str2double(a(35)) , str2double(a(38))];

disp(ChosenTree)
disp(ChosenTreeMat)

%% TODO faire une fonction du truc above et le faire pour tous les autres string
%% pour le trucs genre itemNo, le mettre dans l'autre sense
%% voir aussi comment on veut data pour les scripts. Peut etre que comme ca pas ideal 