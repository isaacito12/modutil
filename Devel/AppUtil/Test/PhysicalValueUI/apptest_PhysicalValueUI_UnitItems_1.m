function App = apptest_PhysicalValueUI_UnitItems_1

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 180;  % height

column_layout = AppUtil1.ColumnLayout(main_figure);

%%

physval_ui_1 = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));
physval_ui_1.MainFigure = main_figure;
physval_ui_1.NameText = "Physical value 1";
physval_ui_1.UnitItems = ["m/s", "mph"];  % !test-target

physval_ui_2 = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));
physval_ui_2.MainFigure = main_figure;
physval_ui_2.ComponentHeight = AppUtil1.Constant.Height{"oneline"} * 2;
physval_ui_2.NameText = "Physical value 2" + newline + "two-line name text";
physval_ui_2.UnitItems = ["m/s", "mph"];  % !test-target
physval_ui_2.HighlightBackground = "on";

physval_ui_3 = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));
physval_ui_3.MainFigure = main_figure;
physval_ui_3.NameText = "Physical value 3";
physval_ui_3.UnitItems = ["m/s", "mph"];  % !test-target

physval_ui_4 = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));
physval_ui_4.MainFigure = main_figure;
physval_ui_4.ComponentHeight = AppUtil1.Constant.Height{"oneline"} * 2;
physval_ui_4.NameText = "Physical value 4" + newline + "two-line name text";
physval_ui_4.UnitItems = "s";  % !test-target
physval_ui_4.HighlightBackground = "on";

physval_ui_5 = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));
physval_ui_5.MainFigure = main_figure;
physval_ui_5.NameText = "Physical value 5";
physval_ui_5.UnitItems = "min";  % !test-target

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.PhysicalValueUI = physval_ui_1;
end  % if
end  % function
