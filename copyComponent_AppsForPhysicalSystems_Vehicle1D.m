function copyComponent_AppsForPhysicalSystems_Vehicle1D(NameValuePair)
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

source_folder = fullfile(repo_top_folder, "Devel", "AppsForPhysicalSystems", "Vehicle1D");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

destination_subfolder = fullfile(destination_top_folder, "+Vehicle1D1");
safe_mkdir(destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1D1", "plotVehicle1DPerformance.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1D1", "Vehicle1DAppMain.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1D1", "Vehicle1DDataSet.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1D1", "Vehicle1DModelParameters.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

file_to_copy = fullfile(source_folder, "+Vehicle1D1", "Vehicle1DParameterPresets.m");
safe_copyfile(file_to_copy, destination_subfolder, NameValuePair.DryRun)

% ---

file_to_copy = fullfile(source_folder, "Vehicle1DApp.m");
safe_copyfile(file_to_copy, destination_top_folder, NameValuePair.DryRun)

end  % function
