function App = apptest_Axes_2_vertical_scrollbar

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 400;  % width
main_figure.Position(4) = 300;  % height

main_grid = uigridlayout(main_figure, [1 1]);
main_grid.RowHeight = {'fit'};
main_grid.ColumnWidth = {'1x'};
main_grid.Padding = [0 0 0 0];
main_grid.ColumnSpacing = 0;
main_grid.RowSpacing = 0;

main_grid.Scrollable = "on";

%%

axes_ui = AppUtil1.Graphics.Axes(main_grid);  % !test-target

axes_ui.MainFigure = main_figure;

% Make axes UI taller than the app window.
% Vertical scrollbar must appear when the app window appears.
axes_ui.ComponentHeight = main_figure.Position(4) + 100;

% Highlight the entire area of the test target component for visual inspection.
axes_ui.HighlightBackground = "on";

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "dark";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
