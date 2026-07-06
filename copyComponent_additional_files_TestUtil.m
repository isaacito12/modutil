function copyComponent_additional_files_TestUtil(NameValuePair)
% Copy additional files from the Devel folder to the Release folder.
%
% This function assumes that the source files are version-managed with git.
% The API files are copied separately.

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

source_folder = fullfile(repo_top_folder, "Devel", "Test", "TestUtil");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release-mus1", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

destination_media_folder = fullfile(destination_top_folder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

files = matlab.buildtool.io.FileCollection.fromPaths(fullfile(source_folder, "**", "screenshot-TestResultApp-light.png")).paths';
file_to_copy = files(1);
safe_copyfile(file_to_copy, destination_media_folder, NameValuePair.DryRun)

% ---

file_to_copy = fullfile(source_folder, "CodeCoverageApp.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "TestResultApp.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

end  % function
