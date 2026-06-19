function App = AppTest_VerticalContainer_1

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 220;  % height

v_container = AppUtil1.VerticalContainer(main_figure);  % !test-target

v_gridlayout = addVerticalGridLayout(v_container);  % !test-target

label_ui = AppUtil1.Component.Label(v_gridlayout);
label_ui.MainFigure = main_figure;
label_ui.Text = "Test";
label_ui.HighlightBackground = "on";

%%
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
end  % if
end  % function
