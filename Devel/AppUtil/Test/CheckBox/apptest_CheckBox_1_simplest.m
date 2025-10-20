function App = apptest_CheckBox_1_simplest
% This test app directly uses uifigure and uigridlayout instead of AppUtilLayout.
% This keeps the dependency of this test minimal.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 80;  % height

app_layout = uigridlayout(main_figure, [1 1]);
app_layout.RowHeight = {'fit'};
app_layout.ColumnWidth = {'1x'};
app_layout.Padding = [0 0 0 0];
app_layout.ColumnSpacing = 0;
app_layout.RowSpacing = 0;

%%

check_box_ui = AppUtil1.Component.CheckBox(app_layout);  % !test-target
check_box_ui.MainFigure = main_figure;
check_box_ui.ValueChangedCallback = @() disp("Testing check box");

% Highlight the entire area of the test target component.
check_box_ui.HighlightBackground = "on";

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.CheckBoxUI = check_box_ui;
end  % if
end  % function
