function App = DemoApp_PhysicalValueWithUnitLabel_2

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

v_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
% !test-target

v_layout = addVerticalGridLayout(v_container);
% Specify UnitText (and NameText).
% This is the intended way of building this component.
physval_ui_1 = AppUtil1.Component.PhysicalValueWithUnitLabel(v_layout);
physval_ui_1.NameText = "Parameter 1";
physval_ui_1.UnitText = "m";
physval_ui_1.ValueChangedCallback = @() callback1();

default_text = "(simscape.Value of Parameter 1 to be displayed by callback.)";

v_layout = addVerticalGridLayout(v_container);
label_ui_1 = AppUtil1.Component.Label(v_layout);
label_ui_1.Text = default_text;

  function callback1
    t = CodeUtil1.stringify(physval_ui_1.SimscapeValue);
    if t == ""
      label_ui_1.Text = default_text;
    else
      label_ui_1.Text = t;
    end  % if
  end  % nested function

% -----------------------------------------------------------------------------

% Specify ValueText, 1) after finished building the app, and 2) before making
% the app window visible.
physval_ui_1.ValueText = "1.2";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.PhysicalValueWithUnitLabel_1 = physval_ui_1;
end  % if
end  % function
