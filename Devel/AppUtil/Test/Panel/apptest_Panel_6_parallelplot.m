function App = Panel_testapp_6_parallelplot
% parallelplot in Panel

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 800;  % width
main_figure.Position(4) = 400;  % height

main_layout = AppUtil1.AppUtilLayout(main_figure);

build_gui(main_layout)

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function

function build_gui(app_layout)
%%
arguments (Input)
  app_layout (1,1) AppUtil1.AppUtilLayout
end  % arguments

panel_ui = AppUtil1.Graphics.Panel(NewArea(app_layout));  % !test-target
panel_ui.ComponentHeight = 380;

main_panel = panel_ui.MainPanel;

% Generate 3-by-5 random integers between 1 and 100.
Y = randi(100, 3, 5);

parallelplot(main_panel, Y);  % !test-target

end  % function
