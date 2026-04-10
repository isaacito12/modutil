function App = AppTest_PhysicalValueUI_1_simplest

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 100;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

physval_ui = AppUtil1.Component.PhysicalValueUI(main_layout);  % !test-target
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
  App.PhysicalValueUI = physval_ui;
end  % if
end  % function
