function App = apptest_AlignComponents_1_horizontal
% Test alignment with other UI components.
%
% This test does not automate the inspection process.
% You must visually inspect the alignment.
%
% By default, the ComponentHeight property of the following components are
% configured to have the "oneline++" height.
%
% - Button
% - CheckBox
% - DropDown
% - EditField
% - Hyperlink
% - Label
% - StateButton
%
% These components must align horizontally without specifying ComponentHeight.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = CodeUtil1.i18n("Test");
main_figure.Position(3) = 1000;  % width
main_figure.Position(4) = 200;  % height

main_vertical_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
AppUtil1.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_1_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_1_ui.MainFigure = main_figure;
label_1_ui.Text = "Left label";
label_1_ui.HighlightBackground = "on";

link_ui = AppUtil1.Component.Hyperlink(addHorizontalGridLayout(horizontal_container));
link_ui.MainFigure = main_figure;
link_ui.Text = "Hyperlink text";

editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text";

dropdown_ui = AppUtil1.Component.DropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

checkbox_ui = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";

button_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";

state_button_ui = AppUtil1.Component.StateButton(addHorizontalGridLayout(horizontal_container));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
AppUtil1.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Left label";

link_1_ui = AppUtil1.Component.Hyperlink(addHorizontalGridLayout(horizontal_container));
link_1_ui.MainFigure = main_figure;
link_1_ui.Text = "Hyperlink text";
link_1_ui.HighlightBackground = "on";

editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text";

dropdown_ui = AppUtil1.Component.DropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

checkbox_ui = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";

button_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";

state_button_ui = AppUtil1.Component.StateButton(addHorizontalGridLayout(horizontal_container));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
AppUtil1.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Left label";

link_ui = AppUtil1.Component.Hyperlink(addHorizontalGridLayout(horizontal_container));
link_ui.MainFigure = main_figure;
link_ui.Text = "Hyperlink text";

editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text";

dropdown_ui = AppUtil1.Component.DropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

checkbox_ui = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";

button_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";

state_button_ui = AppUtil1.Component.StateButton(addHorizontalGridLayout(horizontal_container));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
AppUtil1.Component.HorizontalLine(column_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Left label";
link_ui = AppUtil1.Component.Hyperlink(addHorizontalGridLayout(horizontal_container));
link_ui.MainFigure = main_figure;
link_ui.Text = "Hyperlink text";
editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";
label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text";
dropdown_ui = AppUtil1.Component.DropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";
checkbox_ui = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";
button_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";
state_button_ui = AppUtil1.Component.StateButton(addHorizontalGridLayout(horizontal_container));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Left label";
link_ui = AppUtil1.Component.Hyperlink(addHorizontalGridLayout(horizontal_container));
link_ui.MainFigure = main_figure;
link_ui.Text = "Hyperlink text";
editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";
label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text";
dropdown_ui = AppUtil1.Component.DropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";
checkbox_ui = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";
button_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";
state_button_ui = AppUtil1.Component.StateButton(addHorizontalGridLayout(horizontal_container));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Left label";
link_ui = AppUtil1.Component.Hyperlink(addHorizontalGridLayout(horizontal_container));
link_ui.MainFigure = main_figure;
link_ui.Text = "Hyperlink text";
editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";
label_ui = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text";
dropdown_ui = AppUtil1.Component.DropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";
checkbox_ui = AppUtil1.Component.CheckBox(addHorizontalGridLayout(horizontal_container));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";
button_ui = AppUtil1.Component.Button(addHorizontalGridLayout(horizontal_container));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";
state_button_ui = AppUtil1.Component.StateButton(addHorizontalGridLayout(horizontal_container));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(main_vertical_container);
AppUtil1.Component.HorizontalLine(column_grid);

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
