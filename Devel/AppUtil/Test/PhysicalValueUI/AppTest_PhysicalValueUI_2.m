function App = AppTest_PhysicalValueUI_2

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 100;  % height

v_container = AppUtil1.VerticalContainer(main_figure);

v_layout = addVerticalGridLayout(v_container);
physval_ui_1 = AppUtil1.Component.PhysicalValueUI(v_layout);  % !test-target
physval_ui_1.MainFigure = main_figure;
physval_ui_1.NameText = "Physical value 1";
physval_ui_1.UnitText = "s";

v_layout = addVerticalGridLayout(v_container);
physval_ui_2 = AppUtil1.Component.PhysicalValueUI(v_layout);  % !test-target
physval_ui_2.MainFigure = main_figure;
physval_ui_2.NameText = "Physical value 2";
physval_ui_2.UnitText = "N*m";

v_layout = addVerticalGridLayout(v_container);
physval_ui_3 = AppUtil1.Component.PhysicalValueUI(v_layout);  % !test-target
physval_ui_3.MainFigure = main_figure;
physval_ui_3.NameText = "Physical value 3";
physval_ui_3.UnitText = "N*m/s";

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.PhysicalValueUI_1 = physval_ui_1;
  App.PhysicalValueUI_2 = physval_ui_2;
  App.PhysicalValueUI_3 = physval_ui_3;
end  % if
end  % function
