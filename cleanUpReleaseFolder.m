%% Delete copied files from the "Release > ModelingUtilityForSimscape" folder.
% In the "Release > ModelingUtilityForSimscape" folder, delete files that were copied from the Devel folder.

% Copyright 2025 The MathWorks, Inc.

release_folder = "C:\local\modutil\modeling-utility\Release\ModelingUtilityForSimscape";
assert(isfolder(release_folder))

%% Passing test files
testfiles_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(release_folder, "*PassingTests.m")).paths';
disp(testfiles_to_delete)
if not(isempty(testfiles_to_delete))
  delete(testfiles_to_delete{:})
end

%%
demo_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(release_folder, "demo*.m")).paths';
disp(demo_to_delete)
if not(isempty(demo_to_delete))
  delete(demo_to_delete{:})
end

%%
app_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(release_folder, "*App.m")).paths';
disp(app_to_delete)
if not(isempty(app_to_delete))
  delete(app_to_delete{:})
end

%%
desciption_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(release_folder, "*Description.html")).paths';
disp(desciption_to_delete)
if not(isempty(desciption_to_delete))
  delete(desciption_to_delete{:})
end

%%
screenshot_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(release_folder, "screenshot*.png")).paths';
disp(screenshot_to_delete)
if not(isempty(screenshot_to_delete))
  delete(screenshot_to_delete{:})
end
