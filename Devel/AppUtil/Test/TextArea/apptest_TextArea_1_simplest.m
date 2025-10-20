function App = apptest_TextArea_1_simplest

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 200;  % height

main_grid = uigridlayout(main_figure, [1 1]);
main_grid.RowHeight = {'fit'};
main_grid.ColumnWidth = {'1x'};
main_grid.Padding = [0 0 0 0];
main_grid.ColumnSpacing = 0;
main_grid.RowSpacing = 0;

%%

ta = AppUtil1.Component.TextArea(main_grid);  % !test-target
ta.MainFigure = main_figure;
ta.ComponentHeight = main_figure.Position(4) - 20;

ta.ValueChangedCallback = @() disp(ta.ValueString);

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.TextAreaUI = ta;
end  % if
end  % function
