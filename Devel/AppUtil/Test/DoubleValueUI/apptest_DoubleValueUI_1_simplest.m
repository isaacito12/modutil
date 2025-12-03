function App = apptest_DoubleValueUI_1_simplest

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = CodeUtil1.i18n("Test");
main_figure.Position(3) = 640;  % width
main_figure.Position(4) = 160;  % height

app_column_layout = AppUtil1.ColumnLayout(main_figure);

doubleval_ui = AppUtil1.Component.DoubleValueUI(NewColumnGrid(app_column_layout));  % !test-target
doubleval_ui.MainFigure = main_figure;

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.DoubleValueUI = doubleval_ui;
end  % if
end  % function
