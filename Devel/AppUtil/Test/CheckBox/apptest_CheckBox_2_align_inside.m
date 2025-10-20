function App = apptest_CheckBox_2_align_inside

% Test alignment within the component:
% - VerticalAlignment
% - HorizontalAlignment

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 760;  % width
main_figure.Position(4) = 300;  % height

main_grid = uigridlayout(main_figure, [1 1]);
main_grid.RowHeight = {'fit'};
main_grid.ColumnWidth = {'1x'};
main_grid.Padding = [0 0 0 0];
main_grid.ColumnSpacing = 0;
main_grid.RowSpacing = 0;

app_layout = AppUtil1.AppUtilLayout(main_grid);

build_ui(main_figure, app_layout, NewArea(app_layout), "top",    [1 0 1])
build_ui(main_figure, app_layout, NewArea(app_layout), "center", [0 1 0])
build_ui(main_figure, app_layout, NewArea(app_layout), "bottom", [1 0 1])

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function

function build_ui(main_figure, layout, area, vert, hilit)
%%
column = NewColumn(layout, area);

cb = AppUtil1.Component.CheckBox(column);  % #test-target
cb.MainFigure = main_figure;
cb.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*4;
cb.VerticalAlignment = vert;
cb.HorizontalAlignment = "left";
cb.ValueChangedCallback = @() disp(cb.Text);
cb.Text = ...
  "VerticalAlignment: " + cb.VerticalAlignment + newline + ...
  "HorizontalAlignment: " + cb.HorizontalAlignment;
cb.HighlightBackground = hilit(1);

column = NewColumn(layout, area);

cb = AppUtil1.Component.CheckBox(column);  % #test-target
cb.MainFigure = main_figure;
cb.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*4;
cb.VerticalAlignment = vert;
cb.HorizontalAlignment = "center";
cb.ValueChangedCallback = @() disp(cb.Text);
cb.Text = ...
  "VerticalAlignment: " + cb.VerticalAlignment + newline + ...
  "HorizontalAlignment: " + cb.HorizontalAlignment;
cb.HighlightBackground = hilit(2);

column = NewColumn(layout, area);

cb = AppUtil1.Component.CheckBox(column);  % #test-target
cb.MainFigure = main_figure;
cb.ComponentHeight = AppUtil1.Constant.Height{"oneline"}*4;
cb.VerticalAlignment = vert;
cb.HorizontalAlignment = "right";
cb.ValueChangedCallback = @() disp(cb.Text);
cb.Text = ...
  "VerticalAlignment: " + cb.VerticalAlignment + newline + ...
  "HorizontalAlignment: " + cb.HorizontalAlignment;
cb.HighlightBackground = hilit(3);

end  % function
