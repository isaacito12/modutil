function App = DemoApp_PhysicalUnitLabel_3_callback

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
<<<<<<< HEAD
main_figure.Name = "Test";
=======
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 300;  % height

v_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------

v_layout = addVerticalGridLayout(v_container);
unit_ui_1 = AppUtil1.Component.PhysicalUnitLabel(v_layout);
unit_ui_1.UnitText = "m";
<<<<<<< HEAD
unit_ui_1.UnitChangedCallback = @() react_UnitLabelChanged(unit_ui_1);
=======
unit_ui_1.UnitLabelChangedCallback = @() react_UnitLabelChanged(unit_ui_1);
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
unit_ui_1.HighlightBackground = "off";

v_layout = addVerticalGridLayout(v_container);
unit_ui_2 = AppUtil1.Component.PhysicalUnitLabel(v_layout);
unit_ui_2.UnitText = "s";
<<<<<<< HEAD
unit_ui_2.UnitChangedCallback = @() react_UnitLabelChanged(unit_ui_2);
=======
unit_ui_2.UnitLabelChangedCallback = @() react_UnitLabelChanged(unit_ui_2);
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
unit_ui_2.HighlightBackground = "on";

  function react_UnitLabelChanged(UnitUI)

    st = dbstack("-completenames", 1);
    % Get the object name, e.g., "unit_ui_1", from st.

    x = string({st.name});
    % x(1) looks like "@()react_UnitLabelChanged(unit_ui_1)".
    x = x(1);
    x = extractAfter(x, "react_UnitLabelChanged");
    x = extractBetween(x, "(", ")");

<<<<<<< HEAD
    disp("UnitChangedCallback:" + x + ":" + UnitUI.UnitText)
=======
    disp("UnitLabelChangedCallback:" + x + ":" + UnitUI.UnitText)
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3

  end  % nested function

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
<<<<<<< HEAD
  App.MainFigure = main_figure;
=======
  App.Window.MainFigure = main_figure;
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
  App.PhysicalUnitLabel_1 = unit_ui_1;
  App.PhysicalUnitLabel_2 = unit_ui_2;
end  % if
end  % function
