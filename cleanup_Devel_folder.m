function cleanup_Devel_folder(NameValuePair)
% Delete auto-generated files and folders under the Devel folder.
%
% By default, this function reports the target folders to delete but does not delete them.
% Use the DryRun=false option to actually delete.
%
% For this function to work, the folder tree must be version-managed with git.

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Input)
  NameValuePair.DryRun (1,1) logical = true
end  % arguments

try
  repo = gitrepo;
catch exception

  rethrow(exception)

end  % try, catch
repo_top_folder = repo.WorkingFolder;

devel_folder = fullfile(repo_top_folder, "Devel");
assert(isfolder(devel_folder))

disp("Deleting .buildtool folders...")
dot_buildtool_folder_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(devel_folder, "**", ".buildtool")).paths';
if not(isempty(dot_buildtool_folder_to_delete))
  for ii = 1 : numel(dot_buildtool_folder_to_delete)
    cmd = "rmdir(""" + dot_buildtool_folder_to_delete(ii) + """, ""s"")";
    if NameValuePair.DryRun
      disp("Dry run: " + cmd)
    else
      disp(dot_buildtool_folder_to_delete(ii))
      eval(cmd)
    end  % if
  end  % for
end  % if

disp("Deleting test-result folders...")
test_result_folder_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(devel_folder, "**", "test-result")).paths';
if not(isempty(test_result_folder_to_delete))
  for ii = 1 : numel(test_result_folder_to_delete)
    cmd = "rmdir(""" + test_result_folder_to_delete(ii) + """, ""s"")";
    if NameValuePair.DryRun
      disp("Dry run: " + cmd)
    else
      disp(test_result_folder_to_delete(ii))
      eval(cmd)
    end  % if
  end  % for
end  % if
end  % function
