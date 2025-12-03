function App = apptest_StateButton_1_simplest
% This test app directly uses uifigure and uigridlayout instead of AppUtilLayout
% to keep the dependency of this code minimal.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 80;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

%%

button_ui_1 = AppUtil1.Component.StateButton(main_layout);  % !test-target
button_ui_1.MainFigure = main_figure;
button_ui_1.ValueChangedCallback = @() disp("Testing state button: " + button_ui_1.Value);

% Highlight the entire area of the test target component to make the component area clear.
button_ui_1.HighlightBackground = "on";

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
  App.ButtonUI = button_ui_1;
end  % if
end  % function
