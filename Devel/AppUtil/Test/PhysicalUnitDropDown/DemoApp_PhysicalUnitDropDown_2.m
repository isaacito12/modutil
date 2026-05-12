function App = DemoApp_PhysicalUnitDropDown_2

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

main_v_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
% !test-target
% Just create a component with all defaults.

v_layout = addVerticalGridLayout(main_v_container);

dropdown_1 = AppUtil1.Component.PhysicalUnitDropDown(v_layout);
dropdown_1.UnitItems = ["m/s", "mph"];
dropdown_1.UnitChangedCallback = @() callback1();

% (optional) Highlight the background of the component to see the area which the component occupies.
% dropdown_1.HighlightBackground = "on";

  function callback1
    disp("Selected: " + dropdown_1.UnitText)
  end  % function

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.PhysicalUnitDropDown_1 = dropdown_1;
end  % if
end  % function
