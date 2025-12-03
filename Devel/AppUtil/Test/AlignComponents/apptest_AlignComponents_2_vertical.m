function App = apptest_AlignComponents_2_vertical
% Test alignment of UI components.
%
% This test does not automate the inspection process.
% You must visually inspect the alignment.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

main_figure.Position(3) = 400;  % width
main_figure.Position(4) = 210;  % height

main_row_layout = AppUtil1.RowLayout(main_figure);

% -----------------------------------------------------------------------------
left_column_grid = NewRowGrid(main_row_layout);
column_layout = AppUtil1.ColumnLayout(left_column_grid);

label_ui = AppUtil1.Component.Label(NewColumnGrid(column_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text 1";
label_ui.HighlightBackground = "on";

link_ui = AppUtil1.Component.Hyperlink(NewColumnGrid(column_layout));
link_ui.MainFigure = main_figure;
link_ui.Text = "Hyperlink text";

editfield_ui = AppUtil1.Component.EditField(NewColumnGrid(column_layout));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

label_ui = AppUtil1.Component.Label(NewColumnGrid(column_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text 2";

dropdown_ui = AppUtil1.Component.DropDown(NewColumnGrid(column_layout));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

checkbox_ui = AppUtil1.Component.CheckBox(NewColumnGrid(column_layout));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";

button_ui = AppUtil1.Component.Button(NewColumnGrid(column_layout));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";

state_button_ui = AppUtil1.Component.StateButton(NewColumnGrid(column_layout));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

% -----------------------------------------------------------------------------
right_column_grid = NewRowGrid(main_row_layout);
column_layout = AppUtil1.ColumnLayout(right_column_grid);

checkbox_ui = AppUtil1.Component.CheckBox(NewColumnGrid(column_layout));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";

dropdown_ui = AppUtil1.Component.DropDown(NewColumnGrid(column_layout));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

label_ui = AppUtil1.Component.Label(NewColumnGrid(column_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text 1";
label_ui.HighlightBackground = "on";

button_ui = AppUtil1.Component.Button(NewColumnGrid(column_layout));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";

editfield_ui = AppUtil1.Component.EditField(NewColumnGrid(column_layout));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

link_ui = AppUtil1.Component.Hyperlink(NewColumnGrid(column_layout));
link_ui.MainFigure = main_figure;
link_ui.Text = "Hyperlink text";

state_button_ui = AppUtil1.Component.StateButton(NewColumnGrid(column_layout));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

label_ui = AppUtil1.Component.Label(NewColumnGrid(column_layout));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text 2";
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
  App.Window.MainFigure = main_figure;
end  % if
end  % function
