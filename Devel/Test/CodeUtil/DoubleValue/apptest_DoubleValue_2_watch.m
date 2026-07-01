function App = apptest_DoubleValue_2_watch

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

% Editable parameters
double_value_length = mus1.CodeUtil.DoubleValue;  % !test-target

% Derived (read-only) parameters
double_value_area = mus1.CodeUtil.DoubleValue;  % !test-target

% Set PreGet callbacks to derived parameters.
addlistener(double_value_area, "MainDoubleValue", "PreGet", @(~,~) deriveArea(double_value_length, double_value_area));

app_struct = build_gui(double_value_length, double_value_area);

app_struct.LengthUI.Value = "[1 2 3]";

% ValueChangedCallback(app_struct.LengthUI) does not work because LengthUI is a struct field.
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
  App.LengthUI = app_struct.LengthUI;
  App.ButtonUI = app_struct.ButtonUI;
end  % if
end  % function

function deriveArea(Length, Area)
%%
arguments (Input)
  Length (1,:) mus1.CodeUtil.DoubleValue
  Area (1,:) mus1.CodeUtil.DoubleValue
end  % arguments
Area.MainDoubleValue = (Length.MainDoubleValue).^2;
end  % local function

function app_struct = build_gui(double_value_length, double_value_area)
%%
arguments (Input)
  double_value_length (1,:) mus1.CodeUtil.DoubleValue
  double_value_area (1,:) mus1.CodeUtil.DoubleValue
end  % arguments

arguments (Output)
  app_struct (1,1) struct
end  % arguments

width_left_label = 140;

main_figure = uifigure(Visible="off");

app_window = mus1.AppUtil.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 500;
app_window.Height = 200;
app_window.Name = "Test";

main_vertical_container = app_window.MainVerticalContainer;

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
label_ui = mus1.AppUtil.Component.Label(column_grid);
label_ui.Text = "Enter a value of type double."...
  + newline + "The value can also use base workspace variables.";
label_ui.ComponentHeight = mus1.AppUtil.Constant.Height{"oneline"}*2;

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = mus1.AppUtil.HorizontalContainer(column_grid);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = mus1.AppUtil.Component.Label(row_grid);
label_ui.Text = "Length, $L$";
label_ui.ComponentWidth = width_left_label;

row_grid = addHorizontalGridLayout(horizontal_container);
length_ui = mus1.AppUtil.Component.EditField(row_grid);
length_ui.ValueChangedCallback = @() react_LengthUI_ValueChanged();

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
mus1.AppUtil.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);

label_ui = mus1.AppUtil.Component.Label(column_grid);
label_ui.Text = "\textbf{Derived}";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = mus1.AppUtil.HorizontalContainer(column_grid);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = mus1.AppUtil.Component.Label(row_grid);
label_ui.Text = "Area, $S=L^{2}$";
label_ui.ComponentWidth = width_left_label;

row_grid = addHorizontalGridLayout(horizontal_container);
area_ui = mus1.AppUtil.Component.EditField(row_grid);
area_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);

button_ui = mus1.AppUtil.Component.Button(column_grid);
button_ui.ButtonWidth = 100;
button_ui.HorizontalAlignment = "center";
button_ui.Text = "Refresh";
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

  function react_LengthUI_ValueChanged()
    double_value_length.ValueText = length_ui.Value;
    S = double_value_area.MainDoubleValue;
    area_ui.Value = mus1.CodeUtil.stringify(S);
  end  % nested function

  function react_ButtonPushed()
    react_LengthUI_ValueChanged()
  end  % nested function

app_struct = struct;
app_struct.Window = app_window;
app_struct.LengthUI = length_ui;
app_struct.ButtonUI = button_ui;
end  % local function
