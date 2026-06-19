function App = apptest_Label_2_inner_align
% Test the horizontal and vertical position of the main component within the component.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

common_height = AppUtil1.Constant.Height{"oneline++"}*3;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 700;  % width
main_figure.Position(4) = 300;  % height

main_vertical_container = AppUtil1.VerticalContainer(main_figure);

%%
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "left";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "center";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "right";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "on";

%%
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "left";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "center";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "right";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "off";

%%
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "left";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "center";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "right";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "on";

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
end % if
end  % function
