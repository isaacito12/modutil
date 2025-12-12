function App = TestResultApp(TestResultFile)
% App to view test result and double-click to open a test file
%
% This app takes a test result XML file which the Build Tool generated.
% This function internally builds a table containing TestClass, TestFunction, and TestTime
% columns using the summarizeTestResult function in the Test Utility (TestUtil)
% and shows the table. You can double-click a row in the table to open the test file.

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  TestResultFile (1,1) string = which("sample-test-result.xml")
  % TestResultFile (1,1) string = ""
end  % arguments

arguments (Output)
  App struct
end  % arguments

test_summary = [];

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 840;
app_window.Height = 470;
app_window.Name = CodeUtil1.i18n("Test Result");

main_column_layout = app_window.MainLayout;

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

row_grid = NewRowGrid(row_layout, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.MainFigure = main_figure;
label_ui.Text = CodeUtil1.i18n("Test result file");

row_grid = NewRowGrid(row_layout);
button_ui = AppUtil1.Component.Button(row_grid);
button_ui.MainFigure = main_figure;
button_ui.ComponentWidth = 120;
button_ui.Text = CodeUtil1.i18n("Select file");
button_ui.ButtonPushedCallback = @() react_SelectBuuttonPushed();

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

row_grid = NewRowGrid(row_layout);
link_ui = AppUtil1.Component.Hyperlink(row_grid);
link_ui.MainFigure = main_figure;
link_ui.Text = "";

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

row_grid = NewRowGrid(row_layout, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.MainFigure = main_figure;
label_ui.Text = CodeUtil1.i18n("Number of tests");

row_grid = NewRowGrid(row_layout);
num_tests_ui = AppUtil1.Component.Label(row_grid);
num_tests_ui.MainFigure = main_figure;
num_tests_ui.Text = "";

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

row_grid = NewRowGrid(row_layout, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.MainFigure = main_figure;
label_ui.Text = CodeUtil1.i18n("Total test time (s) ");

row_grid = NewRowGrid(row_layout);
total_time_label_ui = AppUtil1.Component.Label(row_grid);
total_time_label_ui.MainFigure = main_figure;
total_time_label_ui.Text = "";

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

row_grid = NewRowGrid(row_layout, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.MainFigure = main_figure;
label_ui.Text = CodeUtil1.i18n("Average test time (s) ");

row_grid = NewRowGrid(row_layout);
mean_time_label_ui = AppUtil1.Component.Label(row_grid);
mean_time_label_ui.MainFigure = main_figure;
mean_time_label_ui.Text = "";

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

row_grid = NewRowGrid(row_layout, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.MainFigure = main_figure;
label_ui.Text = CodeUtil1.i18n("Median test time (s) ");

row_grid = NewRowGrid(row_layout);
median_time_label_ui = AppUtil1.Component.Label(row_grid);
median_time_label_ui.MainFigure = main_figure;
median_time_label_ui.Text = "";

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
AppUtil1.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
label_ui = AppUtil1.Component.Label(column_grid);
label_ui.MainFigure = main_figure;
label_ui.Text = CodeUtil1.i18n("Double-click a table row to open the file.");

% -----------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout, Height="1x");

table_ui = AppUtil1.Component.Table(column_grid);
table_ui.MainFigure = main_figure;
table_ui.ComponentHeight = 260;
table_ui.MainTable.Data = table.empty;
% uitable's DoubleClickedFcn callback is given a DoubleClickedData object as the second argument,
% and the object provides information such as the clicked row via InteractionInformation.Row, etc.
% Search "DoubleClickedData" or "InteractionInformation" in the documentation for details.
% https://www.mathworks.com/help/matlab/ref/matlab.ui.control.table.html
table_ui.MainTable.DoubleClickedFcn = @(~, DoubleClickedData) ...
  react_TableDoubleClicked(DoubleClickedData.InteractionInformation.Row);

  function react_TableDoubleClicked(row_number)
    clicked_row = test_summary(row_number, :);

    target_file = which(clicked_row.TestClass + ".m");
    % !todo: check that the file exists.

    target_function = clicked_row.TestFunction;
    matlab.desktop.editor.openAndGoToFunction(target_file, target_function);
  end  % function

  function react_SelectBuuttonPushed
    % Open a dialog window to interactively get a test result file name from the user.
    [file, location] = uigetfile('*.xml');
    if not(isequal(file, 0))
      TestResultFile = fullfile(location, file);
      update_ui()

    else
      % User cancelled selecting file.

      return

    end  % if
  end  % nested function

  function update_ui
    test_summary = TestUtil1.summarizeTestResult(TestResultFile);

    link_ui.Text = replace(TestResultFile, "/"|"\", " > ");
    link_ui.HyperlinkClickedCallback = @() edit(TestResultFile);
    link_ui.Tooltip = CodeUtil1.i18n("Open in the editor.");

    num_tests_ui.Text = test_summary.Properties.CustomProperties.NumTests;
    total_time_label_ui.Text = test_summary.Properties.CustomProperties.TotalTestTime;
    mean_time_label_ui.Text = test_summary.Properties.CustomProperties.MeanTestTime;
    median_time_label_ui.Text = test_summary.Properties.CustomProperties.MedianTestTime;

    table_ui.MainTable.Data = test_summary;
    table_ui.MainTable.ColumnWidth = {'fit', '1x', 'fit'};
    table_ui.MainTable.ColumnSortable = true;
    table_ui.MainTable.SelectionType = "row";
  end  % nested function

if isfile(TestResultFile)
  update_ui()
end  % if
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
end  % if
end  % function
