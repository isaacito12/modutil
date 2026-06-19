function App = DemoApp_PhysicalValueWithUnitDropDown_2

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

h_container = AppUtil1.HorizontalContainer(main_figure);

% -----------------------------------------------------------------------------
% !test-target

h_layout = addHorizontalGridLayout(h_container);

physval_ui_1 = AppUtil1.Component.PhysicalValueWithUnitDropDown(h_layout);
physval_ui_1.NameText = "Parameter 1";
physval_ui_1.UnitItems = ["s", "min"];

% -----------------------------------------------------------------------------
physval_ui_1.UnitText = "min";
physval_ui_1.ValueText = "2";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.PhysicalValueWithUnitDropDown_1 = physval_ui_1;
end  % if
end  % function
