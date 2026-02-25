function NumUpdatedFiles = replaceTextInTextFiles(NameValuePair)
%
% x = replaceTextInTextFiles(CurrentText="TestUtil1", NewText="MyUtilTest");

% Copyright 2026 The MathWorks, Inc.

arguments (Input)
  NameValuePair.CurrentText (1,1) string = ""
  NameValuePair.NewText (1,1) string = ""
  NameValuePair.DryRun (1,1) logical = true
end  % arguments

arguments (Output)
  NumUpdatedFiles (1,1) {mustBeInteger, mustBeNonnegative}
end  % arguments

errorId = "replaceTextInTextFiles:";

if NameValuePair.CurrentText == ""
  id = errorId + "InvalidNamespaceName";
  msg = "Empty NamespaceName is not allowed.";

  throw(MException(id, msg))

end  % if

searched_files = runSearch(pwd, NameValuePair.CurrentText);

target_files = searched_files.FilePath;

Result = replaceText(target_files, TextPattern=NameValuePair.CurrentText, NewText=NameValuePair.NewText, DryRun=NameValuePair.DryRun);

NumUpdatedFiles = height(Result);

end  % function

function result = runSearch(top_folder, search_pattern)
%%

arguments (Input)
  top_folder (1,1) string {mustBeFolder}
  search_pattern (1,1) pattern
end  % arguments

arguments (Output)
  result (:,3) table
end  % arguments

% -----------------------------------------------------------------------
% First pass: Find files as matlab.buildtool.io.FileCollection

collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(top_folder, "**", ["*.m", "*.md", "*.mdl", "*.ssc", "*.txt"]));

% -----------------------------------------------------------------------
% Number of files found
found_files = paths(collection)';
num_files = numel(found_files);
if num_files == 0
  disp("No files for update were found.")
  result = table([], [], [], 'VariableNames', ["FilePath", "LineNumber", "LineText"]);

  return

end  % if

% -----------------------------------------------------------------------
% Second pass: Determine the number of rows necessary for a table.

% Match whole word
b = (lineBoundary|textBoundary|whitespaceBoundary|alphanumericBoundary);
search_text = b + search_pattern + b;

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
  result = table([], [], [], 'VariableNames', ["FilePath", "LineNumber", "LineText"]);

  return

end  % if

logical_index = file_path ~= "";
file_path = file_path(logical_index);

% -----------------------------------------------------------------------
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
result = table(FilePath, LineNumber, LineText);
end  % function

function Result = replaceText(FilePaths, NameValuePair)
% Replace text in the specified file.
%
% This function takes paths to the target files, a text pattern to search, and
% a new text to replace. The function returns a table containing file paths
% and the number of lines containing the searched text.

arguments (Input)
  FilePaths (:,1) string {mustBeFile}

  % DryRun=true prevents this function from actually replacing the text.
  NameValuePair.DryRun (1,1) logical = true

  % Pattern to search. See the documentation for details.
  % https://uk.mathworks.com/help/matlab/ref/pattern.html
  NameValuePair.TextPattern (:,1) pattern
  NameValuePair.IgnoreCase (1,1) logical = false
  NameValuePair.MatchWholeWord (1,1) logical = false

  % Text to replace the search text. This is ignored if DryRun is true.
  NameValuePair.NewText (:,1) string
end  % arguments

arguments (Output)
  Result table
end  % arguments

errorID = "replaceText:";

if NameValuePair.DryRun
  disp(errorID + " dry run")
end  % if

num_files = numel(FilePaths);
if num_files == 0
  id = errorID + "InvalidFilePaths";
  msg = "One or more files must be specified.";

  throw(MException(id, msg))

end  % if

if not(isfield(NameValuePair, "TextPattern"))
  id = errorID + "InvalidTextPattern";
  msg = "Text pattern must be specified.";

  throw(MException(id, msg))

end  % if

if not(isfield(NameValuePair, "NewText"))
  id = errorID + "InvalidNewText";
  msg = "New text must be specified.";

  throw(MException(id, msg))

end  % if

if NameValuePair.IgnoreCase
  pat = caseInsensitivePattern(NameValuePair.TextPattern);
else
  pat = caseSensitivePattern(NameValuePair.TextPattern);
end  % if

if NameValuePair.MatchWholeWord
  b = (lineBoundary|textBoundary|whitespaceBoundary);
  search_text = b + pat + b;
else
  search_text = pat;
end  % if

NumLines = nan(num_files, 1);
for ii = 1 : num_files
  target_file = FilePaths(ii);
  lines = readlines(target_file);
  logical_index = contains(lines, search_text);
  NumLines(ii) = nnz(logical_index);
  if NameValuePair.DryRun

    continue

  end  % if
  edited_lines = replace(lines, search_text, NameValuePair.NewText);
  writelines(edited_lines, target_file)
end  % for
Result = table(FilePaths, NumLines);
end  % function
