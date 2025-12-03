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

column_layout = AppUtil1.ColumnLayout(main_figure);

editfield_ui = AppUtil1.Component.EditField(NewColumnGrid(column_layout));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = AppUtil1.Component.DropDown(NewColumnGrid(column_layout));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

editfield_ui = AppUtil1.Component.EditField(NewColumnGrid(column_layout));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = AppUtil1.Component.EditableDropDown(NewColumnGrid(column_layout));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

editfield_ui = AppUtil1.Component.EditField(NewColumnGrid(column_layout));
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
  App.Window.MainFigure = main_figure;
end  % if
end  % function
