function App = apptest_Axes_3_WithLayout

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 400;  % width
main_figure.Position(4) = 300;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

vertical_container = AppUtil1.VerticalContainer(main_figure);

axes_ui = AppUtil1.Graphics.Axes(addVerticalGridLayout(vertical_container));  % !test-target

% Make axes UI taller than the app window.
% Vertical scrollbar must appear when the app window appears.
axes_ui.ComponentHeight = main_figure.Position(4) + 100;

% Highlight the entire area of the test target component for visual inspection.
axes_ui.HighlightBackground = "on";

%%
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
