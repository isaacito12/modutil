function App = apptest_Align_EditField_DropDown_1_horizontal
% Test  alignment of editfield and dropdown.
%
% This test does not automate the inspection process.
% You must visually inspect the alignment.

% !attention: The horizontal alignment of uieditfield and uidropdown in
% a uigridlayout seems very slightly off.
% Adjusting the padding of each component's main grid seems to have no effect.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 800;  % width
main_figure.Position(4) = 200;  % height

vertical_container = AppUtil1.VerticalContainer(main_figure);

% -----------------------------------------------------------------------------
horizontal_container = AppUtil1.HorizontalContainer(addVerticalGridLayout(vertical_container));

editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = AppUtil1.Component.DropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";
editfield_ui.HighlightBackground = "on";

dropdown_ui = AppUtil1.Component.DropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";
dropdown_ui.HighlightBackground = "on";

editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = AppUtil1.Component.EditableDropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

% -----------------------------------------------------------------------------
horizontal_container = AppUtil1.HorizontalContainer(addVerticalGridLayout(vertical_container));

editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";
editfield_ui.HighlightBackground = "on";

dropdown_ui = AppUtil1.Component.EditableDropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";
dropdown_ui.HighlightBackground = "on";

editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = AppUtil1.Component.EditableDropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

editfield_ui = AppUtil1.Component.EditField(addHorizontalGridLayout(horizontal_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";
editfield_ui.HighlightBackground = "on";

dropdown_ui = AppUtil1.Component.DropDown(addHorizontalGridLayout(horizontal_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";
dropdown_ui.HighlightBackground = "on";

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
