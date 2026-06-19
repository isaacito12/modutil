<<<<<<<< HEAD:Devel/AppUtil/Test/DropDown/DemoApp_DropDown_1_simplest.m
function App = DemoApp_DropDown_1_simplest
========
function App = DemoApp_PhysicalUnitLabel_1_simplest
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppUtil/Test/PhysicalUnitLabel/DemoApp_PhysicalUnitLabel_1_simplest.m

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 300;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

<<<<<<<< HEAD:Devel/AppUtil/Test/DropDown/DemoApp_DropDown_1_simplest.m
%% ----------------------------------------------------------------------------
% !test-target

dropdown_ui_1 = AppUtil1.Component.DropDown(main_layout);

%% ----------------------------------------------------------------------------
========
% -----------------------------------------------------------------------------
% !test-target

physical_unit_label_ui = AppUtil1.Component.PhysicalUnitLabel(main_layout);

% Highlight the background of the component to see the area which the component occupies.
physical_unit_label_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppUtil/Test/PhysicalUnitLabel/DemoApp_PhysicalUnitLabel_1_simplest.m
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
<<<<<<<< HEAD:Devel/AppUtil/Test/DropDown/DemoApp_DropDown_1_simplest.m
  App.MainFigure = main_figure;
  App.DropDownUI_1 = dropdown_ui_1;
========
  App.Window.MainFigure = main_figure;
  App.PhysicalUnitLabel_1 = physical_unit_label_ui;
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppUtil/Test/PhysicalUnitLabel/DemoApp_PhysicalUnitLabel_1_simplest.m
end  % if
end  % function
