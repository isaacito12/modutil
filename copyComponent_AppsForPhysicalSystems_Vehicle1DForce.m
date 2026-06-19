function copyComponent_AppsForPhysicalSystems_Vehicle1DForce(NameValuePair)
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

source_folder = fullfile(repo_top_folder, "Devel", "AppsForPhysicalSystems", "Vehicle1DForce");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

destination_media_folder = fullfile(destination_top_folder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

file_to_copy = fullfile(source_folder, "media", "screenshot-Vehicle1DForceApp-light.png");
safe_copyfile(file_to_copy, destination_media_folder, NameValuePair.DryRun)

% ---

destination_subfolder = fullfile(destination_top_folder, "+Vehicle1DForce1");
safe_mkdir(destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1DForce1", "Vehicle1DForceAppMain.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1DForce1", "Vehicle1DForceAppParameters.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1DForce1", "Vehicle1DForceDataSet.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1DForce1", "Vehicle1DForceModelParameters.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1DForce1", "Vehicle1DForcePresets.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1DForce1", "plotVehicle1DForce.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

% ---

file_to_copy = fullfile(source_folder, "Vehicle1DForceApp_Description.html");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "Vehicle1DForceApp.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "Vehicle1DForce_SampleModel_refsub_24b.mdl");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "Vehicle1DForce_SampleParams1.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "Vehicle1DForce_SampleParams2.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

end  % function
