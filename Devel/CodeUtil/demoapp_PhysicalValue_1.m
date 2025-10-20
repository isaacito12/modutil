function App = demoapp_PhysicalValue_1

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

pvalue_1 = CodeUtil1.PhysicalValue(UnitText="rev/s");  % !test-target

width_left_label = 140;

app_window = AppUtil1.AppUtilWindow(SourceFilename=mfilename);
app_window.Width = 540;
app_window.Height = 230;
app_window.Name = "PhysicalValue demo";

main_layout = app_window.MainLayout;

app_area = NewArea(main_layout);
app_column = NewColumn(main_layout, app_area);

% =============================================================================
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row, Width="fit"));
label_ui.Text = join([
  "Enter a value of type double or simscape.Value."
  "The value can be a scalar, a vector, a matrix, or any MATLAB expression"
  "as long as it evaluates to the expected data type."
  "The value can also use base workspace variables."
  ], " ");
label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*3;
label_ui.WordWrap = "on";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

editfield_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
editfield_ui.ValueChangedCallback = @() react_EditField_ValueChanged();

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row, Width="fit"));
label_ui.Text = "Errors are reported in the Command Window.";

% =============================================================================
app_row = NewRow(main_layout, app_column);
AppUtil1.Component.HorizontalLine(app_row);

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row, Width="fit"));
label_ui.Text = "Value";
label_ui.ComponentWidth = width_left_label;

value_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
value_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row, Width="fit"));
label_ui.Text = "Unit";
label_ui.ComponentWidth = width_left_label;

unit_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
unit_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

button_ui = AppUtil1.Component.Button(NewSlot(main_layout, app_row));
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
Show(app_window)

drawnow
app_window.MainFigure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window = app_window;
end  % if
end  % function
