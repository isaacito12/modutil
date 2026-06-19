function App = DemoApp_PhysicalValueWithUnitDropDown_1_simplest

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

<<<<<<< HEAD
main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 300;  % height

main_layout = uigridlayout(main_figure, [1 1]);
=======
main_fig = uifigure(Visible="off");
main_fig.Name = "Test";
main_fig.Position(3) = 640;  % width
main_fig.Position(4) = 300;  % height

main_layout = uigridlayout(main_fig, [1 1]);
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
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
physval_ui_1 = AppUtil1.Component.PhysicalValueWithUnitDropDown(main_layout);

% (optional) Highlight the background of the component to visually inspect the area which
% the component occupies. This is for debugging purpose.
physval_ui_1.HighlightBackground = "on";

% -----------------------------------------------------------------------------
<<<<<<< HEAD
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
=======
movegui(main_fig, "center")
main_fig.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_fig;
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
  App.PhysicalValueWithUnitDropDown_1 = physval_ui_1;
end  % if
end  % function
