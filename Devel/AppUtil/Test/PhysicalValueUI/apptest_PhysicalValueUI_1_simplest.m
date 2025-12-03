function App = apptest_PhysicalValueUI_1_simplest

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 100;  % height

grid_layout = uigridlayout(main_figure, [1 1]);
grid_layout.RowHeight = {'fit'};
grid_layout.ColumnWidth = {'1x'};
grid_layout.Padding = [0 0 0 0];
grid_layout.ColumnSpacing = 0;
grid_layout.RowSpacing = 0;

physval_ui = AppUtil1.Component.PhysicalValueUI(grid_layout);  % !test-target
physval_ui.MainFigure = main_figure;
physval_ui.UnitText = "s";

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
