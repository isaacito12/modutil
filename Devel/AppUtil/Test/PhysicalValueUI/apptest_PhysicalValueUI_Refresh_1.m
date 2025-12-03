function App = apptest_PhysicalValueUI_Refresh_1

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

width_name = 140;
width_info = 160;
width_unit = 140;

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 160;  % height

column_layout = AppUtil1.ColumnLayout(main_figure);

A_physval_ui = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));  % !test-target
A_physval_ui.MainFigure = main_figure;
A_physval_ui.NameUIWidth = width_name;
A_physval_ui.InfoUIWidth = width_info;
A_physval_ui.UnitUIWidth = width_unit;
A_physval_ui.ValueChangedCallback = @() update_info();
A_physval_ui.UnitChangedCallback = @() update_info();
A_physval_ui.NameText = CodeUtil1.i18n("Physical value, $A$");
A_physval_ui.UnitItems = ["m/s", "mph"];
A_physval_ui.ValueText = "1";

B_physval_ui = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));  % !test-target
B_physval_ui.MainFigure = main_figure;
B_physval_ui.NameUIWidth = width_name;
B_physval_ui.InfoUIWidth = width_info;
B_physval_ui.UnitUIWidth = width_unit;
B_physval_ui.ValueChangedCallback = @() update_info();
B_physval_ui.UnitChangedCallback = @() update_info();
B_physval_ui.NameText = CodeUtil1.i18n("Physical value, $B$");
B_physval_ui.UnitItems = ["m/s", "mph"];
B_physval_ui.ValueText = "2";

refresh_button_ui = AppUtil1.Component.Button(NewColumnGrid(column_layout));
refresh_button_ui.MainFigure = main_figure;
refresh_button_ui.ButtonWidth = 140;
refresh_button_ui.HorizontalAlignment = "center";
refresh_button_ui.Text = CodeUtil1.i18n("Refresh");
refresh_button_ui.ButtonPushedCallback = @() react_ButtonPushed();

A_label_ui = AppUtil1.Component.Label(NewColumnGrid(column_layout));
A_label_ui.MainFigure = main_figure;
A_label_ui.HorizontalAlignment = "center";
A_label_ui.Text = "A";

B_label_ui = AppUtil1.Component.Label(NewColumnGrid(column_layout));
B_label_ui.MainFigure = main_figure;
B_label_ui.HorizontalAlignment = "center";
B_label_ui.Text = "B";

  function update_info()
    A_label_ui.Text = CodeUtil1.i18n("$A$: ") + CodeUtil1.stringify(A_physval_ui.SimscapeValue);
    B_label_ui.Text = CodeUtil1.i18n("$B$: ") + CodeUtil1.stringify(B_physval_ui.SimscapeValue);
  end  % nested function

  function react_ButtonPushed()
    updateInfoAndUnitUIs(A_physval_ui)
    updateInfoAndUnitUIs(B_physval_ui)
    update_info()
  end  % nested function

%%
update_info()

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.RefreshButtonUI = refresh_button_ui;
end  % if
end  % function
