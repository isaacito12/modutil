function App = apptest_CheckBox_2_align_inside

% Test alignment within the component:
% - VerticalAlignment
% - HorizontalAlignment

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 760;  % width
main_figure.Position(4) = 300;  % height

app_vertical_container = AppUtil1.VerticalContainer(main_figure);

column_grid = addVerticalGridLayout(app_vertical_container);
build_ui(main_figure, column_grid, "top",    [1 0 1])

column_grid = addVerticalGridLayout(app_vertical_container);
build_ui(main_figure, column_grid, "center", [0 1 0])

column_grid = addVerticalGridLayout(app_vertical_container);
build_ui(main_figure, column_grid, "bottom", [1 0 1])

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

function build_ui(main_figure, grid_layout, vert, hilit)
%%
horizontal_container = AppUtil1.HorizontalContainer(grid_layout);

cb = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container));  % !test-target
cb.MainFigure = main_figure;
cb.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*4;
cb.VerticalAlignment = vert;
cb.HorizontalAlignment = "left";
cb.ValueChangedCallback = @() disp(cb.Text);
cb.Text = ...
  "VerticalAlignment: " + cb.VerticalAlignment + newline + ...
  "HorizontalAlignment: " + cb.HorizontalAlignment;
cb.HighlightBackground = hilit(1);

cb = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container));  % !test-target
cb.MainFigure = main_figure;
cb.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*4;
cb.VerticalAlignment = vert;
cb.HorizontalAlignment = "center";
cb.ValueChangedCallback = @() disp(cb.Text);
cb.Text = ...
  "VerticalAlignment: " + cb.VerticalAlignment + newline + ...
  "HorizontalAlignment: " + cb.HorizontalAlignment;
cb.HighlightBackground = hilit(2);

cb = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container));  % !test-target
cb.MainFigure = main_figure;
cb.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*4;
cb.VerticalAlignment = vert;
cb.HorizontalAlignment = "right";
cb.ValueChangedCallback = @() disp(cb.Text);
cb.Text = ...
  "VerticalAlignment: " + cb.VerticalAlignment + newline + ...
  "HorizontalAlignment: " + cb.HorizontalAlignment;
cb.HighlightBackground = hilit(3);

end  % function
