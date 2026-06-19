function App = apptest_Axes_1_simplest

% Copyright 2024-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 400;  % width
main_figure.Position(4) = 300;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

main_layout.Scrollable = "on";

% -----------------------------------------------------------------------------
% !test-target

axes_ui = AppUtil1.Graphics.Axes(main_layout);

% The height of the Axes is usually specific to individual use cases.
% In this case, use the window height as an example.
axes_ui.ComponentHeight = main_figure.Position(4);

% (optional) Highlight the entire area of the test target component for visual inspection.
axes_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
end % if
end  % function
