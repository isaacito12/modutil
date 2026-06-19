function App = AppTest_HorizontalContainer_1

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 220;  % height

h_container = AppUtil1.HorizontalContainer(main_figure);  % !test-target

h_gridlayout = addHorizontalGridLayout(h_container);

label_ui = AppUtil1.Component.Label(h_gridlayout);
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
