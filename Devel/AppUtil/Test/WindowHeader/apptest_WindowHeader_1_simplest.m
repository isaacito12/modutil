function App = apptest_WindowHeader_1_simplest

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 80;  % height

grid_layout = uigridlayout(main_figure, [1 1]);
grid_layout.RowHeight = {'fit'};
grid_layout.ColumnWidth = {'1x'};
grid_layout.Padding = [0 0 0 0];
grid_layout.ColumnSpacing = 0;
grid_layout.RowSpacing = 0;

%%

window_header_ui = AppUtil1.Component.WindowHeader(grid_layout);  % !test-target
window_header_ui.MainFigure = main_figure;

% Highlight the entire area of the test target component to make the component area clear.
window_header_ui.HighlightBackground = "on";

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.WindowHeaderUI = window_header_ui;
end  % if
end  % function
