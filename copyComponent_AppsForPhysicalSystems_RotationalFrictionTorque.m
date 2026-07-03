function copyComponent_AppsForPhysicalSystems_RotationalFrictionTorque(NameValuePair)
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

source_folder = fullfile(repo_top_folder, "Devel", "AppsForPhysicalSystems", "RotationalFrictionTorque");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

destination_media_folder = fullfile(destination_top_folder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

safe_copyfile(fullfile(source_folder, "media", "screenshot-RotationalFrictionTorqueApp-light.png"), destination_media_folder, NameValuePair.DryRun)

% ---

safe_copyfile(fullfile(source_folder, "mus1_RotationalFrictionTorqueApp.m"), destination_top_folder, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "RotationalFrictionTorqueApp_Description_mus1.html"), destination_top_folder, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "SampleModel_RotationalFrictionTorque_refsub_24b.mdl"), destination_top_folder, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "RotationalFrictionTorque_SampleParams1.m"), destination_top_folder, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "RotationalFrictionTorque_SampleParams2.m"), destination_top_folder, NameValuePair.DryRun)

end  % function
