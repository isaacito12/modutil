function App = apptest_Button_3_icon
% Test the Icon property of the component.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

width_unit = AppUtil1.Constant.Width{"unitwidth"};
common_width = width_unit * 10;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 100;  % height

app_column_layout = AppUtil1.ColumnLayout(main_figure);

%%
column_grid = NewColumnGrid(app_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

button_11_ui = AppUtil1.Component.Button(NewRowGrid(row_layout));  % !test-target
button_11_ui.MainFigure = main_figure;
button_11_ui.Icon = "question";
button_11_ui.Text = button_11_ui.Icon;
button_11_ui.ButtonWidth = common_width;

button_12_ui = AppUtil1.Component.Button(NewRowGrid(row_layout));  % !test-target
button_12_ui.MainFigure = main_figure;
button_12_ui.Icon = "info";
button_12_ui.Text = button_12_ui.Icon;
button_12_ui.ButtonWidth = common_width;

button_13_ui = AppUtil1.Component.Button(NewRowGrid(row_layout));  % !test-target
button_13_ui.MainFigure = main_figure;
button_13_ui.Icon = "success";
button_13_ui.Text = button_13_ui.Icon;
button_13_ui.ButtonWidth = common_width;

%%
column_grid = NewColumnGrid(app_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

button_21_ui = AppUtil1.Component.Button(NewRowGrid(row_layout));  % !test-target
button_21_ui.MainFigure = main_figure;
button_21_ui.Icon = "warning";
button_21_ui.Text = button_21_ui.Icon;
button_21_ui.ButtonWidth = common_width;

button_22_ui = AppUtil1.Component.Button(NewRowGrid(row_layout));  % !test-target
button_22_ui.MainFigure = main_figure;
button_22_ui.Icon = "error";
button_22_ui.Text = button_22_ui.Icon;
button_22_ui.ButtonWidth = common_width;

button_23_ui = AppUtil1.Component.Button(NewRowGrid(row_layout));  % !test-target
button_23_ui.MainFigure = main_figure;
button_23_ui.Text = "disabled";
button_23_ui.ButtonWidth = common_width;
button_23_ui.MainButton.Enable = "off";

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
