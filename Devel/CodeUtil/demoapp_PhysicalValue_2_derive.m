function App = demoapp_PhysicalValue_2_derive

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

% Editable parameters
physval_length = CodeUtil1.PhysicalValue(UnitText="m");  % !test-target

% Derived (read-only) parameters
physval_area = CodeUtil1.PhysicalValue(UnitText="m^2");  % !test-target

% Set PostSet callbacks to editable parameters. This is optional for this app's case.
% addlistener(physval_length, "ValueText", "PostSet", @(~,~) deriveArea(physval_length, physval_area));
% addlistener(physval_length, "UnitText", "PostSet", @(~,~) deriveArea(physval_length, physval_area));

% Set PreGet callbacks to derived parameters.
addlistener(physval_area, "SimscapeValue", "PreGet", @(~,~) deriveArea(physval_length, physval_area));

app_struct = build_gui(physval_length, physval_area);

app_struct.LengthUI.Value = "2";
app_struct.LengthUI.ValueChangedCallback()

Show(app_struct.Window)

drawnow
app_struct.Window.MainFigure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window = app_struct.Window;
end  % if
end  % function

function deriveArea(Length, Area)
%%
arguments (Input)
  Length (1,1) CodeUtil1.PhysicalValue
  Area (1,1) CodeUtil1.PhysicalValue
end  % arguments
Area.SimscapeValue = (Length.SimscapeValue)^2;
end  % local function

function app_struct = build_gui(physval_length, physval_area)
%%

  function react_LengthUI_ValueChanged()
    physval_length.ValueText = length_ui.Value;
    sscval_length = physval_length.SimscapeValue;
    length_info_ui.Value = CodeUtil1.stringify(value(sscval_length)) + " (" + string(unit(sscval_length)) + ")";

    sscval_area = physval_area.SimscapeValue;
    area_ui.Value = CodeUtil1.stringify(value(sscval_area)) + " (" + string(unit(sscval_area)) + ")";
  end  % nested function

  function react_ButtonPushed()
    react_LengthUI_ValueChanged()
  end  % nested function

width_left_label = 140;

app_window = AppUtil1.AppUtilWindow(SourceFilename=mfilename);
app_window.Width = 540;
app_window.Height = 260;
app_window.Name = "Derived parameter demo";

main_layout = app_window.MainLayout;

app_area = NewArea(main_layout);
app_column = NewColumn(main_layout, app_area);

% =============================================================================
app_row = NewRow(main_layout, app_column);
label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row, Width="fit"));
label_ui.Text = join([
  "Enter a value of type double or simscape.Value for $L$."
  "The value can be a scalar, a vector, a matrix, or any MATLAB expression"
  "as long as it evaluates to the expected data type."
  "The value can also use base workspace variables."
  ], " ");
label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*3;
label_ui.WordWrap = "on";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row, Width="fit"));
label_ui.Text = "Length, $L$";
label_ui.ComponentWidth = width_left_label;

length_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row, Width="3x"));
length_ui.ValueChangedCallback = @() react_LengthUI_ValueChanged();

length_info_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row, Width="2x"));
length_info_ui.ReadOnly = "on";
length_info_ui.Value = "";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row, Width="fit"));
label_ui.Text = "Errors are reported in the Command Window.";

% =============================================================================
app_row = NewRow(main_layout, app_column);
AppUtil1.Component.HorizontalLine(app_row);

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);
label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));
label_ui.Text = "\textbf{Derived}";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);
label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row, Width="fit"));
label_ui.Text = "When the length is modified, the area is automatically updated.";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row, Width="fit"));
label_ui.Text = "Area, $S=L^{2}$";
label_ui.ComponentWidth = width_left_label;

area_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
area_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

button_ui = AppUtil1.Component.Button(NewSlot(main_layout, app_row));
button_ui.ButtonWidth = 100;
button_ui.HorizontalAlignment = "center";
button_ui.Text = "Refresh";
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

app_struct.Window = app_window;
app_struct.LengthUI = length_ui;
end  % function
