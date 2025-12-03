function App = apptest_AppWindow_2_vertical_scrollbar

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);  % !test-target
app_window.Name = CodeUtil1.i18n("Test");
app_window.Width = 400;
app_window.Height = 140;

main_column_layout = app_window.MainLayout;

column_grid = NewColumnGrid(main_column_layout);

label_ui = AppUtil1.Component.Label(column_grid);
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = 200;
label_ui.VerticalAlignment = "top";
label_ui.WordWrap = "on";
label_ui.Text = join([
  "This label UI component is taller than the window height."
  "Thus, AppWindow must add a vertical scrollbar when the app window appears."
  ], " ");

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
end % if
end  % function
