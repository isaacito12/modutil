function copyComponent_SignalUtil_additional_files(NameValuePair)
%%

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  NameValuePair.RepositoryTopFolder (1,1) string {mustBeFolder}  = "C:\local\modutil\modeling-utility"
  NameValuePair.DestinationTopFolder (1,1) string = "C:\local\modutil\modeling-utility\Release\ModelingUtilityForSimscape"
  NameValuePair.DryRun (1,1) logical = true
end  % arguments

app_source_folder = fullfile(NameValuePair.RepositoryTopFolder, "Devel", "SignalUtil");
mustBeFolder(app_source_folder)

safe_mkdir(NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

destination_media_folder = fullfile(NameValuePair.DestinationTopFolder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

% Copy releasing files.

file_to_copy = fullfile(app_source_folder, "demo_TimedTrace.m");
safe_copyfile(file_to_copy, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

file_to_copy = fullfile(app_source_folder, "SignalDesignApp_Description.html");
safe_copyfile(file_to_copy, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

file_to_copy = fullfile(app_source_folder, "SignalDesignApp.m");
safe_copyfile(file_to_copy, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

file_to_copy = fullfile(app_source_folder, "TraceGeneratorApp_Description.html");
safe_copyfile(file_to_copy, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

file_to_copy = fullfile(app_source_folder, "TraceGeneratorApp.m");
safe_copyfile(file_to_copy, NameValuePair.DestinationTopFolder, NameValuePair.DryRun)

% Copy screenshot images to the media folder.

file_to_copy = fullfile(app_source_folder, "screenshot-SignalDesignApp-dark.png");
safe_copyfile(file_to_copy, destination_media_folder, NameValuePair.DryRun)

file_to_copy = fullfile(app_source_folder, "screenshot-SignalDesignApp-light.png");
safe_copyfile(file_to_copy, destination_media_folder, NameValuePair.DryRun)

file_to_copy = fullfile(app_source_folder, "screenshot-TraceGeneratorApp-dark.png");
safe_copyfile(file_to_copy, destination_media_folder, NameValuePair.DryRun)

file_to_copy = fullfile(app_source_folder, "screenshot-TraceGeneratorApp-light.png");
safe_copyfile(file_to_copy, destination_media_folder, NameValuePair.DryRun)

end  % function
