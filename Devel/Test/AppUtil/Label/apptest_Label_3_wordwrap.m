function App = apptest_Label_3_wordwrap
% This test app directly uses uifigure and uigridlayout instead of AppUtilLayout
% to keep the dependency of this code minimal.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

height_label = mus1.AppUtil.Constant.Height{"oneline"}*5;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 280 * 3;  % width
main_figure.Position(4) = 340;  % height

main_horizontal_container = mus1.AppUtil.HorizontalContainer(main_figure);

% -----------------------------------------------------------------------------
row_grid = addHorizontalGridLayout(main_horizontal_container);
left_vertical_container = mus1.AppUtil.VerticalContainer(row_grid);

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(left_vertical_container));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "left";
label_ui.Text = "Vertical alignment is ""top"". Horizontal alignment is ""left"".";
label_ui.HighlightBackground = "on";

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(left_vertical_container));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "left";
label_ui.Text = "Vertical alignment is ""center"". Horizontal alignment is ""left"".";
label_ui.HighlightBackground = "off";

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(left_vertical_container));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "left";
label_ui.Text = "Vertical alignment is ""bottom"". Horizontal alignment is ""left"".";
label_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
row_grid = addHorizontalGridLayout(main_horizontal_container);
center_vertical_container = mus1.AppUtil.VerticalContainer(row_grid);

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(center_vertical_container));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "center";
label_ui.Text = "Vertical alignment is ""top"". Horizontal alignment is ""center"".";
label_ui.HighlightBackground = "off";

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(center_vertical_container));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "center";
label_ui.Text = "Vertical alignment is ""center"". Horizontal alignment is ""center"".";
label_ui.HighlightBackground = "on";

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(center_vertical_container));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "center";
label_ui.Text = "Vertical alignment is ""bottom"". Horizontal alignment is ""center"".";
label_ui.HighlightBackground = "off";

% -----------------------------------------------------------------------------
row_grid = addHorizontalGridLayout(main_horizontal_container);
right_vertical_container = mus1.AppUtil.VerticalContainer(row_grid);

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(right_vertical_container));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "right";
label_ui.Text = "Vertical alignment is ""top"". Horizontal alignment is ""right"".";
label_ui.HighlightBackground = "on";

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(right_vertical_container));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "right";
label_ui.Text = "Vertical alignment is ""center"". Horizontal alignment is ""right"".";
label_ui.HighlightBackground = "off";

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(right_vertical_container));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "right";
label_ui.Text = "Vertical alignment is ""bottom"". Horizontal alignment is ""right"".";
label_ui.HighlightBackground = "on";

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
end % if
end  % function
