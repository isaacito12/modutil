function App = apptest_Axes_4_WithAppUtilWindow

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

app_window = AppUtil1.AppUtilWindow;
app_window.Width = 300;
app_window.Height = 400;

main_layout = app_window.MainLayout;

app_area = NewArea(main_layout);
app_column = NewColumn(main_layout, app_area);
app_row = NewRow(main_layout, app_column);

%%

axes_ui = AppUtil1.Graphics.Axes(NewSlot(main_layout, app_row));  % !test-target

axes_ui.MainFigure = app_window.MainFigure;

% Make axes UI taller than the app window.
% Vertical scrollbar must appear when the app window appears.
axes_ui.ComponentHeight = app_window.Height + 100;

% Highlight the entire area of the test target component for visual inspection.
axes_ui.HighlightBackground = "on";

%%
Show(app_window)

drawnow
app_window.MainFigure.Theme = "dark";

% if nargout > 0
  App.Window = app_window;
% end  % if
end  % function
