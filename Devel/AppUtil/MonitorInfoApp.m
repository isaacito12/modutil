function App = MonitorInfoApp

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

app_window = AppUtil1.AppUtilWindow(SourceFilename=mfilename);
app_window.Width = 500;
app_window.Height = 400;
app_window.Name = CodeUtil1.i18n("Monitor Info");

build_gui(app_window)

Show(app_window)

drawnow
app_window.MainFigure.Theme = "light";

if nargout > 0
  App = struct;
  App.Window = app_window;
end  % if
end  % function

function build_gui(app_window)
%%
arguments (Input)
  app_window (1,1) AppUtil1.AppUtilWindow
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

% app_position_history = getAppPosTable;

app_layout = app_window.MainLayout;
app_area = NewArea(app_layout);
app_column = NewColumn(app_layout, app_area);

app_row = NewRow(app_layout, app_column);
monitor_info_ui = AppUtil1.Component.Table(NewSlot(app_layout, app_row));
monitor_info_ui.MainTable.Data = monitor_positions;

app_row = NewRow(app_layout, app_column);
button_ui = AppUtil1.Component.Button(NewSlot(app_layout, app_row));
button_ui.Text = CodeUtil1.i18n("Record app position");
button_ui.ButtonWidth = 200;
button_ui.HorizontalAlignment = "center";
button_ui.ButtonPushedCallback = @() react_ButtonPushed();

app_row = NewRow(app_layout, app_column);
app_position_ui = AppUtil1.Component.Table(NewSlot(app_layout, app_row));
app_position_ui.MainTable.Data = getAppPositionTable;

end  % function
