function App = apptest_Label_2_inner_align
% Test the horizontal and vertical position of the main component within the component.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

common_height = AppUtil1.Constant.Height{"oneline++"}*3;

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 700;  % width
main_figure.Position(4) = 300;  % height

main_layout = AppUtil1.AppUtilLayout(main_figure);

app_area = NewArea(main_layout);
app_column = NewColumn(main_layout, app_area);

%%
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "left";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "center";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "top";
label_ui.HorizontalAlignment = "right";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "on";

%%
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "left";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "center";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "center";
label_ui.HorizontalAlignment = "right";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "off";

%%
app_row = NewRow(main_layout, app_column);

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "left";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "on";

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "center";
label_ui.MainFigure = main_figure;
label_ui.HighlightBackground = "off";

label_ui = AppUtil1.Component.Label(NewSlot(main_layout, app_row));  % !test-target
label_ui.Text = "Testing" + newline + "label component";
label_ui.ComponentHeight = common_height;
label_ui.VerticalAlignment = "bottom";
label_ui.HorizontalAlignment = "right";
label_ui.MainFigure = main_figure;
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
