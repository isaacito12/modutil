function copyComponent_AppsForPhysicalSystems_AbstractMotorEfficiency(NameValuePair)
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

source_folder = fullfile(repo_top_folder, "Devel", "AppsForPhysicalSystems", "AbstractMotorEfficiency");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

destination_media_folder = fullfile(destination_top_folder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

file_to_copy = fullfile(source_folder, "media", "screenshot-AbstractMotorEfficiencyApp-light.png");
safe_copyfile(file_to_copy, destination_media_folder, NameValuePair.DryRun)

% ---

destination_subfolder = fullfile(destination_top_folder, "+AbstractMotorEfficiency1");
safe_mkdir(destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+AbstractMotorEfficiency1", "AbstractMotorEfficiencyAppMain.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+AbstractMotorEfficiency1", "AbstractMotorEfficiencyAppParameters.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+AbstractMotorEfficiency1", "AbstractMotorEfficiencyDataSet.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+AbstractMotorEfficiency1", "AbstractMotorEfficiencyModelParameters.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+AbstractMotorEfficiency1", "plotAbstractMotorEfficiency.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

% ---

file_to_copy = fullfile(source_folder, "AbstractMotorEfficiencyApp_Description.html");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "AbstractMotorEfficiencyApp.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "AbstractMotorEfficiency_SampleModel_refsub_24b.mdl");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "AbstractMotorEfficiency_SampleParams1.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "AbstractMotorEfficiency_SampleParams2.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

end  % function
