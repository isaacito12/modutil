function App = DemoApp_PhysicalValue_2_listener

% Copyright 2025-2026 The MathWorks, Inc.

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

%%

left_label_width = 140;

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 500;
app_window.Height = 240;
app_window.Name = "PhysicalValue Demo 2";

main_v_container = app_window.MainVerticalContainer;

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);

label_ui = AppUtil1.Component.Label(v_layout);
label_ui.WordWrap = "on";
label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*4;
label_ui.Text = "This app shows the automatic update of derived parameters." ...
  + newline + "Enter a (scalar/vector/matrix) value of type double or simscape.Value,"...
  + " or an expression which evaluates to those types." ...
  + " The text can contain base workspace variables.";

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);
horizontal_container = AppUtil1.HorizontalContainer(v_layout);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Length, $L$";
label_ui.ComponentWidth = left_label_width;

row_grid = addHorizontalGridLayout(horizontal_container);
length_ui = AppUtil1.Component.EditField(row_grid);
length_ui.ValueChangedCallback = @() react_LengthUI_ValueChanged();

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);

button_ui = AppUtil1.Component.Button(v_layout);
button_ui.ButtonWidth = 100;
button_ui.HorizontalAlignment = "center";
button_ui.Text = "Refresh";
button_ui.ButtonPushedCallback = @() react_ButtonPushed;

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);

label_ui = AppUtil1.Component.Label(v_layout);
label_ui.Text = "\textbf{Derived parameter}";

% -----------------------------------------------------------------------------
v_layout = addVerticalGridLayout(main_v_container);
horizontal_container = AppUtil1.HorizontalContainer(v_layout);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Area, $S=L^{2}$";
label_ui.ComponentWidth = left_label_width;

row_grid = addHorizontalGridLayout(horizontal_container);
area_ui = AppUtil1.Component.EditField(row_grid);
area_ui.ReadOnly = "on";

  function react_LengthUI_ValueChanged
    try
      physval_length.ValueText = length_ui.Value;     
    catch exception
      uialert(main_figure, exception.message, "Error")

      return

    end  % try, catch
    sscval_area = physval_area.SimscapeValue;
    area_ui.Value = CodeUtil1.stringify(value(sscval_area)) + " (" + string(unit(sscval_area)) + ")";
  end  % nested function

  function react_ButtonPushed
    react_LengthUI_ValueChanged
  end  % nested function

% -----------------------------------------------------------------------------
length_ui.Value = "simscape.Value([1 2 3], ""mm"")";

react_LengthUI_ValueChanged

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
  App.LengthUI = length_ui;
  App.RefreshButtonUI = button_ui;
  App.AreaUI = area_ui;
end  % if
end  % function

function deriveArea(Length, Area)
%%
arguments (Input)
  Length (1,:) CodeUtil1.PhysicalValue
  Area (1,:) CodeUtil1.PhysicalValue
end  % arguments
Area.SimscapeValue = (Length.SimscapeValue).^2;
end  % local function
