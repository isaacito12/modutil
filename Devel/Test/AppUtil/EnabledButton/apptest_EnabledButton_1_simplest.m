function App = apptest_EnabledButton_1_simplest

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 500;  % width
main_figure.Position(4) = 100;  % height

app_layout = uigridlayout(main_figure, [1 1]);
app_layout.RowHeight = {'fit'};
app_layout.ColumnWidth = {'1x'};
app_layout.Padding = [0 0 0 0];
app_layout.ColumnSpacing = 0;
app_layout.RowSpacing = 0;

%%

enabled_button_ui = mus1.AppUtil.Component.EnabledButton(app_layout);  % !test-target
enabled_button_ui.MainFigure = main_figure;

enabled_button_ui.ButtonPushedCallback = @() disp("Enabled button: ButtonPushedCallback");
enabled_button_ui.CheckBoxValueChangedCallback = @() disp("Enabled button: CheckBoxValueChangedCallback");

% Highlight the entire area of the test target component to make the component area clear.
enabled_button_ui.HighlightBackground = "on";

%%
if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.EnabledButtonUI = enabled_button_ui;
end % if
end  % function
