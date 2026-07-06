function copyComponent_additional_files_AppUtil(NameValuePair)
% Copy additional files from the Devel folder to the Release folder.
%
% This function assumes that the source files are version-managed with git.
% The API files are copied separately.

% Copyright 2026 The MathWorks, Inc.

arguments (Input)
  NameValuePair.DryRun (1,1) logical = true
end  % arguments

try
  repo = gitrepo;
catch exception

  rethrow(exception)

end  % try, catch
repo_top_folder = repo.WorkingFolder;

source_folder = fullfile(repo_top_folder, "Devel", "Test", "AppUtil");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release-mus1", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

file_to_copy = fullfile(source_folder, "ContourQuiverApp.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

end  % function
