function copyFromDevToRelease

% Copyright 2025 The MathWorks, Inc.

copyUtilityAPIsToRelease(DryRun=false)
copyAppsToRelease

end  % function

function copyUtilityAPIsToRelease(NameValuePair)
%% Copy the utility source files to the "Release > ModelingUtilityForSimscape" folder.

arguments (Input)
  NameValuePair.DryRun (1,1) logical = true
  NameValuePair.RepoTopFolder (1,1) string {mustBeFolder} = "C:\local\modutil\modeling-utility"
end  % arguments

assert(pwd == NameValuePair.RepoTopFolder)

devel_folder = fullfile(NameValuePair.RepoTopFolder, "Devel");
assert(isfolder(devel_folder))

release_folder = fullfile(NameValuePair.RepoTopFolder, "Release", "ModelingUtilityForSimscape");
if isfolder(release_folder)
  rmdir(release_folder, "s")
end  % if
mkdir(release_folder)

source_folders = matlab.buildtool.io.FileCollection.fromPaths(fullfile(devel_folder, "**", "+*Util*")).paths';
target_folders = extractAfter(source_folders, "Util"+("/"|"\"));
command_text = strings(numel(target_folders), 1);
for ii = 1 : numel(target_folders)
  source_folder = source_folders(ii);
  destination_folder = fullfile(release_folder, target_folders(ii));
  command_text(ii) = "copyfile(""" + source_folder + """, """ + destination_folder + """)";
end  % for
command_text = join(command_text, newline);

if NameValuePair.DryRun
  disp("Dry run")
  disp(command_text)

  return

end  % if
disp(command_text)
eval(command_text)
end  % function

function copyAppsToRelease
%% Copy app files and related files to the "Release > ModelingUtilityForSimscape" folder.

% Copyright 2025 The MathWorks, Inc.

top_folder = "C:\local\modutil\modeling-utility";
assert(isfolder(top_folder))

destination_folder = fullfile(top_folder, "Release", "ModelingUtilityForSimscape");
assert(isfolder(destination_folder))

%% Passing tests
source_file = fullfile(top_folder, "PassingTestsForModelingUtility.m");
assert(isfile(source_file))
copyfile(source_file, destination_folder)

%% Rotational friction app (folder)
source_folder = fullfile(top_folder, "Devel", "AppsForPhysicalSystems", "RotationalFriction");
assert(isfolder(source_folder))

% Copy folder.
copyfile(source_folder, destination_folder)

%% App Utility
source_folder = fullfile(top_folder, "Devel", "AppUtil");
assert(isfolder(source_folder))

source_file = fullfile(source_folder, "MonitorInfoApp.m");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

%% Code Utility
source_folder = fullfile(top_folder, "Devel", "CodeUtil");
assert(isfolder(source_folder))

source_file = fullfile(source_folder, "demoapp_PhysicalValue_1.m");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

source_file = fullfile(source_folder, "demoapp_PhysicalValue_2_derive.m");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

%% Model Utility
source_folder = fullfile(top_folder, "Devel", "ModelUtil");
assert(isfolder(source_folder))

source_file = fullfile(source_folder, "LookupTable1DBlockPlotApp.m");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

%% Search Utility
source_folder = fullfile(top_folder, "Devel", "SearchUtil");
assert(isfolder(source_folder))

source_file = fullfile(source_folder, "TextSearchApp.m");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

source_file = fullfile(source_folder, "TextSearchResultViewerApp.m");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

%% Signal Utility
source_folder = fullfile(top_folder, "Devel", "SignalUtil");
assert(isfolder(source_folder))

source_file = fullfile(source_folder, "SignalDesignApp_Description.html");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

source_file = fullfile(source_folder, "SignalDesignApp.m");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

source_file = fullfile(source_folder, "TraceGeneratorApp_Description.html");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

source_file = fullfile(source_folder, "TraceGeneratorApp.m");
assert(isfile(source_file))

copyfile(source_file, destination_folder)

end  % function
