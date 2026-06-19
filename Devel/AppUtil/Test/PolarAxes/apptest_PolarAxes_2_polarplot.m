function App = apptest_PolarAxes_2_polarplot

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 400;  % width
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
  App.MainFigure = main_figure;
end  % if
end  % function

function build_gui(v_container)
%%
arguments (Input)
  v_container (1,1) AppUtil1.VerticalContainer
end  % arguments

v_layout = addVerticalGridLayout(v_container);
pax_ui = AppUtil1.Graphics.PolarAxes(v_layout);  % !test-target
pax_ui.ComponentHeight = 390;  % !test-target
pax_ui.HighlightBackground = "on";

main_polar_axes = pax_ui.MainPolarAxes;

theta = linspace(0, 360, 50);
rho = 0.005 * theta / 10;
theta_radians = deg2rad(theta);

polarplot(main_polar_axes, theta_radians, rho)  % !test-target

end  % function
