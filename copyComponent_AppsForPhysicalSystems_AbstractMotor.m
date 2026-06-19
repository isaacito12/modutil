function copyComponent_AppsForPhysicalSystems_AbstractMotor(NameValuePair)
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

source_folder = fullfile(repo_top_folder, "Devel", "AppsForPhysicalSystems", "AbstractMotor");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

destination_subfolder = fullfile(destination_top_folder, "+AbstractMotor1");
safe_mkdir(destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+AbstractMotor1", "AbstractMotorDataSet.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+AbstractMotor1", "AbstractMotorEfficiencyAppMain.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+AbstractMotor1", "AbstractMotorModelParameters.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+AbstractMotor1", "plotAbstractMotorEfficiency.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

% ---

file_to_copy = fullfile(source_folder, "AbstractMotor_Description.html");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "AbstractMotorEfficiencyApp_WithVariables.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "AbstractMotorEfficiencyApp.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "SampleModel_AbstractMotor_refsub_24b.mdl");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "SampleParams_AbstractMotor.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

end  % function
