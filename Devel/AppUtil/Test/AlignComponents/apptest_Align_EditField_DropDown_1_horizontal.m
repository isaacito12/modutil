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

main_figure.Position(3) = 800;  % width
main_figure.Position(4) = 200;  % height

main_grid = uigridlayout(main_figure, [1 1]);
main_grid.RowHeight = {'fit'};
main_grid.ColumnWidth = {'1x'};
main_grid.Padding = [0 0 0 0];
main_grid.ColumnSpacing = 0;
main_grid.RowSpacing = 0;

main_layout = AppUtil1.AppUtilLayout(main_grid);

app_area = NewArea(main_layout);
app_column = NewColumn(main_layout, app_area);

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

editfield_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = AppUtil1.Component.DropDown(NewSlot(main_layout, app_row));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

editfield_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";
editfield_ui.HighlightBackground = "on";

dropdown_ui = AppUtil1.Component.DropDown(NewSlot(main_layout, app_row));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";
dropdown_ui.HighlightBackground = "on";

editfield_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = AppUtil1.Component.EditableDropDown(NewSlot(main_layout, app_row));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

editfield_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";
editfield_ui.HighlightBackground = "on";

dropdown_ui = AppUtil1.Component.EditableDropDown(NewSlot(main_layout, app_row));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";
dropdown_ui.HighlightBackground = "on";

editfield_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";

dropdown_ui = AppUtil1.Component.EditableDropDown(NewSlot(main_layout, app_row));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";

editfield_ui = AppUtil1.Component.EditField(NewSlot(main_layout, app_row));
editfield_ui.MainFigure = main_figure;
editfield_ui.MainEditField.Placeholder = "(edit field)";
editfield_ui.HighlightBackground = "on";

dropdown_ui = AppUtil1.Component.DropDown(NewSlot(main_layout, app_row));
dropdown_ui.MainFigure = main_figure;
dropdown_ui.Items = ["1", "2"];
dropdown_ui.Value = "1";
dropdown_ui.HighlightBackground = "on";

%%
main_figure.Visible = "on";

drawnow
main_figure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
end  % if
end  % function
