function App = apptest_Align_EditField_DropDown_2_vertical
% Test alignment of editfield and dropdown.
%
% This test does not automate the inspection process.
% You must visually inspect the alignment.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Name = "Test";
main_figure.Position(3) = 300;  % width
main_figure.Position(4) = 200;  % height

vertical_container = mus1.AppUtil.VerticalContainer(main_figure);

editfield_ui = mus1.AppUtil.Component.EditField(addVerticalGridLayout(vertical_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = mus1.AppUtil.Component.DropDown(addVerticalGridLayout(vertical_container));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

editfield_ui = mus1.AppUtil.Component.EditField(addVerticalGridLayout(vertical_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = mus1.AppUtil.Component.DropDown(addVerticalGridLayout(vertical_container));
dropdown_ui.Editable = "on";
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

editfield_ui = mus1.AppUtil.Component.EditField(addVerticalGridLayout(vertical_container));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

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
