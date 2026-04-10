function App = AppTest_PhysicalValueUI_Refresh_2

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

width_name = 140;
width_info = 160;
width_unit = 140;

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 230;  % height

vertical_container = AppUtil1.VerticalContainer(main_figure);

physval_ui_1 = AppUtil1.Component.PhysicalValueUI(addVerticalGridLayout(vertical_container));
physval_ui_1.MainFigure = main_figure;
physval_ui_1.NameUIWidth = width_name;
physval_ui_1.InfoUIWidth = width_info;
physval_ui_1.UnitUIWidth = width_unit;
physval_ui_1.ValueChangedCallback = @() update_info();
physval_ui_1.UnitChangedCallback = @() update_info();
physval_ui_1.NameText = CodeUtil1.i18n("Physical value 1");
physval_ui_1.UnitText = "s";  % !test-target
physval_ui_1.ValueText = "1.1";  % !test-target

physval_ui_2 = AppUtil1.Component.PhysicalValueUI(addVerticalGridLayout(vertical_container));
physval_ui_2.MainFigure = main_figure;
physval_ui_2.NameUIWidth = width_name;
physval_ui_2.InfoUIWidth = width_info;
physval_ui_2.UnitUIWidth = width_unit;
physval_ui_2.NameText = CodeUtil1.i18n("Physical value 2");
physval_ui_2.UnitAlias = "\%";  % !test-target
physval_ui_2.ValueText = "-2";  % !test-target

physval_ui_3 = AppUtil1.Component.PhysicalValueUI(addVerticalGridLayout(vertical_container));
physval_ui_3.MainFigure = main_figure;
physval_ui_3.NameUIWidth = width_name;
physval_ui_3.InfoUIWidth = width_info;
physval_ui_3.UnitUIWidth = width_unit;
physval_ui_3.NameText = CodeUtil1.i18n("Physical value 3");
physval_ui_3.UnitAlias = "";  % !test-target
physval_ui_3.ValueText = "pi";  % !test-target

physval_ui_4 = AppUtil1.Component.PhysicalValueUI(addVerticalGridLayout(vertical_container));
physval_ui_4.MainFigure = main_figure;
physval_ui_4.NameUIWidth = width_name;
physval_ui_4.InfoUIWidth = width_info;
physval_ui_4.UnitUIWidth = width_unit;
physval_ui_4.NameText = CodeUtil1.i18n("Physical value 4");
physval_ui_4.UnitItems = ["m/s", "mph"];  % !test-target
physval_ui_4.UnitText = "mph";  % !test-target
physval_ui_4.ValueText = "-4.4";  % !test-target

physval_ui_5 = AppUtil1.Component.PhysicalValueUI(addVerticalGridLayout(vertical_container));
physval_ui_5.MainFigure = main_figure;
physval_ui_5.NameUIWidth = width_name;
physval_ui_5.InfoUIWidth = width_info;
physval_ui_5.UnitUIWidth = width_unit;
physval_ui_5.NameText = CodeUtil1.i18n("Physical value 5");
physval_ui_5.UnitItems = ["m/s", "mph"];  % !test-target
physval_ui_5.ValueText = "simscape.Value(55.5, ""mph"")";  % !test-target

refresh_button_ui = AppUtil1.Component.Button(addVerticalGridLayout(vertical_container));
refresh_button_ui.MainFigure = main_figure;
refresh_button_ui.ButtonWidth = 140;
refresh_button_ui.HorizontalAlignment = "center";
refresh_button_ui.Text = CodeUtil1.i18n("Refresh");
refresh_button_ui.ButtonPushedCallback = @() react_ButtonPushed();

label_ui = AppUtil1.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "\textbf{simscape.Value}";

horizontal_container = AppUtil1.HorizontalContainer(addVerticalGridLayout(vertical_container));

label_ui_1 = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui_1.MainFigure = main_figure;
label_ui_1.Text = "1";

label_ui_2 = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui_2.MainFigure = main_figure;
label_ui_2.Text = "2";

label_ui_3 = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui_3.MainFigure = main_figure;
label_ui_3.Text = "3";

horizontal_container = AppUtil1.HorizontalContainer(addVerticalGridLayout(vertical_container));

label_ui_4 = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui_4.MainFigure = main_figure;
label_ui_4.Text = "4";

label_ui_5 = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui_5.MainFigure = main_figure;
label_ui_5.Text = "5";

  function update_info()
    label_ui_1.Text = CodeUtil1.i18n("1: ") + CodeUtil1.stringify(physval_ui_1.SimscapeValue);
    label_ui_2.Text = CodeUtil1.i18n("2: ") + CodeUtil1.stringify(physval_ui_2.SimscapeValue);
    label_ui_3.Text = CodeUtil1.i18n("3: ") + CodeUtil1.stringify(physval_ui_3.SimscapeValue);
    label_ui_4.Text = CodeUtil1.i18n("4: ") + CodeUtil1.stringify(physval_ui_4.SimscapeValue);
    label_ui_5.Text = CodeUtil1.i18n("5: ") + CodeUtil1.stringify(physval_ui_5.SimscapeValue);
  end  % nested function

  function react_ButtonPushed()
    updateInfoAndUnitUIs(physval_ui_1)
    updateInfoAndUnitUIs(physval_ui_2)
    updateInfoAndUnitUIs(physval_ui_3)
    updateInfoAndUnitUIs(physval_ui_4)
    updateInfoAndUnitUIs(physval_ui_5)
    update_info()
  end  % nested function
%%
react_ButtonPushed()

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
