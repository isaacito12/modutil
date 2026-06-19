function App = DemoApp_BlockSelectorUI_1_simplest

% Copyright 2024-2026 The MathWorks, Inc.

arguments (Output)
  App struct {mustBeScalarOrEmpty}
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 800;  % width
main_figure.Position(4) = 100;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

% -----------------------------------------------------------------------------
% !test-target

block_selector_ui_1 = AppUtil1.Component.BlockSelectorUI(main_layout);

block_selector_ui_1.Reporting = "on";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.BlockSelectorUI_1 = block_selector_ui_1;
end  % if
end  % function
