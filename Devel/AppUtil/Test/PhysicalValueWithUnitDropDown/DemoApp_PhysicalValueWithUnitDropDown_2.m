function App = DemoApp_PhysicalValueWithUnitDropDown_2

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_fig = uifigure(Visible="off");
main_fig.Name = "Test";
main_fig.Position(3) = 640;  % width
main_fig.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_fig.Theme = "light";
end  % if

h_container = AppUtil1.HorizontalContainer(main_fig);

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
movegui(main_fig, "center")
main_fig.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_fig;
  App.PhysicalValueWithUnitDropDown_1 = physval_ui_1;
end  % if
end  % function
