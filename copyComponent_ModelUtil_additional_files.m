function copyComponent_ModelUtil_additional_files(NameValuePair)
%%
% This funciton copies files from ModelUtil excluding the API files.
% The API files are copied by the copyAPIFromDevToRelease function.

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  NameValuePair.RepositoryTopFolder (1,1) string {mustBeFolder}  = "C:\local\modutil\modeling-utility"
  NameValuePair.DestinationTopFolder (1,1) string = "C:\local\modutil\modeling-utility\Release\ModelingUtilityForSimscape"
  NameValuePair.DryRun (1,1) logical = true
end  % arguments

app_source_folder = fullfile(NameValuePair.RepositoryTopFolder, "Devel", "ModelUtil");
mustBeFolder(app_source_folder)

safe_mkdir(NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

destination_media_folder = fullfile(NameValuePair.DestinationTopFolder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

% Copy releasing files.

app_source_file = fullfile(app_source_folder, "LookupTable1DBlockPlotApp.m");
safe_copyfile(app_source_file, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "samplemodel_LookupTable1DBlockPlotApp.mdl");
safe_copyfile(app_source_file, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

% Copy screenshot images to the media folder.

app_source_file = fullfile(app_source_folder, "screenshot-LookupTable1DBlockPlotApp-dark.png");
safe_copyfile(app_source_file, destination_media_folder, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "screenshot-LookupTable1DBlockPlotApp-light.png");
safe_copyfile(app_source_file, destination_media_folder, NameValuePair.DryRun)

end  % function
