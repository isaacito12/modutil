function App = apptest_Hyperlink_1_simplest
% This test app directly uses uifigure and uigridlayout instead of AppUtilLayout
% to keep the dependency of this code minimal.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 100;  % height

app_layout = uigridlayout(main_figure, [1 1]);
app_layout.RowHeight = {'fit'};
app_layout.ColumnWidth = {'1x'};
app_layout.Padding = [0 0 0 0];
app_layout.ColumnSpacing = 0;
app_layout.RowSpacing = 0;

%%

link_ui = mus1.AppUtil.Component.Hyperlink(app_layout);  % !test-target
link_ui.MainFigure = main_figure;
link_ui.Text = "Click Here";
link_ui.HyperlinkClickedCallback = @() disp("Testing the hyperlink UI.");

% Highlight the entire area of the test target component.
link_ui.HighlightBackground = "on";

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
  App.LinkUI = link_ui;
end  % if
end  % function
