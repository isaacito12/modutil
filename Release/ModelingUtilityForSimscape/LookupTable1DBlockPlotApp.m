function App = LookupTable1DBlockPlotApp(NameValuePair)

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  NameValuePair.ModelFilePath (1,:) string {mustBeScalarOrEmpty}
end  % arguments

arguments (Output)
  App (1,:) struct
end  % arguments

errorID = "LookupTable1DBlockPlotApp:";

if isfield(NameValuePair, "ModelFilePath")
  if not(isfile(NameValuePair.ModelFilePath))
    id = errorID + "InvalidModelFilePath";
    msg = CodeUtil1.i18n("The file specified for ModelFilePath is not valid.");

    throw(MException(id, msg))

  end  % if
  model_file_path = NameValuePair.ModelFilePath;
else
  model_file_path = "";
end  % if

main_figure = uifigure(Visible="off");

app_window = AppUtil1.AppWindow(main_figure, SourceFile=mfilename);
app_window.Width = 800;
app_window.Height = 500;
app_window.Name = CodeUtil1.i18n("Lookup-Table 1D Block Plot App");

app_column_layout = app_window.MainLayout;

column_grid = NewColumnGrid(app_column_layout);
block_selector_ui = AppUtil1.Component.BlockSelectorUI(column_grid);
block_selector_ui.MainFigure = app_window.MainFigure;
block_selector_ui.GetOnly = true;
block_selector_ui.AutoGet = true;
block_selector_ui.FindBlockCallback = @ModelUtil1.findLookupTable1DBlocks;
block_selector_ui.GetParametersFromBlockCallback = @() get_parameters_from_block();
block_selector_ui.ModelFileFullPath = model_file_path;

column_grid = NewColumnGrid(app_column_layout);
open_fig_win_ui = AppUtil1.Component.Hyperlink(column_grid);
open_fig_win_ui.MainFigure = app_window.MainFigure;
open_fig_win_ui.Text = CodeUtil1.i18n("Open in figure window");
open_fig_win_ui.HorizontalAlignment = "right";
open_fig_win_ui.HyperlinkClickedCallback = @() react_figwin();

column_grid = NewColumnGrid(app_column_layout);
panel_ui = AppUtil1.Graphics.Panel(column_grid);
panel_ui.MainFigure = app_window.MainFigure;
panel_ui.ComponentHeight = 380;

  function react_figwin()
    if not(block_selector_ui.Initialized) || (block_selector_ui.BlockPath == "")

      return

    end  % if
    [~, block_name, ~] = fileparts(block_selector_ui.BlockPath);
    ModelUtil1.plotLookupTable1DBlocks(gcs, Blocks=block_name, ParentType="Axes", ParentAxes=axes(figure))
  end  % nested function

  function get_parameters_from_block()
    if not(block_selector_ui.Initialized) || (block_selector_ui.BlockPath == "")

      return

    end  % if
    [~, block_name, ~] = fileparts(block_selector_ui.BlockPath);
    ModelUtil1.plotLookupTable1DBlocks(gcs, Blocks=block_name, ParentType="Panel", ParentPanel=panel_ui.MainPanel)
  end  % nested function

%%
movegui(main_figure, "center")
main_figure.Visible = "on";
% Call this after Visible="on".
get_parameters_from_block()
drawnow
if nargout > 0
  App.Window = app_window;
end  % if
end  % function
