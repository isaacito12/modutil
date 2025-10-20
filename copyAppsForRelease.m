%% Copy app files and related files to the "Release > ModelingUtilityForSimscape" folder.

% Copyright 2025 The MathWorks, Inc.

topfolder = "C:\local\modutil\modeling-utility";
assert(isfolder(topfolder))

destination = fullfile(topfolder, "Release", "ModelingUtilityForSimscape");
assert(isfolder(destination))

%% Passing tests
source_file = fullfile(topfolder, "ModelingUtilityPassingTests.m");
assert(isfile(source_file))
copyfile(source_file, destination)

%% App Utility
source_folder = fullfile(topfolder, "Devel", "AppUtil");
assert(isfolder(source_folder))

% -----------------------------------------------------------------------------
source_file = fullfile(source_folder, "MonitorInfoApp.m");
assert(isfile(source_file))
copyfile(source_file, destination)

%% Code Utility
source_folder = fullfile(topfolder, "Devel", "CodeUtil");
assert(isfolder(source_folder))

% -----------------------------------------------------------------------------
source_file = fullfile(source_folder, "demoapp_PhysicalValue_1.m");
assert(isfile(source_file))
copyfile(source_file, destination)

% -----------------------------------------------------------------------------
source_file = fullfile(source_folder, "demoapp_PhysicalValue_2_derive.m");
assert(isfile(source_file))
copyfile(source_file, destination)

%% Model Utility
source_folder = fullfile(topfolder, "Devel", "ModelUtil");
assert(isfolder(source_folder))

% -----------------------------------------------------------------------------
source_file = fullfile(source_folder, "demoapp_plotLookupTable1DBlocks.m");
assert(isfile(source_file))
copyfile(source_file, destination)

%% Search Utility
source_folder = fullfile(topfolder, "Devel", "SearchUtil");
assert(isfolder(source_folder))

% -----------------------------------------------------------------------------
source_file = fullfile(source_folder, "TextSearchApp.m");
assert(isfile(source_file))
copyfile(source_file, destination)

% -----------------------------------------------------------------------------
source_file = fullfile(source_folder, "TextSearchResultViewerApp.m");
assert(isfile(source_file))
copyfile(source_file, destination)

%% Signal Utility
source_folder = fullfile(topfolder, "Devel", "SignalUtil");
assert(isfolder(source_folder))

% -----------------------------------------------------------------------------
source_file = fullfile(source_folder, "SignalDesignApp_Description.html");
assert(isfile(source_file))
copyfile(source_file, destination)

source_file = fullfile(source_folder, "SignalDesignApp.m");
assert(isfile(source_file))
copyfile(source_file, destination)

% -----------------------------------------------------------------------------
source_file = fullfile(source_folder, "TimedTraceBuilderApp_Description.html");
assert(isfile(source_file))
copyfile(source_file, destination)

source_file = fullfile(source_folder, "TimedTraceBuilderApp.m");
assert(isfile(source_file))
copyfile(source_file, destination)
