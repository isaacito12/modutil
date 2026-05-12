session = SearchUtil1.searchText( ...
  ".MainFigure =", ...
  IgnoreCase = false, ...
  MatchWholeWord = false, ...
  TargetFolder = "C:\local\modutil\repo\worktrees\R2024b-devel\Devel", ...
  IncludeSubfolders = true, ...
  FileTypes = "*.m", ...
  ExcludeLiveScript = false, ...
  ExcludeMATLABCodeFile = false );

% -----------------------------------------------------------------------------
% Exclude lines that contain a specific pattern.

result_table = session.Result;
logical_index = contains(result_table.LineText, "App.MainFigure");
target_table = result_table(not(logical_index), :);

logical_index = contains(target_table.FilePath, "+AppUtil1");
target_table = target_table(not(logical_index), :);

logical_index = contains(target_table.FilePath, ".MainFigure = uifigure");
target_table = target_table(not(logical_index), :);

% -----------------------------------------------------------------------------
files = unique(target_table.FilePath);

% Assume that this script runs from the Devel folder.
FileListApp(files, TopFolder=pwd)
