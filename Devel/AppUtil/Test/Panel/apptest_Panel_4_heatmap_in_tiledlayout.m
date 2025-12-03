function App = apptest_Panel_4_heatmap_in_tiledlayout
% heatmap in tiledlayout in Panel

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 400;  % height

main_column_layout = AppUtil1.ColumnLayout(main_figure);

build_gui(main_column_layout)

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

panel_ui = AppUtil1.Graphics.Panel(NewColumnGrid(column_layout));  % !test-target
panel_ui.ComponentHeight = 390;

main_panel = panel_ui.MainPanel;

tile = tiledlayout(main_panel, 2, 1, TileSpacing="compact");  % !test-target

nexttile(tile)

% heatmap's parent is tiledlayout, not nexttile.
heatmap(tile, magic(10))

nexttile(tile)

heatmap(tile, magic(8), Colormap=sky(2))

end  % function
