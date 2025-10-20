function App = apptest_PhysicalValueUIPrototype_UnitAlias_1_empty

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

width_name = 140;
width_info = 160;
width_unit = 140;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 100;  % height

main_grid = uigridlayout(main_figure, [1 1]);
main_grid.RowHeight = {'fit'};
main_grid.ColumnWidth = {'1x'};
main_grid.Padding = [0 0 0 0];
main_grid.ColumnSpacing = 0;
main_grid.RowSpacing = 0;

app_layout = AppUtil1.AppUtilLayout(main_grid);
app_area = NewArea(app_layout);
app_column = NewColumn(app_layout, app_area);

app_row = NewRow(app_layout, app_column);
label_ui = AppUtil1.Component.Label(NewSlot(app_layout, app_row));
label_ui.MainFigure = main_figure;
label_ui.Text = "Unit alias is used. UnitUI area is an empty space.";

app_row = NewRow(app_layout, app_column);
physval_ui = AppUtil1.Component.PhysicalValueUIPrototype(NewSlot(app_layout, app_row));
physval_ui.MainFigure = main_figure;
physval_ui.NameUIWidth = width_name;
physval_ui.InfoUIWidth = width_info;
physval_ui.UnitUIWidth = width_unit;
physval_ui.NameText = CodeUtil1.i18n("Physical value");
physval_ui.ValueChangedCallback = @() update_info();
physval_ui.UnitAlias = "";  % !test-target
physval_ui.ValueText = "pi";  % !test-target
physval_ui.HighlightBackground = "on";

app_row = NewRow(app_layout, app_column);
refresh_button_ui = AppUtil1.Component.Button(NewSlot(app_layout, app_row));
refresh_button_ui.MainFigure = main_figure;
refresh_button_ui.ButtonWidth = 140;
refresh_button_ui.HorizontalAlignment = "center";
refresh_button_ui.Text = CodeUtil1.i18n("Refresh");
refresh_button_ui.ButtonPushedCallback = @() react_ButtonPushed();

app_row = NewRow(app_layout, app_column);

info_name_ui_1 = AppUtil1.Component.Label(NewSlot(app_layout, app_row));
info_name_ui_1.MainFigure = main_figure;
info_name_ui_1.HorizontalAlignment = "right";
info_name_ui_1.Text = "simscape.Value";

info_text_ui = AppUtil1.Component.Label(NewSlot(app_layout, app_row));
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
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.RefreshButtonUI = refresh_button_ui;
  App.PhysicalValueUI = physval_ui;
end  % if
end  % function
