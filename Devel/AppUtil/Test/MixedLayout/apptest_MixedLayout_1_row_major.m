function App = apptest_MixedLayout_1_row_major
% Create a column grid and add UI components row by row, which
% is the row-major placement of components.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

common_height = AppUtil1.Constant.Height{"oneline++"}*2;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 320;  % height

main_column_layout = AppUtil1.ColumnLayout(main_figure);  % !test-target

% -----------------------------------------------------------------------------
row_layout = AppUtil1.RowLayout(NewColumnGrid(main_column_layout));  % !test-target

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 1";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 2";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 3";
label_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
row_layout = AppUtil1.RowLayout(NewColumnGrid(main_column_layout));  % !test-target

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "center";
label_ui.Text = "Test 4";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "top";
label_ui.Text = "Test 5";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "bottom";
label_ui.Text = "Test 6";
label_ui.HighlightBackground = "off";

% -----------------------------------------------------------------------------
row_layout = AppUtil1.RowLayout(NewColumnGrid(main_column_layout));  % !test-target

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 7";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 8";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 9";
label_ui.HighlightBackground = "on";

%%
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
