function App = apptest_Button_4_tiling
% Test the spacing among the same components.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 480;  % width
main_figure.Position(4) = 110;  % height

app_vertical_container = mus1.AppUtil.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(app_vertical_container);
horizontal_container = mus1.AppUtil.HorizontalContainer(column_grid);
% left
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "1";
button_ui.HighlightBackground = "on";
% center
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "2";
button_ui.HighlightBackground = "off";
% right
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "3";
button_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(app_vertical_container);
horizontal_container = mus1.AppUtil.HorizontalContainer(column_grid);
% left
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "4";
button_ui.HighlightBackground = "on";
% center
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "5";
button_ui.HighlightBackground = "off";
% right
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "6";
button_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(app_vertical_container);
horizontal_container = mus1.AppUtil.HorizontalContainer(column_grid);
% left
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "7";
button_ui.HighlightBackground = "off";
% center
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "8";
button_ui.HighlightBackground = "on";
% right
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "9";
button_ui.HighlightBackground = "off";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(app_vertical_container);
horizontal_container = mus1.AppUtil.HorizontalContainer(column_grid);
% left
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "10";
button_ui.HighlightBackground = "off";
% center
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "11";
button_ui.HighlightBackground = "on";
% right
button_ui = mus1.AppUtil.Component.Button(addHorizontalGridLayout(horizontal_container, Width=160));  % !test-target
button_ui.MainFigure = main_figure;
button_ui.Text = "12";
button_ui.HighlightBackground = "off";

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
