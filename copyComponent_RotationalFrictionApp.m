function copyComponent_RotationalFrictionApp(NameValuePair)
% Copy the releasing files from the Devel folder to the Release folder.
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

source_folder = fullfile(repo_top_folder, "Devel", "AppsForPhysicalSystems", "RotationalFriction");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

destination_namespace_folder = fullfile(destination_top_folder, "+RotationalFriction1");
safe_mkdir(destination_namespace_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "+RotationalFriction1", "plotFrictionTorque.m");
safe_copyfile(releasing_file, destination_namespace_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "+RotationalFriction1", "RotationalFrictionAppMain.m");
safe_copyfile(releasing_file, destination_namespace_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "+RotationalFriction1", "RotationalFrictionData.m");
safe_copyfile(releasing_file, destination_namespace_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "+RotationalFriction1", "RotationalFrictionModelParameters.m");
safe_copyfile(releasing_file, destination_namespace_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "RotationalFrictionApp.m");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "RotationalFrictionCustomApp1.m");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "SampleModel_RotationalFriction_refsub_24b.mdl");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "SampleParams_RotationalFriction.m");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "RotationalFriction_Description.html");
safe_copyfile(releasing_file, destination_top_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy screenshot images to the media folder.
destination_media_folder = fullfile(destination_top_folder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "media", "screenshot-RotationalFrictionApp-dark-1.png");
safe_copyfile(releasing_file, destination_media_folder, NameValuePair.DryRun)

releasing_file = fullfile(source_folder, "media", "screenshot-RotationalFrictionApp-light-1.png");
safe_copyfile(releasing_file, destination_media_folder, NameValuePair.DryRun)

end  % function
