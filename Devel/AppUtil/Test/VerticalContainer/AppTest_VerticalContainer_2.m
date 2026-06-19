function App = AppTest_VerticalContainer_2

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct
end  % arguments

common_height = AppUtil1.Constant.Height{"oneline++"}*2;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 320;  % height

v_container = AppUtil1.VerticalContainer(main_figure);  % !test-target

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(v_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 1";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(v_container));
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "top";
label_ui.Text = "Test 2";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(v_container));
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "center";
label_ui.Text = "Test 3";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(v_container));
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "bottom";
label_ui.Text = "Test 4";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(v_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 5";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(v_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 6";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(v_container, Height=common_height));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 7. Height is specified in the grid. Label height is the default height, oneline++.";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(v_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 8";
label_ui.HighlightBackground = "on";

%%
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
end  % if
end  % function
