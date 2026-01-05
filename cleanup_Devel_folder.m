function cleanup_Devel_folder
% Delete auto-generated files and folders under the "Devel" folder.
% Test results are deleted.

% Copyright 2025 The MathWorks, Inc.

devel_folder = "C:\local\modutil\modeling-utility\Devel";
assert(isfolder(devel_folder))

% Delete ".buidltool" folders.
dot_buildtool_folder_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(devel_folder, "**", ".buildtool")).paths';
disp(dot_buildtool_folder_to_delete)
if not(isempty(dot_buildtool_folder_to_delete))
  for ii = 1 : numel(dot_buildtool_folder_to_delete)
    rmdir(dot_buildtool_folder_to_delete(ii), "s")
  end  % for
end  % if

% Delete "test-result" folders.
test_result_folder_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(devel_folder, "**", "test-result")).paths';
disp(test_result_folder_to_delete)
if not(isempty(test_result_folder_to_delete))
  for ii = 1 : numel(test_result_folder_to_delete)
    rmdir(test_result_folder_to_delete(ii), "s")
  end  % for
end  % if
end  % function
