function App = apptest_Label_3_wordwrap
% This test app directly uses uifigure and uigridlayout instead of AppUtilLayout
% to keep the dependency of this code minimal.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

height_label = AppUtil1.Constant.Height{"oneline"}*5;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 280 * 3;  % width
main_figure.Position(4) = 340;  % height

main_layout = AppUtil1.AppUtilLayout(main_figure);
app_area = NewArea(main_layout);

% =============================================================================
app_column = NewColumn(main_layout, app_area);

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "left";
label_ui.Text = "Vertical alignment is ""top"". Horizontal alignment is ""left"".";
label_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "left";
label_ui.Text = "Vertical alignment is ""center"". Horizontal alignment is ""left"".";
label_ui.HighlightBackground = "off";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "left";
label_ui.Text = "Vertical alignment is ""bottom"". Horizontal alignment is ""left"".";
label_ui.HighlightBackground = "on";

% =============================================================================
app_column = NewColumn(main_layout, app_area);

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "center";
label_ui.Text = "Vertical alignment is ""top"". Horizontal alignment is ""center"".";
label_ui.HighlightBackground = "off";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "center";
label_ui.Text = "Vertical alignment is ""center"". Horizontal alignment is ""center"".";
label_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "center";
label_ui.Text = "Vertical alignment is ""bottom"". Horizontal alignment is ""center"".";
label_ui.HighlightBackground = "off";

% =============================================================================
app_column = NewColumn(main_layout, app_area);

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "right";
label_ui.Text = "Vertical alignment is ""top"". Horizontal alignment is ""right"".";
label_ui.HighlightBackground = "on";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "right";
label_ui.Text = "Vertical alignment is ""center"". Horizontal alignment is ""right"".";
label_ui.HighlightBackground = "off";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.MainFigure = main_figure;
label_ui.ComponentHeight = height_label;
label_ui.WordWrap = "on";
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "right";
label_ui.Text = "Vertical alignment is ""bottom"". Horizontal alignment is ""right"".";
label_ui.HighlightBackground = "on";

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end % if
end  % function
