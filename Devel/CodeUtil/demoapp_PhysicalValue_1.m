function App = demoapp_PhysicalValue_1

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

pvalue_1 = CodeUtil1.PhysicalValue(UnitText="rev/s");  % !test-target

width_left_label = 140;

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 540;
app_window.Height = 230;
app_window.Name = CodeUtil1.i18n("PhysicalValue demo");

main_vertical_container = app_window.MainVerticalContainer;

% =============================================================================
column_grid = addVerticalGridLayout(main_vertical_container, Height="fit");

label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = join([
  "Enter a value of type double or simscape.Value."
  "The value can be a scalar, a vector, a matrix, or any MATLAB expression"
  "as long as it evaluates to the expected data type."
  "The value can also use base workspace variables."
  ], " ");
label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*3;
label_ui.WordWrap = "on";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);

editfield_ui = AppUtil1.Component.EditField(column_grid);
editfield_ui.ValueChangedCallback = @() react_EditField_ValueChanged();

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container, Height="fit");

label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = "Errors are reported in the Command Window.";

% =============================================================================
column_grid = addVerticalGridLayout(main_vertical_container);
AppUtil1.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container, Height="fit");
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Value";
label_ui.ComponentWidth = width_left_label;

row_grid = addHorizontalGridLayout(horizontal_container);
value_ui = AppUtil1.Component.EditField(row_grid);
value_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container, Height="fit");
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Unit";
label_ui.ComponentWidth = width_left_label;

row_grid = addHorizontalGridLayout(horizontal_container);
unit_ui = AppUtil1.Component.EditField(row_grid);
unit_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);

button_ui = AppUtil1.Component.Button(column_grid);
button_ui.ButtonWidth = 100;
button_ui.HorizontalAlignment = "center";
button_ui.Text = "Refresh";
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

%%

  function react_EditField_ValueChanged()
    pvalue_1.ValueText = editfield_ui.Value;
    sv = pvalue_1.SimscapeValue;
    unit_ui.Value = unit(sv);
    % The value function for a simscape.Value object can return a scalar, a vector, or a matrix.
    value_ui.Value = CodeUtil1.stringify(value(sv));
  end  % nested function

  function react_ButtonPushed()
    react_EditField_ValueChanged()
  end  % nested function

%%

editfield_ui.Value = "simscape.Value([10, 5000], ""rpm"")";

react_EditField_ValueChanged()

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
end  % if
end  % function
