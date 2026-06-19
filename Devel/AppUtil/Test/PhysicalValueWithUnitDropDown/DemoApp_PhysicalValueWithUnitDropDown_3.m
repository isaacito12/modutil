function App = DemoApp_PhysicalValueWithUnitDropDown_3

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

<<<<<<< HEAD
main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "dark";
end  % if

v_container = AppUtil1.VerticalContainer(main_figure);
=======
main_fig = uifigure(Visible="off");
main_fig.Name = "Test";
main_fig.Position(3) = 640;  % width
main_fig.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_fig.Theme = "dark";
end  % if

v_container = AppUtil1.VerticalContainer(main_fig);
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3

% -----------------------------------------------------------------------------
% !test-target

v_layout = addVerticalGridLayout(v_container);

physval_ui_1 = AppUtil1.Component.PhysicalValueWithUnitDropDown(v_layout);
physval_ui_1.NameText = "Parameter 1";
physval_ui_1.UnitItems = ["s", "min"];
physval_ui_1.UnitChangedCallback = @() disp("Parameter 1: Unit changed: " + physval_ui_1.UnitText);

% -----------------------------------------------------------------------------
% !test-target

v_layout = addVerticalGridLayout(v_container);

physval_ui_2 = AppUtil1.Component.PhysicalValueWithUnitDropDown(v_layout);
physval_ui_2.NameText = "Parameter 2";
physval_ui_2.UnitItems = ["m/s", "km/min"];
physval_ui_2.UnitChangedCallback = @() disp("Parameter 2: Unit changed: " + physval_ui_2.UnitText);

% -----------------------------------------------------------------------------
physval_ui_1.ValueText = "2";
physval_ui_2.ValueText = "-pi";

% -----------------------------------------------------------------------------
<<<<<<< HEAD
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
=======
movegui(main_fig, "center")
main_fig.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_fig;
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
  App.PhysicalValueWithUnitDropDown_1 = physval_ui_1;
  App.PhysicalValueWithUnitDropDown_2 = physval_ui_2;
end  % if
end  % function
