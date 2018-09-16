function [ item_name ] = Read_files_in_folder( path )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% This is a fuction that reads the files under a folder path

pt=dir(path);

item_name = {}; 

M=length(pt);

k = 0;
format short

for i = 1 : M
    if strcmp(pt (i).name, '.') | strcmp(pt (i).name, '..')%|pt (i).isdir==0
        continue;
    else
            k = k + 1;
            item_name{k} = pt (i).name;
    end
    
end

end

