function App = apptest_Panel_5_stackedplot
% stackedplot in Panel

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
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
panel_ui.ComponentHeight = 390;

main_panel = panel_ui.MainPanel;

X = (0 : 1 : 10)';

% Generate 11-by-3 random integers between 1 and 100.
Y = randi(100, numel(X), 3);

stackedplot(main_panel, X, Y);  % !test-target

end  % function
