function copyComponent_additional_files_SignalUtil(NameValuePair)
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

source_folder = fullfile(repo_top_folder, "Devel", "Test", "SignalUtil");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

destination_media_folder = fullfile(destination_top_folder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Signal design app

files = matlab.buildtool.io.FileCollection.fromPaths(fullfile(source_folder, "**", "screenshot-SignalDesignApp-light.png")).paths';
file_to_copy = files(1);
safe_copyfile(file_to_copy, destination_media_folder, NameValuePair.DryRun)

% ---

releasing_file = fullfile(source_folder, "SignalDesignApp_Description.html");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "SignalDesignApp.m");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Trace generator app

files = matlab.buildtool.io.FileCollection.fromPaths(fullfile(source_folder, "**", "screenshot-TraceGeneratorApp-light.png")).paths';
file_to_copy = files(1);
safe_copyfile(file_to_copy, destination_media_folder, NameValuePair.DryRun)

% ---

releasing_file = fullfile(source_folder, "TraceGeneratorApp_Description.html");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "TraceGeneratorApp.m");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

end  % function
