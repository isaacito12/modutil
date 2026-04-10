function App = DemoApp_DoubleValueUI_2

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Name = "Test";
app_window.Width = 500;
app_window.Height = 200;

app_v_container = app_window.MainVerticalContainer;

v_layout = addVerticalGridLayout(app_v_container);
dvalue_ui_1 = AppUtil1.Component.DoubleValueUI(v_layout);  % !test-target
dvalue_ui_1.MainFigure = main_figure;
dvalue_ui_1.NameText = CodeUtil1.i18n("Double value 1");
dvalue_ui_1.ValueText = "1.2";

v_layout = addVerticalGridLayout(app_v_container);
dvalue_ui_2 = AppUtil1.Component.DoubleValueUI(v_layout);  % !test-target
dvalue_ui_2.MainFigure = main_figure;
dvalue_ui_2.NameText = CodeUtil1.i18n("Double value 2");
% Info UI must appear when the app window appears.
dvalue_ui_2.ValueText = "[0, 2*pi]";

v_layout = addVerticalGridLayout(app_v_container);
dvalue_ui_3 = AppUtil1.Component.DoubleValueUI(v_layout);  % !test-target
dvalue_ui_3.MainFigure = main_figure;
dvalue_ui_3.NameText = CodeUtil1.i18n("Double value 3");
dvalue_ui_3.ValueText = "magic(2)";

v_layout = addVerticalGridLayout(app_v_container);
dvalue_ui_4 = AppUtil1.Component.DoubleValueUI(v_layout);  % !test-target
dvalue_ui_4.MainFigure = main_figure;
dvalue_ui_4.NameText = CodeUtil1.i18n("Double value 4");
dvalue_ui_4.ValueText = "magic(5)";
% Adjust component widths using uigridlayout's directives.
dvalue_ui_4.ValueUIWidth = "1x";
dvalue_ui_4.InfoUIWidth = "2x";

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
  App.DoubleValueUI_1 = dvalue_ui_1;
  App.DoubleValueUI_2 = dvalue_ui_2;
  App.DoubleValueUI_3 = dvalue_ui_3;
  App.DoubleValueUI_4 = dvalue_ui_4;
end  % if
end  % function
