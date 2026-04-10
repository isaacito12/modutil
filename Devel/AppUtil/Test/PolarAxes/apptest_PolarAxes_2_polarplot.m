function App = apptest_PolarAxes_2_polarplot
% polarplot in PolarAxes

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 400;  % width
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

pax_ui = AppUtil1.Graphics.PolarAxes(addVerticalGridLayout(vertical_container));  % !test-target
pax_ui.ComponentHeight = 390;  % !test-target

main_polar_axes = pax_ui.MainPloarAxes;

theta = linspace(0, 360, 50);
rho = 0.005 * theta / 10;
theta_radians = deg2rad(theta);

polarplot(main_polar_axes, theta_radians, rho)  % !test-target

end  % function
