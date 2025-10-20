function App = apptest_BlockSelectorUI_1_simplest
% This test app directly uses uifigure and uigridlayout instead of AppUtilLayout
% to keep the dependency of this code minimal.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 800;  % width
main_figure.Position(4) = 100;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

%%

block_selector_ui_1 = AppUtil1.Component.BlockSelectorUI(main_layout);  % !test-target
block_selector_ui_1.MainFigure = main_figure;

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "dark";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.BlockSelectorUI = block_selector_ui_1;
end  % if
end  % function
