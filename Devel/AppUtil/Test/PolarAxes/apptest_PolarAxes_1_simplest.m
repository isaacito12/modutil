function App = apptest_PolarAxes_1_simplest

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
% main_figure.Position(3) = 300;  % width
% main_figure.Position(4) = 200;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "dark";
end  % if

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

% Set RowHeight "fit" and Scrollable "on" so that a vertical scrollbar appears
% if the panel is taller than the app window.
main_layout.RowHeight = {'fit'};
main_layout.Scrollable = "on";

% -----------------------------------------------------------------------------

polar_axes_ui = AppUtil1.Graphics.PolarAxes(main_layout);  % !test-target

% Make the panel taller than the app window.
% A vertical scrollbar must appear in the window.
polar_axes_ui.ComponentHeight = 390;

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
end  % if
end  % function
