%% Delete all files under the "Release > ModelingUtilityForSimscape" folder.

% Copyright 2025 The MathWorks, Inc.

target_folder = "C:\local\modutil\modeling-utility\Release\ModelingUtilityForSimscape";
assert(isfolder(target_folder))

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
