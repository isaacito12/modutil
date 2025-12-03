function App = apptest_DoubleValueUI_2

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Name = "Test";
app_window.Width = 500;
app_window.Height = 200;

main_figure = app_window.MainFigure;

app_column_layout = app_window.MainLayout;

doubleval_ui_1 = AppUtil1.Component.DoubleValueUI(NewColumnGrid(app_column_layout));  % !test-target
doubleval_ui_1.MainFigure = main_figure;
doubleval_ui_1.NameText = CodeUtil1.i18n("Double value 1");
doubleval_ui_1.ValueText = "1.2";

doubleval_ui_2 = AppUtil1.Component.DoubleValueUI(NewColumnGrid(app_column_layout));  % !test-target
doubleval_ui_2.MainFigure = main_figure;
doubleval_ui_2.NameText = CodeUtil1.i18n("Double value 2");
% Info UI must appear when the app window appears.
doubleval_ui_2.ValueText = "[0, 2*pi]";

doubleval_ui_3 = AppUtil1.Component.DoubleValueUI(NewColumnGrid(app_column_layout));  % !test-target
doubleval_ui_3.MainFigure = main_figure;
doubleval_ui_3.NameText = CodeUtil1.i18n("Double value 3");
doubleval_ui_3.ValueText = "magic(2)";

doubleval_ui_4 = AppUtil1.Component.DoubleValueUI(NewColumnGrid(app_column_layout));  % !test-target
doubleval_ui_4.MainFigure = main_figure;
doubleval_ui_4.NameText = CodeUtil1.i18n("Double value 4");
doubleval_ui_4.ValueText = "magic(5)";
% Adjust component widths using uigridlayout's directives.
doubleval_ui_4.ValueUIWidth = "1x";
doubleval_ui_4.InfoUIWidth = "2x";

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
end  % if
end  % function
