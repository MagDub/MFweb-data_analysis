
load('./frequencies/pickedC_SH.mat')
load('./frequencies/pickedC_LH.mat')

load('./frequencies/pickedD_SH.mat')
load('./frequencies/pickedD_LH.mat')

load('./frequencies/pickedmedium_SH.mat')
load('./frequencies/pickedmedium_LH.mat')

load('./frequencies/pickedhigh_SH.mat')
load('./frequencies/pickedhigh_LH.mat')

sum_SH = pickedC_SH + pickedD_SH + pickedmedium_SH + pickedhigh_SH; % should be 100 %
sum_LH = pickedC_LH + pickedD_LH + pickedmedium_LH + pickedhigh_LH; % should be 100 %

disp([sum_SH, sum_LH])

