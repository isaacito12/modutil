function ResultTable = searchForTextInTextFiles(TargetText, NameValuePair)
% Search for the specified text in text files in the current folder tree.
%
% This function depends on MATLAB only. No extra libraries or toolboxes are required.
% This function works on text files only.
% 
%   found_list = searchForTextInTextFiles("FindThisText");
%

% Copyright 2026 The MathWorks, Inc.

arguments (Input)
  TargetText (1,1) pattern = pattern.empty
  NameValuePair.FileExtensions (1,:) string = ["*.m", "*.md", "*.mdl", "*.ssc", "*.txt"]
end  % arguments

arguments (Output)
  ResultTable table
end  % arguments

errorId = "searchForTextInTextFiles:";

if isempty(TargetText)
  id = errorId + "InvalidTargetText";
  msg = "TargetText must be non-empty.";

  throw(MException(id, msg))

end  % if

top_folder = pwd;
assert(isfolder(top_folder))

% -----------------------------------------------------------------------------
% First pass: Find files as matlab.buildtool.io.FileCollection

collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(top_folder, "**", NameValuePair.FileExtensions));

% -----------------------------------------------------------------------------
% Number of files found
found_files = paths(collection)';
num_files = numel(found_files);
if num_files == 0
  disp("No files for update were found.")
  ResultTable = table([], [], [], 'VariableNames', ["FilePath", "LineNumber", "LineText"]);

  return

end  % if

% -----------------------------------------------------------------------------
% Second pass: Determine the number of rows necessary for a table.

% Match whole word
b = (lineBoundary|textBoundary|whitespaceBoundary|alphanumericBoundary);
search_text = b + TargetText + b;

file_path = strings(num_files, 1);
num_rows = 0;
for ii = 1 : num_files
  target_file = found_files(ii);
  lines = readlines(target_file);
  logical_index = contains(lines, search_text, IgnoreCase=false);
  num_lines = nnz(logical_index);
  if num_lines == 0

    continue

  end  % if
  file_path(ii) = target_file;
  num_rows = num_rows + num_lines;
end  % for

if num_rows == 0
  disp("Specified search text was not found.")
  ResultTable = table([], [], [], 'VariableNames', ["FilePath", "LineNumber", "LineText"]);

  return

end  % if

logical_index = file_path ~= "";
file_path = file_path(logical_index);

% -----------------------------------------------------------------------------
% Third pass: Build a table containing matched lines.

FilePath = strings(num_rows, 1);
LineNumber = nan(num_rows, 1);
LineText = strings(num_rows, 1);

num_files = numel(file_path);
item_count = 0;
for ii = 1 : num_files
  target_file = file_path(ii);
  lines = readlines(target_file);
  logical_index = contains(lines, search_text, IgnoreCase=false);
  line_number = find(logical_index);
  line_text = lines(logical_index);
  for jj = 1 : numel(line_text)
    item_count = item_count + 1;
    if top_folder == ""
      FilePath(item_count) = target_file;
    else
      FilePath(item_count) = extractAfter(target_file, top_folder + ("/"|"\"));
    end  % if
    LineNumber(item_count) = line_number(jj);
    LineText(item_count) = line_text(jj);
  end  % for
end  % for

ResultTable = table(FilePath, LineNumber, LineText);

end  % function
