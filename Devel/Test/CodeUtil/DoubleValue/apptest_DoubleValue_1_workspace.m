function App = apptest_DoubleValue_1_workspace

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

double_value_1 = mus1.CodeUtil.DoubleValue;  % !test-target

width_left_label = 100;

main_figure = uifigure(Visible="off");

app_window = mus1.AppUtil.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 400;
app_window.Height = 180;
app_window.Name = "Test";

main_vertical_container = app_window.MainVerticalContainer;

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
label_ui = mus1.AppUtil.Component.Label(column_grid);
label_ui.Text = "Enter a value of type double." ...
  + newline + "The value can use base workspace variables.";
label_ui.WordWrap = "on";
label_ui.ComponentHeight = mus1.AppUtil.Constant.Height{"oneline"}*2;

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
editfield_ui = mus1.AppUtil.Component.EditField(column_grid);
editfield_ui.ValueChangedCallback = @() react_EditField_ValueChanged();

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
mus1.AppUtil.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = mus1.AppUtil.HorizontalContainer(column_grid);

row_grid = addHorizontalGridLayout(horizontal_container, Width="fit");
label_ui = mus1.AppUtil.Component.Label(row_grid);
label_ui.Text = "Value";
label_ui.ComponentWidth = width_left_label;

row_grid = addHorizontalGridLayout(horizontal_container);
value_ui = mus1.AppUtil.Component.EditField(row_grid);
value_ui.ReadOnly = "on";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
button_ui = mus1.AppUtil.Component.Button(column_grid);
button_ui.ButtonWidth = 100;
button_ui.HorizontalAlignment = "center";
button_ui.Text = "Refresh";
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

  function react_EditField_ValueChanged()
    double_value_1.ValueText = editfield_ui.Value;
    x = double_value_1.MainDoubleValue;
    value_ui.Value = mus1.CodeUtil.stringify(x);
  end  % nested function

  function react_ButtonPushed()
    react_EditField_ValueChanged()
  end  % nested function

%%
editfield_ui.Value = "[1 2 3]";
react_EditField_ValueChanged()

if not(isMATLABReleaseOlderThan("R2025a"))
  app_window.MainFigure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
  App.EditFieldUI = editfield_ui;
  App.ValueUI = value_ui;
end  % if
end  % function
