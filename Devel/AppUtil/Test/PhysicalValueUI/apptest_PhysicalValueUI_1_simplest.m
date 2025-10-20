function App = apptest_PhysicalValueUI_1_simplest
% This is a function-based app and uses uifigure and uigridlayout,
% instead of using AppUtilWindow and its layout property.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 200;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

%%

physval_ui_1 = AppUtil1.Component.PhysicalValueUI(main_layout);  % !test-target

%%
main_figure.Visible = "on";

drawnow

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.PhysicalValueUI_1 = physval_ui_1;
end  % if
end  % function
