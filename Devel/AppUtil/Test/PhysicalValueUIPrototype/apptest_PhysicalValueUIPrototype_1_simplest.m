function App = apptest_PhysicalValueUIPrototype_1_simplest

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

app_window = AppUtil1.AppUtilWindow(SourceFilename=mfilename);
app_window.Name = "Test";
app_window.Width = 640;
app_window.Height = 160;

main_figure = app_window.MainFigure;

app_layout = app_window.MainLayout;
app_area = NewArea(app_layout);
app_column = NewColumn(app_layout, app_area);
app_row = NewRow(app_layout, app_column);
physval_ui = AppUtil1.Component.PhysicalValueUIPrototype(NewSlot(app_layout, app_row));  % !test-target
physval_ui.MainFigure = main_figure;
physval_ui.UnitText = "s";
% physval_ui.NameText = CodeUtil1.i18n("Physical value");
% physval_ui.UnitItems = ["m/s", "mph"];
% physval_ui.ValueText = "simscape.Value(45.6, ""mph"")";
% physval_ui.ValueChangedCallback = @() disp(CodeUtil1.stringify(physval_ui.SimscapeValue));
% physval_ui.UnitChangedCallback = @() disp(CodeUtil1.stringify(physval_ui.SimscapeValue));

Show(app_window)

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window = app_window;
end  % if
end  % function
