function App = apptest_RowLayout_2

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 220;  % height

row_layout = AppUtil1.RowLayout(main_figure);  % !test-target

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout, Width=140));
label_ui.MainFigure = main_figure;
label_ui.Text = "test 1";
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "test 2";
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(NewRowGrid(row_layout, Width=100));
label_ui.MainFigure = main_figure;
label_ui.Text = "test 3";
label_ui.HighlightBackground = "on";

%%
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
