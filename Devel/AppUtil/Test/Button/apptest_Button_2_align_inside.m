function App = apptest_Button_2_align_inside
% Test the alignment/positioning of the main component within the component.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

common_height = AppUtil1.Constant.Height{"oneline++"}*3;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 660;  % width
main_figure.Position(4) = 260;  % height

app_vertical_container = AppUtil1.VerticalContainer(main_figure);

%%
column_grid = addVerticalGridLayout(app_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

button_11_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));  % !test-target
button_11_ui.MainFigure = main_figure;
button_11_ui.ComponentHeight = common_height;
button_11_ui.VerticalAlignment = "top";
button_11_ui.HorizontalAlignment = "left";
button_11_ui.HighlightBackground = "on";

button_12_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));  % !test-target
button_12_ui.MainFigure = main_figure;
button_12_ui.ComponentHeight = common_height;
button_12_ui.VerticalAlignment = "top";
button_12_ui.HorizontalAlignment = "center";
button_12_ui.HighlightBackground = "off";

button_13_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));  % !test-target
button_13_ui.MainFigure = main_figure;
button_13_ui.ComponentHeight = common_height;
button_13_ui.VerticalAlignment = "top";
button_13_ui.HorizontalAlignment = "right";
button_13_ui.HighlightBackground = "on";

%%
column_grid = addVerticalGridLayout(app_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

button_21_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));  % !test-target
button_21_ui.MainFigure = main_figure;
button_21_ui.ComponentHeight = common_height;
button_21_ui.VerticalAlignment = "center";
button_21_ui.HorizontalAlignment = "left";
button_21_ui.HighlightBackground = "off";

button_22_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));  % !test-target
button_22_ui.MainFigure = main_figure;
button_22_ui.ComponentHeight = common_height;
button_22_ui.VerticalAlignment = "center";
button_22_ui.HorizontalAlignment = "center";
button_22_ui.HighlightBackground = "on";

button_23_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));  % !test-target
button_23_ui.MainFigure = main_figure;
button_23_ui.ComponentHeight = common_height;
button_23_ui.VerticalAlignment = "center";
button_23_ui.HorizontalAlignment = "right";
button_23_ui.HighlightBackground = "off";

%%
column_grid = addVerticalGridLayout(app_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

button_31_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));  % !test-target
button_31_ui.MainFigure = main_figure;
button_31_ui.ComponentHeight = common_height;
button_31_ui.VerticalAlignment = "bottom";
button_31_ui.HorizontalAlignment = "left";
button_31_ui.HighlightBackground = "on";

button_32_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));  % !test-target
button_32_ui.MainFigure = main_figure;
button_32_ui.ComponentHeight = common_height;
button_32_ui.VerticalAlignment = "bottom";
button_32_ui.HorizontalAlignment = "center";
button_32_ui.HighlightBackground = "off";

button_33_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));  % !test-target
button_33_ui.MainFigure = main_figure;
button_33_ui.ComponentHeight = common_height;
button_33_ui.VerticalAlignment = "bottom";
button_33_ui.HorizontalAlignment = "right";
button_33_ui.HighlightBackground = "on";

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
end  % if
end  % function
