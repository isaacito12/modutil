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

main_horizontal_container = mus1.AppUtil.HorizontalContainer(main_figure);

% -----------------------------------------------------------------------------
left_column_grid = addHorizontalGridLayout(main_horizontal_container);
vertical_container = mus1.AppUtil.VerticalContainer(left_column_grid);

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text 1";
label_ui.HighlightBackground = "on";

link_ui = mus1.AppUtil.Component.Hyperlink(addVerticalGridLayout(vertical_container));
link_ui.MainFigure = main_figure;
link_ui.Text = "Hyperlink text";

editfield_ui = mus1.AppUtil.Component.EditField(addVerticalGridLayout(vertical_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text 2";

dropdown_ui = mus1.AppUtil.Component.DropDown(addVerticalGridLayout(vertical_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

checkbox_ui = mus1.AppUtil.Component.CheckBox(addVerticalGridLayout(vertical_container));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";

button_ui = mus1.AppUtil.Component.Button(addVerticalGridLayout(vertical_container));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";

state_button_ui = mus1.AppUtil.Component.StateButton(addVerticalGridLayout(vertical_container));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

% -----------------------------------------------------------------------------
right_column_grid = addHorizontalGridLayout(main_horizontal_container);
vertical_container = mus1.AppUtil.VerticalContainer(right_column_grid);

checkbox_ui = mus1.AppUtil.Component.CheckBox(addVerticalGridLayout(vertical_container));
checkbox_ui.MainFigure = main_figure;
checkbox_ui.Text = "Check box";

dropdown_ui = mus1.AppUtil.Component.DropDown(addVerticalGridLayout(vertical_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(vertical_container));
label_ui.MainFigure = main_figure;
label_ui.Text = "Label text 1";
label_ui.HighlightBackground = "on";

button_ui = mus1.AppUtil.Component.Button(addVerticalGridLayout(vertical_container));
button_ui.MainFigure = main_figure;
button_ui.Text = "Button";

editfield_ui = mus1.AppUtil.Component.EditField(addVerticalGridLayout(vertical_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

link_ui = mus1.AppUtil.Component.Hyperlink(addVerticalGridLayout(vertical_container));
link_ui.MainFigure = main_figure;
link_ui.Text = "Hyperlink text";

state_button_ui = mus1.AppUtil.Component.StateButton(addVerticalGridLayout(vertical_container));
state_button_ui.MainFigure = main_figure;
state_button_ui.Text = "State button";

label_ui = mus1.AppUtil.Component.Label(addVerticalGridLayout(vertical_container));
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
  App.MainFigure = main_figure;
end  % if
end  % function
