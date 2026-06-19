function App = DemoApp_PhysicalValue_1_workspace

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 500;
app_window.Height = 240;
app_window.Name = "PhysicalValue Demo 1";

main_v_container = app_window.MainVerticalContainer;

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);

label_ui = AppUtil1.Component.Label(v_layout);
label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*5;
label_ui.WordWrap = "on";
label_ui.Text = "This app shows interaction between an edit field UI and" ...
  + " a workspace variable using a PhysicalValue object." ...
  + newline ...
  + "Enter text which can be a (scalar/vector/matrix) value of type double or simscape.Value," ...
  + " or an expression which evaluates to those types." ...
  + " The text can contain base workspace variables.";

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);

editfield_ui = AppUtil1.Component.EditField(v_layout);
editfield_ui.ValueChangedCallback = @() react_EditField_ValueChanged();

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);
button_ui = AppUtil1.Component.Button(v_layout);
button_ui.ButtonWidth = 100;
button_ui.HorizontalAlignment = "center";
button_ui.Text = "Refresh";
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);
horizontal_container = AppUtil1.HorizontalContainer(v_layout);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Value";
label_ui.ComponentWidth = 70;

row_grid = addHorizontalGridLayout(horizontal_container);
value_ui = AppUtil1.Component.EditField(row_grid);
value_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);
horizontal_container = AppUtil1.HorizontalContainer(v_layout);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Unit";
label_ui.ComponentWidth = 70;

row_grid = addHorizontalGridLayout(horizontal_container);
unit_ui = AppUtil1.Component.EditField(row_grid);
unit_ui.ReadOnly = "on";

  function react_EditField_ValueChanged
    physical_value_1 = CodeUtil1.PhysicalValue;  % Create a new object.
    try
      physical_value_1.ValueText = editfield_ui.Value;
    catch exception
      uialert(main_figure, exception.message, "Error")

      return

    end  % try, catch
    sscval = physical_value_1.SimscapeValue;
    unit_ui.Value = unit(sscval);
    % The value function for a simscape.Value object can return a scalar, a vector, or a matrix.
    value_ui.Value = CodeUtil1.stringify(value(sscval));
  end  % nested function

  function react_ButtonPushed
    react_EditField_ValueChanged
  end  % nested function

%%
editfield_ui.Value = "simscape.Value([1 2 3], ""m"").^2";

react_EditField_ValueChanged

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
  App.EditFieldUI = editfield_ui;
  App.RefreshButtonUI = button_ui;
  App.ValueUI = value_ui;
  App.UnitUI = unit_ui;
end  % if
end  % function
