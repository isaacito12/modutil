function App = apptest_Hyperlink_2_inner_align
% Test the horizontal and vertical position of the main component within the component.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

common_height = AppUtil1.Constant.Height{"oneline++"}*3;

main_figure = uifigure(Visible="off");

main_figure.Position(3) = 700;  % width
main_figure.Position(4) = 300;  % height

main_column_layout = AppUtil1.ColumnLayout(main_figure);

%%
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

link_11_ui = AppUtil1.Component.Hyperlink(NewRowGrid(row_layout));  % !test-target
link_11_ui.MainFigure = main_figure;
link_11_ui.Text = "Testing" + newline + "hyperlink component";
link_11_ui.ComponentHeight = common_height;
link_11_ui.VerticalAlignment = "top";
link_11_ui.HorizontalAlignment = "left";
link_11_ui.HighlightBackground = "on";

link_12_ui = AppUtil1.Component.Hyperlink(NewRowGrid(row_layout));  % !test-target
link_12_ui.MainFigure = main_figure;
link_12_ui.Text = "Testing" + newline + "hyperlink component";
link_12_ui.ComponentHeight = common_height;
link_12_ui.VerticalAlignment = "top";
link_12_ui.HorizontalAlignment = "center";
link_12_ui.HighlightBackground = "off";

link_13_ui = AppUtil1.Component.Hyperlink(NewRowGrid(row_layout));  % !test-target
link_13_ui.MainFigure = main_figure;
link_13_ui.Text = "Testing" + newline + "hyperlink component";
link_13_ui.ComponentHeight = common_height;
link_13_ui.VerticalAlignment = "top";
link_13_ui.HorizontalAlignment = "right";
link_13_ui.HighlightBackground = "on";

%%
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

link_21_ui = AppUtil1.Component.Hyperlink(NewRowGrid(row_layout));  % !test-target
link_21_ui.MainFigure = main_figure;
link_21_ui.Text = "Testing" + newline + "hyperlink component";
link_21_ui.ComponentHeight = common_height;
link_21_ui.VerticalAlignment = "center";
link_21_ui.HorizontalAlignment = "left";
link_21_ui.HighlightBackground = "off";

link_22_ui = AppUtil1.Component.Hyperlink(NewRowGrid(row_layout));  % !test-target
link_22_ui.MainFigure = main_figure;
link_22_ui.Text = "Testing" + newline + "hyperlink component";
link_22_ui.ComponentHeight = common_height;
link_22_ui.VerticalAlignment = "center";
link_22_ui.HorizontalAlignment = "center";
link_22_ui.HighlightBackground = "on";

link_23_ui = AppUtil1.Component.Hyperlink(NewRowGrid(row_layout));  % !test-target
link_23_ui.MainFigure = main_figure;
link_23_ui.Text = "Testing" + newline + "hyperlink component";
link_23_ui.ComponentHeight = common_height;
link_23_ui.VerticalAlignment = "center";
link_23_ui.HorizontalAlignment = "right";
link_23_ui.HighlightBackground = "off";

%%
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

link_31_ui = AppUtil1.Component.Hyperlink(NewRowGrid(row_layout));  % !test-target
link_31_ui.MainFigure = main_figure;
link_31_ui.Text = "Testing" + newline + "hyperlink component";
link_31_ui.ComponentHeight = common_height;
link_31_ui.VerticalAlignment = "bottom";
link_31_ui.HorizontalAlignment = "left";
link_31_ui.HighlightBackground = "on";

link_32_ui = AppUtil1.Component.Hyperlink(NewRowGrid(row_layout));  % !test-target
link_32_ui.MainFigure = main_figure;
link_32_ui.Text = "Testing" + newline + "hyperlink component";
link_32_ui.ComponentHeight = common_height;
link_32_ui.VerticalAlignment = "bottom";
link_32_ui.HorizontalAlignment = "center";
link_32_ui.HighlightBackground = "off";

link_33_ui = AppUtil1.Component.Hyperlink(NewRowGrid(row_layout));  % !test-target
link_33_ui.MainFigure = main_figure;
link_33_ui.Text = "Testing" + newline + "hyperlink component";
link_33_ui.ComponentHeight = common_height;
link_33_ui.VerticalAlignment = "bottom";
link_33_ui.HorizontalAlignment = "right";
link_33_ui.HighlightBackground = "on";

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App.Window.MainFigure = main_figure;
end  % if
end  % function
