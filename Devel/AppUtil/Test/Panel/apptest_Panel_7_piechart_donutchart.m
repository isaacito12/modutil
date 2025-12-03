function App = apptest_Panel_7_piechart_donutchart
% piechart and donutchart in Panel

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 400;  % height

main_column_layout = AppUtil1.ColumnLayout(main_figure);

build_gui(main_column_layout);

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

function build_gui(column_layout)
%%
arguments (Input)
  column_layout (1,1) AppUtil1.ColumnLayout
end  % arguments

common_height = 190;

% -----------------------------------------------------------------------------
column_grid = NewColumnGrid(column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

graphics_panel_ui_1 = AppUtil1.Graphics.Panel(NewRowGrid(row_layout));  % !test-target
graphics_panel_ui_1.ComponentHeight = common_height;
p = piechart(graphics_panel_ui_1.MainPanel, [1 2 3 4]);  % !test-target
title(p, "Pie in panel 1")

graphics_panel_ui_2 = AppUtil1.Graphics.Panel(NewRowGrid(row_layout));  % !test-target
graphics_panel_ui_2.ComponentHeight = common_height;
p = donutchart(graphics_panel_ui_2.MainPanel, [10 3 1 5 6 4]);  % !test-target
title(p, "Donut in panel 2")

% -----------------------------------------------------------------------------
column_grid = NewColumnGrid(column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

% charts in tiledlayout

graphics_panel_ui_3 = AppUtil1.Graphics.Panel(NewRowGrid(row_layout));  % !test-target
graphics_panel_ui_3.ComponentHeight = common_height;

tile = tiledlayout(graphics_panel_ui_3.MainPanel, 1, 2);

nexttile(tile)
p = piechart(tile, [1 2 3 4]);  % !test-target
title(p, "Pie in tile in panel 3")

nexttile(tile)
p = donutchart(tile, [10 3 1 5 6 4]);  % !test-target
title(p, "Donut in tile in panel 3")

end  % function
