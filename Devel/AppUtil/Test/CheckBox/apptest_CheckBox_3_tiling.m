function App = apptest_CheckBox_3_tiling

% Tile the same components.
% Visually inspect the spacing among them.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

main_figure.Position(3) = 900;  % width
main_figure.Position(4) = 300;  % height

app_horizontal_container = AppUtil1.HorizontalContainer(main_figure);

left_grid = addHorizontalGridLayout(app_horizontal_container);
build_ui(main_figure, left_grid, [1 0 1])
build_ui(main_figure, left_grid, [0 1 0])
build_ui(main_figure, left_grid, [1 0 1])

right_grid = addHorizontalGridLayout(app_horizontal_container);
build_ui(main_figure, right_grid, [0 1 0])
build_ui(main_figure, right_grid, [1 0 1])
build_ui(main_figure, right_grid, [0 1 0])

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

function build_ui(main_figure, grid_layout, hilit)
%%
vertical_container = AppUtil1.VerticalContainer(grid_layout);
for column_count = 1 : 3
  column_grid = addVerticalGridLayout(vertical_container);  
  horizontal_container = AppUtil1.HorizontalContainer(column_grid);

  % left
  ui_1 = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container, width=160));  % #test-target
  ui_1.MainFigure = main_figure;
  ui_1.HighlightBackground = hilit(1);

  % center
  ui_2 = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container, Width="1x"));  % #test-target
  ui_2.MainFigure = main_figure;
  ui_2.HighlightBackground = hilit(2);

  % right
  ui_3 = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container, Width="2x"));  % #test-target
  ui_3.MainFigure = main_figure;
  ui_3.HighlightBackground = hilit(3);
end  % for
end  % function
