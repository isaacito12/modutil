function App = MonitorInfoApp

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 500;
app_window.Height = 400;
app_window.Name = CodeUtil1.i18n("Monitor Info");

build_gui(app_window)

if not(isMATLABReleaseOlderThan("R2025a"))
  app_window.MainFigure.Theme = "light";
end  % if

movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window = app_window;
end  % if
end  % function

function build_gui(app_window)
%%
arguments (Input)
  app_window (1,1) AppUtil1.AppWindow
end  % arguments

  function react_ButtonPushed()
    app_position_ui.MainTable.Data = vertcat(app_position_ui.MainTable.Data, getAppPositionTable);
  end  % function

  function t = getAppPositionTable()
    info = app_window.MainFigure.Position;
    AppLeft = info(:, 1);
    AppBottom = info(:, 2);
    AppWidth = info(:, 3);
    AppHeight = info(:, 4);
    t = table(AppLeft, AppBottom, AppWidth, AppHeight);
  end  % function

% See the documentation for the MonitorPositions property.
% https://www.mathworks.com/help/matlab/ref/matlab.ui.root-properties.html
info = floor(get(groot, "MonitorPositions"));
MonitorLeft = info(:, 1);
MonitorBottom = info(:, 2);
MonitorWidth = info(:, 3);
MonitorHeight = info(:, 4);
monitor_positions = table(MonitorLeft, MonitorBottom, MonitorWidth, MonitorHeight);

app_vertical_container = app_window.MainVerticalContainer;

column_grid = addVerticalGridLayout(app_vertical_container);
monitor_info_ui = AppUtil1.Component.Table(column_grid);
monitor_info_ui.MainTable.Data = monitor_positions;

column_grid = addVerticalGridLayout(app_vertical_container);
button_ui = AppUtil1.Component.Button(column_grid);
button_ui.Text = CodeUtil1.i18n("Record app position");
button_ui.ButtonWidth = 200;
button_ui.HorizontalAlignment = "center";
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

column_grid = addVerticalGridLayout(app_vertical_container);
app_position_ui = AppUtil1.Component.Table(column_grid);
app_position_ui.MainTable.Data = getAppPositionTable;

end  % function
