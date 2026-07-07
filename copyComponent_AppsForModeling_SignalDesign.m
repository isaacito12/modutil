function copyComponent_AppsForModeling_SignalDesign(NameValuePair)
% Copy files from the Devel folder to the Release folder.
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

source_folder = fullfile(repo_top_folder, "Devel", "AppsForModeling", "SignalDesign");
assert(isfolder(source_folder))

dst = fullfile(repo_top_folder, "Release-mus1", "ModelingUtilityForSimscape");
safe_mkdir(dst, NameValuePair.DryRun)

dst_media = fullfile(dst, "media");
safe_mkdir(dst_media, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

safe_copyfile(fullfile(source_folder, "mus1", "media", "screenshot-SignalDesignApp-light.png"), dst_media, NameValuePair.DryRun)

safe_copyfile(fullfile(source_folder, "mus1", "mus1_SignalDesignApp.m"), dst, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "mus1", "SignalDesignApp_Description_mus1.html"), dst, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "SampleModel_SignalDesignAppMain_24b.mdl"), dst, NameValuePair.DryRun)

end  % function
