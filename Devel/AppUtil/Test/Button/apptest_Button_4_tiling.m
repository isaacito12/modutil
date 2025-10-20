function App = apptest_Button_4_tiling
% Test the spacing among the same components.

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
app_area = NewArea(app_layout);

app_column = NewColumn(app_layout, app_area);
build_ui(app_layout, app_column, [1 0 1]);
build_ui(app_layout, app_column, [0 1 0]);
build_ui(app_layout, app_column, [1 0 1]);

app_column = NewColumn(app_layout, app_area);
build_ui(app_layout, app_column, [0 1 0]);
build_ui(app_layout, app_column, [1 0 1]);
build_ui(app_layout, app_column, [0 1 0]);

  function build_ui(app_layout, app_column, hilit)
    % Add 9 buttons in the 3-by-3 layout.
    for row_count = 1 : 3
      app_row = NewRow(app_layout, app_column);

      % left
      ui_1 = AppUtil1.Component.Button(NewSlot(app_layout, app_row, Width=160));  % !test-target
      ui_1.MainFigure = main_figure;
      ui_1.HighlightBackground = hilit(1);

      % center
      ui_2 = AppUtil1.Component.Button(NewSlot(app_layout, app_row, Width="1x"));  % !test-target
      ui_2.MainFigure = main_figure;
      ui_2.HighlightBackground = hilit(2);

      % right
      ui_3 = AppUtil1.Component.Button(NewSlot(app_layout, app_row, Width="1x"));  % !test-target
      ui_3.MainFigure = main_figure;
      ui_3.HighlightBackground = hilit(3);
    end  % for
  end  % nested function

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
