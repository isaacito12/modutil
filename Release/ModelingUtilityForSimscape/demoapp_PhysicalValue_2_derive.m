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

if not(isMATLABReleaseOlderThan("R2025a"))
  app_struct.Window.MainFigure.Theme = "light";
end  % if

movegui(app_struct.Window.MainFigure, "center")
app_struct.Window.MainFigure.Visible = "on";
drawnow
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

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 540;
app_window.Height = 260;
app_window.Name = "Derived parameter demo";

main_column_layout = app_window.MainLayout;

% =============================================================================
column_grid = NewColumnGrid(main_column_layout);

label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = join([
  "Enter a value of type double or simscape.Value for $L$."
  "The value can be a scalar, a vector, a matrix, or any MATLAB expression"
  "as long as it evaluates to the expected data type."
  "The value can also use base workspace variables."
  ], " ");
label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*3;
label_ui.WordWrap = "on";

% -----------------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

row_grid = NewRowGrid(row_layout, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Length, $L$";
label_ui.ComponentWidth = width_left_label;

row_grid = NewRowGrid(row_layout, Width="3x");
length_ui = AppUtil1.Component.EditField(row_grid);
length_ui.ValueChangedCallback = @() react_LengthUI_ValueChanged();

row_grid = NewRowGrid(row_layout, Width="2x");
length_info_ui = AppUtil1.Component.EditField(row_grid);
length_info_ui.ReadOnly = "on";
length_info_ui.Value = "";

% -----------------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);

label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = "Errors are reported in the Command Window.";

% =============================================================================
column_grid = NewColumnGrid(main_column_layout);
AppUtil1.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = "\textbf{Derived}";

% -----------------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = "When the length is modified, the area is automatically updated.";

% -----------------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);
row_layout = AppUtil1.RowLayout(column_grid);

row_grid = NewRowGrid(row_layout, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Area, $S=L^{2}$";
label_ui.ComponentWidth = width_left_label;

row_grid = NewRowGrid(row_layout);
area_ui = AppUtil1.Component.EditField(row_grid);
area_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
column_grid = NewColumnGrid(main_column_layout);

button_ui = AppUtil1.Component.Button(column_grid);
button_ui.ButtonWidth = 100;
button_ui.HorizontalAlignment = "center";
button_ui.Text = "Refresh";
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

app_struct.Window = app_window;
app_struct.LengthUI = length_ui;
end  % function
