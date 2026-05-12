function App = apptest_Panel_4_heatmap_in_tiledlayout

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 400;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "dark";
end  % if

main_v_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------

build_gui(main_v_container)

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function

function build_gui(v_container)
%%
arguments (Input)
  v_container (1,1) AppUtil1.VerticalContainer
end  % arguments

v_layout = addVerticalGridLayout(v_container);
panel_ui = AppUtil1.Graphics.Panel(v_layout);  % !test-target
panel_ui.ComponentHeight = 390;

main_panel = panel_ui.MainPanel;

tile = tiledlayout(main_panel, 2, 1, TileSpacing="compact");  % !test-target

nexttile(tile)

% heatmap's parent is tiledlayout, not nexttile.
heatmap(tile, magic(10))

nexttile(tile)

heatmap(tile, magic(8), Colormap=sky(2))

end  % function
