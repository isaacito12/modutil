function App = apptest_PhysicalValueUI_UnitText_1

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 600;  % width
main_figure.Position(4) = 100;  % height

column_layout = AppUtil1.ColumnLayout(main_figure);

%%

physval_ui = AppUtil1.Component.PhysicalValueUI(NewColumnGrid(column_layout));
physval_ui.MainFigure = main_figure;

physval_ui.UnitText = "s";  % !test-target

physval_ui.HighlightBackground = "on";

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
end  % if
end  % function
