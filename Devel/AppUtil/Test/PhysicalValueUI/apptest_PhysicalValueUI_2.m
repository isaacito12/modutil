function App = apptest_PhysicalValueUI_2

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 100;  % height

column_layout = AppUtil1.ColumnLayout(main_figure);

physval_ui = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));  % !test-target
physval_ui.MainFigure = main_figure;
physval_ui.NameText = "Physical value 1";
physval_ui.UnitText = "s";

physval_ui = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));  % !test-target
physval_ui.MainFigure = main_figure;
physval_ui.NameText = "Physical value 2";
physval_ui.UnitText = "N*m";

physval_ui = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));  % !test-target
physval_ui.MainFigure = main_figure;
physval_ui.NameText = "Physical value 3";
physval_ui.UnitText = "N*m/s";

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
