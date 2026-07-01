function App = apptest_Panel_6_parallelplot

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 800;  % width
main_figure.Position(4) = 400;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

main_v_container = mus1.AppUtil.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------

build_gui(main_v_container)

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

v_layout = addVerticalGridLayout(v_container);
panel_ui = mus1.AppUtil.Graphics.Panel(v_layout);  % !test-target
panel_ui.ComponentHeight = 380;

main_panel = panel_ui.MainPanel;

% Generate 3-by-5 random integers between 1 and 100.
Y = randi(100, 3, 5);

parallelplot(main_panel, Y);  % !test-target

end  % function
