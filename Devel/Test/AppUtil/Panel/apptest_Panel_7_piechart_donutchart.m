function App = apptest_Panel_7_piechart_donutchart

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 400;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

main_v_container = mus1.AppUtil.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------

build_gui(main_v_container);

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
end  % if
end  % function

function build_gui(v_container)
%%
arguments (Input)
  v_container (1,1) mus1.AppUtil.VerticalContainer
end  % arguments

common_height = 190;

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(v_container);
horizontal_container = mus1.AppUtil.HorizontalContainer(column_grid);

v_layout = addHorizontalGridLayout(horizontal_container);
graphics_panel_ui_1 = mus1.AppUtil.Graphics.Panel(v_layout);  % !test-target
graphics_panel_ui_1.ComponentHeight = common_height;
graphics_panel_ui_1.HighlightBackground = "on";
p = piechart(graphics_panel_ui_1.MainPanel, [1 2 3 4]);  % !test-target
title(p, "Pie in panel 1")

v_layout = addHorizontalGridLayout(horizontal_container);
graphics_panel_ui_2 = mus1.AppUtil.Graphics.Panel(v_layout);  % !test-target
graphics_panel_ui_2.ComponentHeight = common_height;
graphics_panel_ui_2.HighlightBackground = "off";
p = donutchart(graphics_panel_ui_2.MainPanel, [10 3 1 5 6 4]);  % !test-target
title(p, "Donut in panel 2")

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(v_container);
horizontal_container = mus1.AppUtil.HorizontalContainer(column_grid);

% charts in tiledlayout

v_layout = addHorizontalGridLayout(horizontal_container);
graphics_panel_ui_3 = mus1.AppUtil.Graphics.Panel(v_layout);  % !test-target
graphics_panel_ui_3.ComponentHeight = common_height;

tile = tiledlayout(graphics_panel_ui_3.MainPanel, 1, 2);

nexttile(tile)
p = piechart(tile, [1 2 3 4]);  % !test-target
title(p, "Pie in tile in panel 3")

nexttile(tile)
p = donutchart(tile, [10 3 1 5 6 4]);  % !test-target
title(p, "Donut in tile in panel 3")

end  % function
