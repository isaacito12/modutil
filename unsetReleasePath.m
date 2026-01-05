function NumFolders = unsetReleasePath(TopFolder)
% Remove the path to the folders under the Release folder.
%
% This function returns the number of folders removed from the MATLAB path.
% This function assumes that the top folder has the "Release" folder.

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  TopFolder (1,1) string {mustBeFolder} = "C:\local\modutil\modeling-utility"
end  % arguments

arguments (Output)
  NumFolders (1,1) {mustBeInteger, mustBeNonnegative}
end  % arguments

target_folder = fullfile(TopFolder, "Release");
assert(isfolder(target_folder))

files_and_folders = matlab.buildtool.io.FileCollection.fromPaths(fullfile(target_folder, "**")).paths';
folders = files_and_folders(isfolder(files_and_folders));
folders = folders(~contains(folders, ("/"|"\") + "+" + alphanumericsPattern));  % namespaces
folders = folders(~contains(folders, ".buildtool"));
folders = folders(~contains(folders, "test-result"));

% Check if the folders are in the MATLAB path, and if not, remove from the folders array.
% This is to avoid warnings from rmpath.
matlab_path = string(split(path, ";"));
logical_index = ismember(folders, matlab_path);
folders = folders(logical_index);

NumFolders = numel(folders);
if NumFolders == 0
  % None of the folders are in the MATLAB path.

  return

end  % if

rmpath(folders{:})

end  % function
