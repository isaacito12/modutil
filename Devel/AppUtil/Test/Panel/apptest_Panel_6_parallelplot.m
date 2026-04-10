function App = apptest_Panel_6_parallelplot
% parallelplot in Panel

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 800;  % width
main_figure.Position(4) = 400;  % height

main_vertical_container = AppUtil1.VerticalContainer(main_figure);

build_gui(main_vertical_container)

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

function build_gui(vertical_container)
%%
arguments (Input)
  vertical_container (1,1) AppUtil1.VerticalContainer
end  % arguments

panel_ui = AppUtil1.Graphics.Panel(addVerticalGridLayout(vertical_container));  % !test-target
panel_ui.ComponentHeight = 380;

main_panel = panel_ui.MainPanel;

% Generate 3-by-5 random integers between 1 and 100.
Y = randi(100, 3, 5);

parallelplot(main_panel, Y);  % !test-target

end  % function
