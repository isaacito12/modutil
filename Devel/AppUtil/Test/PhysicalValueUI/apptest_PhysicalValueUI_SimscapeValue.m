function App = apptest_PhysicalValueUI_SimscapeValue

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = CodeUtil1.i18n("Test");
main_figure.Position(3) = 400;  % width
main_figure.Position(4) = 70;  % height

app_component = build_app_gui(main_figure);

app_component.PhysValUI_1.SimscapeValue = simscape.Value(2.3, "ms");  % !test-target

app_component.PhysValUI_2.SimscapeValue = simscape.Value(-4, "lbf*in");  % !test-target

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.PhysValUI_1 = app_component.PhysValUI_1;
  App.PhysValUI_2 = app_component.PhysValUI_2;
end  % if
end  % function

function app_component = build_app_gui(main_figure)
%%
column_layout = AppUtil1.ColumnLayout(main_figure);

app_component.PhysValUI_1 = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));  % !test-target
app_component.PhysValUI_1.MainFigure = main_figure;
app_component.PhysValUI_1.NameText = "Physical value 1";
app_component.PhysValUI_1.UnitText = "s";

app_component.PhysValUI_2 = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));  % !test-target
app_component.PhysValUI_2.MainFigure = main_figure;
app_component.PhysValUI_2.NameText = "Physical value 2";
app_component.PhysValUI_2.UnitText = "N*m";

end  % function
