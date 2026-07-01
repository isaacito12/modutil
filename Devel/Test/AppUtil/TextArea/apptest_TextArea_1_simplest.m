function App = apptest_TextArea_1_simplest

% Copyright 2024-2026 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 200;  % height

if not(isMATLABReleaseOlderThan("R2025a"))
  main_figure.Theme = "dark";
end  % if

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

% -----------------------------------------------------------------------------
% !test-target

textarea_ui_1 = mus1.AppUtil.Component.TextArea(main_layout);

textarea_ui_1.ComponentHeight = main_figure.Position(4) - 20;

textarea_ui_1.ValueChangedCallback = @() disp(textarea_ui_1.ValueString);

textarea_ui_1.HighlightBackground = "on";

% -----------------------------------------------------------------------------
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.MainFigure = main_figure;
  App.TextAreaUI = textarea_ui_1;
end  % if
end  % function
