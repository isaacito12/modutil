function copyComponent_SignalUtil_additional_files(NameValuePair)
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

source_folder = fullfile(repo_top_folder, "Devel", "SignalUtil");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

releasing_file = fullfile(source_folder, "SignalDesignApp_Description.html");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "SignalDesignApp.m");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "TraceGeneratorApp_Description.html");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "TraceGeneratorApp.m");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy screenshot images to the media folder.
destination_media_folder = fullfile(destination_top_folder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "screenshot-SignalDesignApp-dark.png");
safe_copyfile(releasing_file, destination_media_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "screenshot-SignalDesignApp-light.png");
safe_copyfile(releasing_file, destination_media_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "screenshot-TraceGeneratorApp-dark.png");
safe_copyfile(releasing_file, destination_media_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "screenshot-TraceGeneratorApp-light.png");
safe_copyfile(releasing_file, destination_media_folder, NameValuePair.DryRun)

end  % function
