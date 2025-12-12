function copyComponent_RotationalFrictionApp(NameValuePair)
%%
% This funciton copies files related to RotationalFrictionApp.
% The API files are copied by the copyAPIFromDevToRelease function.

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  NameValuePair.RepositoryTopFolder (1,1) string {mustBeFolder}  = "C:\local\modutil\modeling-utility"
  NameValuePair.DestinationTopFolder (1,1) string = "C:\local\modutil\modeling-utility\Release\ModelingUtilityForSimscape"
  NameValuePair.DryRun (1,1) logical = true
end  % arguments

app_source_folder = fullfile(NameValuePair.RepositoryTopFolder, "Devel", "AppsForPhysicalSystems", "RotationalFriction");
mustBeFolder(app_source_folder)

safe_mkdir(NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

destination_media_folder = fullfile(NameValuePair.DestinationTopFolder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

% Copy releasing files.

destination_namespace = fullfile(NameValuePair.DestinationTopFolder, "+RotationalFriction1");
safe_mkdir(destination_namespace, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "+RotationalFriction1", "plotFrictionTorque.m");
safe_copyfile(app_source_file, destination_namespace, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "+RotationalFriction1", "RotationalFrictionAppMain.m");
safe_copyfile(app_source_file, destination_namespace, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "+RotationalFriction1", "RotationalFrictionData.m");
safe_copyfile(app_source_file, destination_namespace, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "+RotationalFriction1", "RotationalFrictionModelParameters.m");
safe_copyfile(app_source_file, destination_namespace, NameValuePair.DryRun)

%---

app_source_file = fullfile(app_source_folder, "RotationalFrictionApp.m");
safe_copyfile(app_source_file, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "RotationalFrictionCustomApp1.m");
safe_copyfile(app_source_file, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "samplemodel_RotationalFriction_refsub.mdl");
safe_copyfile(app_source_file, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "sampleparams_RotationalFriction.m");
safe_copyfile(app_source_file, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "RotationalFriction_Description.html");
safe_copyfile(app_source_file, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

% Copy screenshot images to the media folder.

app_source_file = fullfile(app_source_folder, "screenshot-RotationalFrictionApp-dark-1.png");
safe_copyfile(app_source_file, destination_media_folder, NameValuePair.DryRun)

app_source_file = fullfile(app_source_folder, "screenshot-RotationalFrictionApp-light-1.png");
safe_copyfile(app_source_file, destination_media_folder, NameValuePair.DryRun)

end  % function
