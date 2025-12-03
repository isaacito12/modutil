function App = FileListApp(FileList, NameValuePair)
% App to show a file list for click-to-open
%
% This is an app to open a file with double-click on a table row in the list of files.
% This app takes either a string array or a table.
% A string array must contain a list of file paths.
% A table must contain the "FilePath" column, and optionally the "LineNumber" column.
% If the table has no LineNumber column, first line is used.
%
%   FileListApp(<file_list>)
%
% Use the TopFolder option if the file path in the file list does not start from
% the current folder.
%
%   FileListApp(<file_list>, TopFolder=<path/to/folder>)
%
% The file list can have 3 more columns.
% Two of the columns must be "FilePath" and "LineNumber" while the other columns
% can have any column names.
% To customize the column names, use the ColumnNames option.
% To customize the column width, use the ColumnWidth option.
% ColumnNames and ColumnWidth are passed to uitable.
% See the documentation about uitable for details.
% https://www.mathworks.com/help/matlab/ref/matlab.ui.control.table.html
% If names and/or widths are not customized, uitable's default settings are used.
%
% -----------------------------------------------------------------------------
% Example using the result of the searchText command
%
% First, do text search with searchText.
%
%   session = SearchUtil1.searchText( ...
%     "movegui", ...
%     TopFolder = "C:\local\modutil\modeling-utility\Devel", ...
%     IncludeSubfolders = true, ...
%     FileTypes = "*.m" );
%
% Then pass the search result to the FileListApp as follows.
%
%   FileListApp(session.Result, TopFolder=session.Searcher.States.TargetFolder)

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  FileList {mustBeA(FileList, ["string", "table"])} = "sample.m"
  NameValuePair.TopFolder {mustBeFolder} = pwd
  NameValuePair.ColumnNames
  NameValuePair.ColumnWidth
end  % arguments

arguments (Output)
  App struct
end  % arguments

errorID = "FileListApp:";

if class(FileList) == "string"
  if isempty(FileList) || (isscalar(FileList) && FileList == "")
    id = errorID + "EmptyStringForFileList";
    msg = CodeUtil1.i18n("FileList string must be non-empty.");

    throw(MException(id, msg))

  end  % if
  FilePath = FileList(:);
  FileList = table(FilePath);

else
  % FileList is a table.
  if isempty(FileList)
    id = errorID + "EmptyTableForFileList";
    msg = CodeUtil1.i18n("FileList table must be non-empty.");

    throw(MException(id, msg))

  end  % if
  column_names = string(FileList.Properties.VariableNames);
  if not(ismember("FilePath", column_names))
    id = errorID + "MissingFilePathColumn";
    msg = CodeUtil1.i18n("Table must have FilePath column.");

    throw(MException(id, msg))

  end  % if
end  % if

column_names = string(FileList.Properties.VariableNames);
if not(ismember("LineNumber", column_names))
  LineNumber = ones(height(FileList), 1);
  line_number_table = table(LineNumber);
  FileList = horzcat(FileList, line_number_table);
end  % if

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 760;
app_window.Height = 520;
app_window.Name = CodeUtil1.i18n("File List");

main_column_layout = app_window.MainLayout;

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = CodeUtil1.i18n("Folder");

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
folder_ui = AppUtil1.Component.EditField(column_grid);
folder_ui.Value = replace(NameValuePair.TopFolder, ("/"|"\"), " > ");

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = CodeUtil1.i18n("Double-click a table row to open the file.");

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout, Height="1x");

table_ui = AppUtil1.Component.Table(column_grid);
table_ui.ComponentHeight = 400;

table_ui.MainTable.Data = FileList;

if not(isfield(NameValuePair, "ColumnNames"))
  if width(FileList) == 2
    % Default setting
    table_ui.MainTable.ColumnName = [CodeUtil1.i18n("File path"), CodeUtil1.i18n("Line number")];
  end

elseif isfield(NameValuePair, "ColumnNames")
  if numel(NameValuePair.ColumnNames) < 3
    id = errorID + "InvalidColumnNames";
    msg = CodeUtil1.i18n("ColumnNames must have 3 or more elements.");

    throw(MException(id, msg))

  end  % if
  table_ui.MainTable.ColumnNames = NameValuePair.ColumnNames;
end  % if

if not(isfield(NameValuePair, "ColumnWidth"))
  if width(FileList) == 2
    % Default setting
    table_ui.MainTable.ColumnWidth = {'1x', 'fit'};
  end  % if

elseif isfield(NameValuePair, "ColumnWidth")
  if numel(NameValuePair.ColumnWidth) < 3
    id = errorID + "InvalidColumnWidth";
    msg = CodeUtil1.i18n("ColumnWidth must have 3 or more elements.");

    throw(MException(id, msg))

  end  % if
  table_ui.MainTable.ColumnWidth = NameValuePair.ColumnWidth;
end  % if

table_ui.MainTable.ColumnSortable = true;
table_ui.MainTable.SelectionType = "row";
% uitable's DoubleClickedFcn callback is given a DoubleClickedData object as the second argument,
% and the object provides information such as the clicked row via InteractionInformation.Row, etc.
% Search "DoubleClickedData" or "InteractionInformation" in the documentation for details.
% https://www.mathworks.com/help/matlab/ref/matlab.ui.control.table.html
table_ui.MainTable.DoubleClickedFcn = @(~, DoubleClickedData) ...
  react_TableDoubleClicked(DoubleClickedData.InteractionInformation.Row);

  function react_TableDoubleClicked(row_number)
    target_row = FileList(row_number, :);
    matlab.desktop.editor.openAndGoToLine(fullfile(NameValuePair.TopFolder, target_row.FilePath), target_row.LineNumber);
  end  % function

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
end  % if
end  % function
