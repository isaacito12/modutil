function App = DemoApp_PhysicalUnitLabel_1_simplest

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 300;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

% -----------------------------------------------------------------------------
% !test-target

physical_unit_label_ui = AppUtil1.Component.PhysicalUnitLabel(main_layout);

% Highlight the background of the component to see the area which the component occupies.
physical_unit_label_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.PhysicalUnitLabel_1 = physical_unit_label_ui;
end  % if
end  % function
