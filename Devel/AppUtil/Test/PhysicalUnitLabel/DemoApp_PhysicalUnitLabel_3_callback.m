function App = DemoApp_PhysicalUnitLabel_3_callback

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 300;  % height

v_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------

v_layout = addVerticalGridLayout(v_container);
unit_ui_1 = AppUtil1.Component.PhysicalUnitLabel(v_layout);
unit_ui_1.UnitText = "m";
unit_ui_1.UnitLabelChangedCallback = @() react_UnitLabelChanged(unit_ui_1);
unit_ui_1.HighlightBackground = "off";

v_layout = addVerticalGridLayout(v_container);
unit_ui_2 = AppUtil1.Component.PhysicalUnitLabel(v_layout);
unit_ui_2.UnitText = "s";
unit_ui_2.UnitLabelChangedCallback = @() react_UnitLabelChanged(unit_ui_2);
unit_ui_2.HighlightBackground = "on";

  function react_UnitLabelChanged(UnitUI)

    st = dbstack("-completenames", 1);
    % Get the object name, e.g., "unit_ui_1", from st.

    x = string({st.name});
    % x(1) looks like "@()react_UnitLabelChanged(unit_ui_1)".
    x = x(1);
    x = extractAfter(x, "react_UnitLabelChanged");
    x = extractBetween(x, "(", ")");

    disp("UnitLabelChangedCallback:" + x + ":" + UnitUI.UnitText)

  end  % nested function

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.PhysicalUnitLabel_1 = unit_ui_1;
  App.PhysicalUnitLabel_2 = unit_ui_2;
end  % if
end  % function
