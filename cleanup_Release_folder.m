%% Delete all files under the "Release > ModelingUtilityForSimscape" folder.

% Copyright 2025 The MathWorks, Inc.

release_top_folder = "C:\local\modutil\modeling-utility\Release";
assert(isfolder(release_top_folder))

rmdir(fullfile(release_top_folder, ".buildtool"), "s")
rmdir(fullfile(release_top_folder, "test-result"), "s")

% -----------------------------------------------------------------------------
target_folder = fullfile(release_top_folder, "ModelingUtilityForSimscape");
if not(isfolder(target_folder))
  disp("There is no ModelingUtilityForSimscape folder.")

  return

end  % if
disp("Removing the ModelingUtilityForSimscape folder")

targets_to_delete = matlab.buildtool.io.FileCollection.fromPaths(fullfile(target_folder, "**")).paths';

FilesToDelete = targets_to_delete(isfile(targets_to_delete));

FoldersToDelete = targets_to_delete(isfolder(targets_to_delete));

if not(isempty(FilesToDelete))
  delete(FilesToDelete{:})
end  % if

if not(isempty(FoldersToDelete))
  for ii = 1 : numel(FoldersToDelete)
    if isfolder(FoldersToDelete(ii))
      rmdir(FoldersToDelete(ii), "s")
    end  % for
  end  % if
end  % if
