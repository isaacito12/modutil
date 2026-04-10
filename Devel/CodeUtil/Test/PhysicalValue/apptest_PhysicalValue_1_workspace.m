function App = apptest_PhysicalValue_1_workspace

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

pvalue_1 = CodeUtil1.PhysicalValue;  % !test-target

width_left_label = 100;

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 400;
app_window.Height = 180;
app_window.Name = "Test";

main_vertical_container = app_window.MainVerticalContainer;

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);

label_ui = AppUtil1.Component.Label(column_grid);
label_ui.Text = "Enter a value of type double or simscape.Value." ...
  + newline + "The value can use base workspace variables.";
label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*2;

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);

editfield_ui = AppUtil1.Component.EditField(column_grid);
editfield_ui.ValueChangedCallback = @() react_EditField_ValueChanged();

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
AppUtil1.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = AppUtil1.Component.Label(row_grid);
label_ui.Text = "Value";
label_ui.ComponentWidth = width_left_label;

row_grid = addHorizontalGridLayout(horizontal_container);
value_ui = AppUtil1.Component.EditField(row_grid);
value_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
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
editfield_ui.Value = "simscape.Value([1 2 3], ""m"").^2";

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
