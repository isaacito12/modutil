function App = apptest_MixedLayout_2_column_major
% Create a row grid and add UI components column by column, which
% is the column-major placement of components.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

left_text_width = 140;
right_text_width = 100;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 320;  % height

main_horizontal_container = AppUtil1.HorizontalContainer(main_figure);  % !test-target

% -----------------------------------------------------------------------------
vertical_container = AppUtil1.VerticalContainer(addHorizontalGridLayout(main_horizontal_container, Width=left_text_width));  % !test-target

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 1";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 2";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 3";
label_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
vertical_container = AppUtil1.VerticalContainer(addHorizontalGridLayout(main_horizontal_container));  % !test-target

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.HorizontalAlignment = "center";
label_ui.Text = "Test 4";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.HorizontalAlignment = "left";
label_ui.Text = "Test 5";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.HorizontalAlignment = "right";
label_ui.Text = "Test 6";
label_ui.HighlightBackground = "off";

% -----------------------------------------------------------------------------
vertical_container = AppUtil1.VerticalContainer(addHorizontalGridLayout(main_horizontal_container, Width=right_text_width));  % !test-target

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 7";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test 8";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
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
