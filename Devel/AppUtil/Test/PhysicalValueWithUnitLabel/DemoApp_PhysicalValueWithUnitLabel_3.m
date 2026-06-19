function App = DemoApp_PhysicalValueWithUnitLabel_3

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "dark";
end  % if

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
physval_ui_1.ValueChangedCallback = @() callback1();
physval_ui_1.HighlightBackground = "off";

% Another way to specify UnitText using the name-value argument style option.
% Name-value argument style and property assignment style can be mixed
% The way they work is the same.
% Note that the name-value argument style is not a constructor argument.
v_layout = addVerticalGridLayout(v_container);
physval_ui_2 = AppUtil1.Component.PhysicalValueWithUnitLabel(v_layout, UnitText="N");
physval_ui_2.NameText = "Parameter 2";
physval_ui_2.ValueChangedCallback = @() callback1();
physval_ui_2.HighlightBackground = "on";

% Specify UnitAlias.
% It implicitly defines the internal unit to be "1".
v_layout = addVerticalGridLayout(v_container);
physval_ui_3 = AppUtil1.Component.PhysicalValueWithUnitLabel(v_layout);
physval_ui_3.NameText = "Parameter 3";
physval_ui_3.UnitAlias = "\%";  % Use back-slash escaping for the latex interpreter.
physval_ui_3.ValueChangedCallback = @() callback1();
physval_ui_3.HighlightBackground = "off";

% Make the unit text empty in the unit UI by setting UnitAlias to "".
% The internal unit is "1".
% Make the value text read-only.
v_layout = addVerticalGridLayout(v_container);
physval_ui_4 = AppUtil1.Component.PhysicalValueWithUnitLabel(v_layout);
physval_ui_4.NameText = "Parameter 4";
physval_ui_4.UnitAlias = "";
physval_ui_4.ReadOnlyValueText = true;
physval_ui_4.HighlightBackground = "on";

  function callback1
    try
      % Return value can be empty/invalid for calculation.
      L1 = value(physval_ui_1.SimscapeValue);
      F2 = value(physval_ui_2.SimscapeValue);
      pct = value(physval_ui_3.SimscapeValue);
    catch exception
      physval_ui_4.ValueText = "";

      return

    end  % try, catch
    x = pct * F2 * L1;
    physval_ui_4.ValueText = x;
  end  % nested function

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.PhysicalValueWithUnitLabel_1 = physval_ui_1;
  App.PhysicalValueWithUnitLabel_2 = physval_ui_2;
  App.PhysicalValueWithUnitLabel_3 = physval_ui_3;
  App.PhysicalValueWithUnitLabel_4 = physval_ui_4;
end  % if
end  % function
