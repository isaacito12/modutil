function App = apptest_PhysicalValueUI_UnitAlias_2_percent

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

width_name = 140;
width_info = 160;
width_unit = 140;

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 100;  % height

column_layout = AppUtil1.ColumnLayout(main_figure);

label_ui = AppUtil1.Component.Label(NewColumnGrid(column_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Unit alias is used. UnitUI area is an empty space.";

physval_ui = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));
physval_ui.MainFigure = main_figure;
physval_ui.NameUIWidth = width_name;
physval_ui.InfoUIWidth = width_info;
physval_ui.UnitUIWidth = width_unit;
physval_ui.NameText = CodeUtil1.i18n("Physical value");
physval_ui.ValueChangedCallback = @() update_info();
physval_ui.UnitAlias = "\%";  % !test-target
physval_ui.ValueText = "3";
physval_ui.HighlightBackground = "on";

refresh_button_ui = AppUtil1.Component.Button(NewColumnGrid(column_layout));
refresh_button_ui.MainFigure = main_figure;
refresh_button_ui.ButtonWidth = 140;
refresh_button_ui.HorizontalAlignment = "center";
refresh_button_ui.Text = CodeUtil1.i18n("Refresh");
refresh_button_ui.ButtonPushedCallback = @() react_ButtonPushed();

row_layout = AppUtil1.RowLayout(NewColumnGrid(column_layout));

info_name_ui_1 = AppUtil1.Component.Label(NewRowGrid(row_layout));
info_name_ui_1.MainFigure = main_figure;
info_name_ui_1.HorizontalAlignment = "right";
info_name_ui_1.Text = "simscape.Value";

info_text_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
info_text_ui.MainFigure = main_figure;
info_text_ui.HorizontalAlignment = "left";
info_text_ui.Text = "";

  function update_info()
    info_text_ui.Text = CodeUtil1.stringify(physval_ui.SimscapeValue);
  end  % nested function

  function react_ButtonPushed()
    updateInfoAndUnitUIs(physval_ui)
    update_info()
  end  % nested function

%%
updateInfoAndUnitUIs(physval_ui)
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
  App.PhysicalValueUI = physval_ui;
end  % if
end  % function
