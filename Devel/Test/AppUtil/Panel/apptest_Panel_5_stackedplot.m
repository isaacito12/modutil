function App = apptest_Panel_5_stackedplot

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
panel_ui.ComponentHeight = 390;

main_panel = panel_ui.MainPanel;

X = (0 : 1 : 10)';

% Generate 11-by-3 random integers between 1 and 100.
Y = randi(100, numel(X), 3);

stackedplot(main_panel, X, Y);  % !test-target

end  % function
