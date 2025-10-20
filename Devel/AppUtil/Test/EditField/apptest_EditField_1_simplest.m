function App = apptest_EditField_1_simplest
% This test app directly uses uifigure and uigridlayout instead of AppUtilLayout
% to keep the dependency of this code minimal.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 100;  % height

main_grid = uigridlayout(main_figure, [1 1]);
main_grid.RowHeight = {'fit'};
main_grid.ColumnWidth = {'1x'};
main_grid.Padding = [0 0 0 0];
main_grid.ColumnSpacing = 0;
main_grid.RowSpacing = 0;

%%

ef = AppUtil1.Component.EditField(main_grid);  % !test-target
ef.MainFigure = main_figure;

ef.ValueChangedCallback = @() disp(ef.Value);

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App =struct;
  App.Window.MainFigure = main_figure;
  App.EditFieldUI = ef;
end  % if
end  % function
