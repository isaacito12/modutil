function App = ColormapApp

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

app_window = LiteApp8.LiteAppWindow(SourceFilename=mfilename);
app_window.Width = 900;
app_window.Height = 500;
app_window.Name = CodeTool1.i18n("Colormap");

main_layout = app_window.MainLayout;

app_area = NewArea(main_layout);

% =============================================================================
app_column = NewColumn(main_layout, app_area, Width=140);

app_row = NewRow(main_layout, app_column);
listbox_ui = LiteApp8.Component.ListBox(NewSlot(main_layout, app_row));
listbox_ui.MainFigure = app_window.MainFigure;
listbox_ui.ComponentHeight = "1x";
listbox_ui.MainListBox.Items = colormaplist;
listbox_ui.ValueChangedCallback = @() react_ColormapChanged();

% =============================================================================
app_column = NewColumn(main_layout, app_area);

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

axes_ui = LiteApp8.Graphics.Axes(NewSlot(main_layout, app_row));
axes_ui.MainFigure = app_window.MainFigure;
axes_ui.ComponentHeight = 400;

% surf(axes_ui.MainAxes, peaks)
contourf(axes_ui.MainAxes, peaks)

colorbar(axes_ui.MainAxes)

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui_1 = LiteApp8.Component.Label(NewSlot(main_layout, app_row));
label_ui_1.MainFigure = app_window.MainFigure;
label_ui_1.Text = CodeTool1.i18n("Row");

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

label_ui_2 = LiteApp8.Component.Label(NewSlot(main_layout, app_row));
label_ui_2.MainFigure = app_window.MainFigure;
label_ui_2.Text = CodeTool1.i18n("Light");
label_ui_2.MainLabel.FontColor = "black";

label_ui_3 = LiteApp8.Component.Label(NewSlot(main_layout, app_row));
label_ui_3.MainFigure = app_window.MainFigure;
label_ui_3.Text = CodeTool1.i18n("Dark");
label_ui_3.MainLabel.FontColor = "white";

% =============================================================================
app_column = NewColumn(main_layout, app_area, Width=320);

% -----------------------------------------------------------------------------
app_row = NewRow(main_layout, app_column);

table_ui = LiteApp8.Component.Table(NewSlot(main_layout, app_row));
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
Show(app_window)

app_window.MainFigure.Theme = "dark";

if nargout > 0
  App.Window = app_window;
end  % if
end  % function
