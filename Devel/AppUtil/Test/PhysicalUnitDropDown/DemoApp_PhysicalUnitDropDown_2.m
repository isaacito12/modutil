function App = DemoApp_PhysicalUnitDropDown_2

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
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

%%

physical_unit_drop_down_ui = AppUtil1.Component.PhysicalUnitDropDown(main_layout);
physical_unit_drop_down_ui.MainFigure = main_figure;

% Define UnitItems.
% Defining UnitItems is allowed only once.
% After defining, commensurate units can be added.
physical_unit_drop_down_ui.UnitItems = ["m", "in"];

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "dark";
  % main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.PhysicalUnitDropDownUI = physical_unit_drop_down_ui;
end % if
end  % function
