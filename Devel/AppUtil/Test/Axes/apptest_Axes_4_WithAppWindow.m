function App = apptest_Axes_4_WithAppWindow

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure);
app_window.Width = 300;
app_window.Height = 400;

main_column_layout = app_window.MainLayout;

axes_ui = AppUtil1.Graphics.Axes(NewColumnGrid(main_column_layout));  % !test-target

axes_ui.MainFigure = app_window.MainFigure;

% Make axes UI taller than the app window.
% Vertical scrollbar must appear when the app window appears.
axes_ui.ComponentHeight = app_window.Height + 100;

% Highlight the entire area of the test target component for visual inspection.
axes_ui.HighlightBackground = "on";

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App.Window = app_window;
end  % if
end  % function
