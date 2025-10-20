function App = apptest_CheckBox_3_tiling

% Tile the same components.
% Visually inspect the spacing among them.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

main_figure.Position(3) = 900;  % width
main_figure.Position(4) = 300;  % height

main_grid = uigridlayout(main_figure, [1 1]);
main_grid.RowHeight = {'fit'};
main_grid.ColumnWidth = {'1x'};
main_grid.Padding = [0 0 0 0];
main_grid.ColumnSpacing = 0;
main_grid.RowSpacing = 0;

app_layout = AppUtil1.AppUtilLayout(main_grid);

area = NewArea(app_layout);

column = NewColumn(app_layout, area);
build_ui(main_figure, app_layout, column, [1 0 1])
build_ui(main_figure, app_layout, column, [0 1 0])
build_ui(main_figure, app_layout, column, [1 0 1])

column = NewColumn(app_layout, area);
build_ui(main_figure, app_layout, column, [0 1 0])
build_ui(main_figure, app_layout, column, [1 0 1])
build_ui(main_figure, app_layout, column, [0 1 0])

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App.Window.MainFigure = main_figure;
end  % if
end  % function

function build_ui(main_figure, layout, column, hilit)
%%
for column_count = 1 : 3
  row = NewRow(layout, column);

  % left
  ui_1 = AppUtil1.Component.CheckBox(NewSlot(layout, row, Width=160));  % #test-target
  ui_1.MainFigure = main_figure;
  ui_1.HighlightBackground = hilit(1);

  % center
  ui_2 = AppUtil1.Component.CheckBox(NewSlot(layout, row, Width="1x"));  % #test-target
  ui_2.MainFigure = main_figure;
  ui_2.HighlightBackground = hilit(2);

  % right
  ui_3 = AppUtil1.Component.CheckBox(NewSlot(layout, row, Width="2x"));  % #test-target
  ui_3.MainFigure = main_figure;
  ui_3.HighlightBackground = hilit(3);
end  % for
end  % function
