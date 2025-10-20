function App = apptest_PhysicalValueUIPrototype_UnitItems_1

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 140;  % height

main_grid = uigridlayout(main_figure, [1 1]);
main_grid.RowHeight = {'fit'};
main_grid.ColumnWidth = {'1x'};
main_grid.Padding = [0 0 0 0];
main_grid.ColumnSpacing = 0;
main_grid.RowSpacing = 0;

%%

physval_ui = AppUtil1.Component.PhysicalValueUIPrototype(main_grid);
physval_ui.MainFigure = main_figure;

physval_ui.UnitItems = ["m/s", "mph"];  % !test-target

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.PhysicalValueUI = physval_ui;
end  % if
end  % function
