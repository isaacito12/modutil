function App = DemoApp_PhysicalValueWithUnitLabel_1_simplest

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 300;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

% -----------------------------------------------------------------------------
% !test-target
% Just create a component with all defaults.

% In this component's case, do not specify UnitText.
% The unit defaults to "1".
physval_ui_1 = mus1.AppUtil.Component.PhysicalValueWithUnitLabel(main_layout);

% Highlight the background of the component to visually inspect the area which
% the component occupies. This is for debugging purpose.
physval_ui_1.HighlightBackground = "on";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.PhysicalValueWithUnitLabel_1 = physval_ui_1;
end  % if
end  % function
