function App = apptest_PhysicalValue_2_watch

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

%%

width_left_label = 140;

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 500;
app_window.Height = 200;
app_window.Name = "Test";

main_vertical_container = app_window.MainVerticalContainer;

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);

label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = "Enter a value of type double or simscape.Value."...
  + newline + "The value can also use base workspace variables.";
label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*2;

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Length, $L$";
label_ui.ComponentWidth = width_left_label;

row_grid = addHorizontalGridLayout(horizontal_container);
length_ui = AppUtil1.Component.EditField(row_grid);
length_ui.ValueChangedCallback = @() react_LengthUI_ValueChanged();

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
AppUtil1.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);

label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = "\textbf{Derived}";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Area, $S=L^{2}$";
label_ui.ComponentWidth = width_left_label;

row_grid = addHorizontalGridLayout(horizontal_container);
area_ui = AppUtil1.Component.EditField(row_grid);
area_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);

button_ui = AppUtil1.Component.Button(column_grid);
button_ui.ButtonWidth = 100;
button_ui.HorizontalAlignment = "center";
button_ui.Text = "Refresh";
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

  function react_LengthUI_ValueChanged()
    physval_length.ValueText = length_ui.Value;
    sscval_area = physval_area.SimscapeValue;
    area_ui.Value = CodeUtil1.stringify(value(sscval_area)) + " (" + string(unit(sscval_area)) + ")";
  end  % nested function

  function react_ButtonPushed()
    react_LengthUI_ValueChanged()
  end  % nested function

length_ui.Value = "simscape.Value([1 2 3], ""mm"")";
react_LengthUI_ValueChanged()

if not(isMATLABReleaseOlderThan("R2025a"))
  app_window.MainFigure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
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
