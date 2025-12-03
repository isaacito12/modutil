function App = apptest_ColumnLayout_1

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 220;  % height

column_layout = AppUtil1.ColumnLayout(main_figure);  % !test-target

label_ui = AppUtil1.Component.Label(NewColumnGrid(column_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Test";
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
