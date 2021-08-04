function [tab_ids] = changeDirNames(dirName)

dirResult = dir(strcat(dirName,'prolific_id_5*'));

allSubDirs = dirResult([dirResult.isdir]);

for i = 1:length(allSubDirs)
    
    thisDir = allSubDirs(i);
    thisDirName = thisDir.name;
    
    oldname = fullfile(dirName,thisDir.name);
    newname = [dirName 'user_' int2str(i)];
    
    tab_ids{i,1} = thisDir.name;
    tab_ids{i,2} = int2str(i);
    
    movefile(oldname,newname);
    
    changeDirNames(newname);
end

end