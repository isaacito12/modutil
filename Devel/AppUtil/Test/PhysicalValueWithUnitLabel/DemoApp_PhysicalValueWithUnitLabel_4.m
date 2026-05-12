function App = DemoApp_PhysicalValueWithUnitLabel_4

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 300;  % height

v_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
% !test-target

% Specify UnitText (and NameText).
% This is the intended way of building this component.
% Leave ValueText unspecified here, and specify it in a place which is more appropriate.
v_layout = addVerticalGridLayout(v_container);
physval_ui_1 = AppUtil1.Component.PhysicalValueWithUnitLabel(v_layout);
physval_ui_1.NameText = "Parameter 1";
physval_ui_1.UnitText = "m";

% Another way to specify UnitText using the name-value argument style option.
% Name-value argument style and property assignment style can be mixed.
% The way they work is the same.
% Note that the name-value argument style is not a constructor argument.
v_layout = addVerticalGridLayout(v_container);
physval_ui_2 = AppUtil1.Component.PhysicalValueWithUnitLabel(v_layout, UnitText="N");
physval_ui_2.NameText = "Parameter 2";

% -----------------------------------------------------------------------------
% Default values
physval_ui_1.ValueText = "1.2";
physval_ui_2.ValueText = "3 : 2 : 7";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.PhysicalValueWithUnitLabel_1 = physval_ui_1;
  App.PhysicalValueWithUnitLabel_2 = physval_ui_2;
end  % if
end  % function
