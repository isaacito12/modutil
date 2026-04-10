function App = ColormapApp

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

if isMATLABReleaseOlderThan("R2025a")
  % colormaplist was introduced in R2025a.
  id = "ColormapApp:NotSupported";
  msg = CodeUtil1.i18n("The app requires MATLAB R2025a or newer.");

  throw(MException(id, msg))

end  % if

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 900;
app_window.Height = 500;
app_window.Name = CodeUtil1.i18n("Colormap");

main_vertical_container = app_window.MainVerticalContainer;
main_column_grid = addVerticalGridLayout(main_vertical_container);
main_horizontal_container = AppUtil1.HorizontalContainer(main_column_grid);

% =============================================================================
% Left pane

listbox_ui = AppUtil1.Component.ListBox(addHorizontalGridLayout(main_horizontal_container, Width=140));
listbox_ui.MainFigure = app_window.MainFigure;
listbox_ui.ComponentHeight = "1x";
listbox_ui.MainListBox.Items = colormaplist;
listbox_ui.ValueChangedCallback = @() react_ColormapChanged();

% =============================================================================
% Center pane
center_grid = addHorizontalGridLayout(main_horizontal_container);
vertical_container = AppUtil1.VerticalContainer(center_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(vertical_container);

axes_ui = AppUtil1.Graphics.Axes(column_grid);
axes_ui.MainFigure = app_window.MainFigure;
axes_ui.ComponentHeight = 400;

% surf(axes_ui.MainAxes, peaks)
contourf(axes_ui.MainAxes, peaks)

colorbar(axes_ui.MainAxes)

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(vertical_container);

label_ui_1 = AppUtil1.Component.Label(column_grid);
label_ui_1.MainFigure = app_window.MainFigure;
label_ui_1.Text = CodeUtil1.i18n("Row");

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(vertical_container);

horizontal_container = AppUtil1.HorizontalContainer(column_grid);

label_ui_2 = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui_2.MainFigure = app_window.MainFigure;
label_ui_2.Text = CodeUtil1.i18n("Light");
label_ui_2.MainLabel.FontColor = "black";

label_ui_3 = AppUtil1.Component.Label(addHorizontalGridLayout(horizontal_container));
label_ui_3.MainFigure = app_window.MainFigure;
label_ui_3.Text = CodeUtil1.i18n("Dark");
label_ui_3.MainLabel.FontColor = "white";

% =============================================================================
% Right pane
right_grid = addHorizontalGridLayout(main_horizontal_container, Width=320);
vertical_container = AppUtil1.VerticalContainer(right_grid);

% -----------------------------------------------------------------------------
column_grid = addVerticalGridLayout(vertical_container);

table_ui = AppUtil1.Component.Table(column_grid);
table_ui.ComponentHeight = app_window.Height - 40;
table_ui.MainFigure = app_window.MainFigure;
table_ui.MainTable.Data = parula;
table_ui.MainTable.ColumnName = ["R" "G" "B"];
table_ui.MainTable.SelectionType = "row";
table_ui.MainTable.Multiselect = "off";
% The second argument of the uitable's SelectionChangedFcn callback is TableSelectionChangedData object.
% See the explanation about SelectionChangedFcn in the documentation for uitable properties.
% https://www.mathworks.com/help/matlab/ref/matlab.ui.control.table.html
table_ui.MainTable.SelectionChangedFcn = ...
  @(~, tableSelectionChangedData) react_RGBChanged(tableSelectionChangedData);

row_num = 1;
hex_text = "#000000";

  function update_info()
    label_ui_1.Text = row_num + " " + hex_text;
    label_ui_2.main_grid.BackgroundColor = hex_text;
    label_ui_3.main_grid.BackgroundColor = hex_text;
  end  % function

  function react_ColormapChanged()
    cmap_name = listbox_ui.MainListBox.Value;
    colormap(axes_ui.MainAxes, cmap_name)
    table_ui.MainTable.Data = feval(cmap_name);

    row_data = table_ui.MainTable.Data(row_num, :);
    hex_text = rgb2hex(row_data);

    update_info()
  end  % nested function

  function react_RGBChanged(tableSelectionChangedData)
    % Because SelectionType is "row",
    % the Selection property has the selected row number.
    row_num = tableSelectionChangedData.Selection;
    row_data = table_ui.MainTable.Data(row_num, :);
    hex_text = rgb2hex(row_data);

    update_info()
  end  % function

%%
react_ColormapChanged()

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App.Window = app_window;
end  % if
end  % function
