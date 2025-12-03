function App = apptest_ListBox_1_simplest
% This test app directly uses uifigure and uigridlayout instead of AppUtilLayout.
% This keeps the dependency of this test minimal.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 400;  % width
main_figure.Position(4) = 200;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

%%

listbox_ui_1 =  AppUtil1.Component.ListBox(main_layout);  % !test-target
listbox_ui_1.MainFigure = main_figure;
listbox_ui_1.ValueChangedCallback = @() disp("Testing list box: " + listbox_ui_1.MainListBox.Value);

% Highlight the entire area of the test target component to make the component area clear.
listbox_ui_1.HighlightBackground = "on";

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
  App.ListBoxUI = listbox_ui_1;
end  % if
end  % function
