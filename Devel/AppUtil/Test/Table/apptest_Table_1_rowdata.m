function App = apptest_Table_1_rowdata
% This test app directly uses uifigure and uigridlayout instead of AppUtilLayout.
% This keeps the dependency of this test minimal.

% Copyright 2024-2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");
main_figure.Position(3) = 400;  % width
main_figure.Position(4) = 200;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

%%

table_ui_1 =  AppUtil1.Component.Table(main_layout);  % !test-target
table_ui_1.MainFigure = main_figure;
table_ui_1.MainTable.SelectionType = "row";
table_ui_1.MainTable.Multiselect = "off";
% The second argument of the uitable's SelectionChangedFcn callback is TableSelectionChangedData object.
% See the explanation about SelectionChangedFcn in the documentation for uitable properties.
% https://www.mathworks.com/help/matlab/ref/matlab.ui.control.table.html
table_ui_1.MainTable.SelectionChangedFcn = ...
  @(~, tableSelectionChangedData) react_TableSelectionChanged(tableSelectionChangedData);

  function react_TableSelectionChanged(tableSelectionChangedData)
    % Because SelectionType is "row",
    % the Selection property has the selected row number.
    row_num = tableSelectionChangedData.Selection;
    row_data = table_ui_1.MainTable.Data(row_num, :);
    disp("Testing table")
    disp(" Row: " + row_num)
    disp(" Data:")
    disp(row_data)
  end  % function

% Highlight the entire area of the test target component to make the component area clear.
table_ui_1.HighlightBackground = "on";

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
  App.TableUI = table_ui_1;
end  % if
end  % function
