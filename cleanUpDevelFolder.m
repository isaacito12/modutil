%% Delete test-related files under the "Devel" folder.

% Copyright 2025 The MathWorks, Inc.

devel_folder = "C:\local\modutil\modeling-utility\Devel";
assert(isfolder(devel_folder))

%% ".buidltool" folder
dot_buildtool_folder_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(devel_folder, "**", ".buildtool")).paths';
disp(dot_buildtool_folder_to_delete)
if not(isempty(dot_buildtool_folder_to_delete))
  for ii = 1 : numel(dot_buildtool_folder_to_delete)
    rmdir(dot_buildtool_folder_to_delete(ii), "s")
  end
end

%% "test-result" folder
test_result_folder_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(devel_folder, "**", "test-result")).paths';
disp(test_result_folder_to_delete)
if not(isempty(test_result_folder_to_delete))
  for ii = 1 : numel(test_result_folder_to_delete)
    rmdir(test_result_folder_to_delete(ii), "s")
  end
end
