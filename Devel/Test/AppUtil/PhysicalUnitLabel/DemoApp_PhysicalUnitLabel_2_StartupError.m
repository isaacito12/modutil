function App = DemoApp_PhysicalUnitLabel_2_StartupError(NameValuePair)

% Copyright 2026 The MathWorks, Inc.

arguments (Input)
  NameValuePair.EnableStartupError (1,1) logical = false
end  % arguments

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

physical_unit_label_ui = mus1.AppUtil.Component.PhysicalUnitLabel(main_layout);

physical_unit_label_ui.UnitText = "m";

if NameValuePair.EnableStartupError
  % Intentionally set a wrong unit. "s" is not commensurate with "m".
  physical_unit_label_ui.UnitText = "s";  % !test-target
end  % if

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.PhysicalUnitLabel = physical_unit_label_ui;
end  % if
end  % function
