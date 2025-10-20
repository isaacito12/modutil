function App = LookupTable1DBlockPlotApp(NameValuePair)

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  NameValuePair.ModelFilePath (1,1) string {mustBeFile} = "ModelUtil/Test/plotLookupTable1DBlocks/testmodel_plotLookupTable1DBlocks_refsub.mdl"
end

arguments (Output)
  App (1,:) struct
end  % arguments

app_window = AppUtil1.AppUtilWindow(SourceFilename=mfilename);
app_window.Width = 800;
app_window.Height = 500;
app_window.Name = CodeUtil1.i18n("Lookup-Table 1D Block Plot App");

app_layout = app_window.MainLayout;
app_area = NewArea(app_layout);
app_column = NewColumn(app_layout, app_area);

app_row = NewRow(app_layout, app_column);
block_selector_ui = AppUtil1.Component.BlockSelectorUI(NewSlot(app_layout, app_row));
block_selector_ui.MainFigure = app_window.MainFigure;
block_selector_ui.GetOnly = true;
block_selector_ui.AutoGet = true;
block_selector_ui.FindBlockCallback = @ModelUtil1.findLookupTable1DBlocks;
block_selector_ui.GetParametersFromBlockCallback = @() get_parameters_from_block();
block_selector_ui.ModelFileFullPath = NameValuePair.ModelFilePath;

app_row = NewRow(app_layout, app_column);
open_fig_win_ui = AppUtil1.Component.Hyperlink(NewSlot(app_layout, app_row));
open_fig_win_ui.MainFigure = app_window.MainFigure;
open_fig_win_ui.Text = CodeUtil1.i18n("Open in figure window");
open_fig_win_ui.HorizontalAlignment = "right";
open_fig_win_ui.HyperlinkClickedCallback = @() react_figwin();

app_row = NewRow(app_layout, app_column);
panel_ui = AppUtil1.Graphics.Panel(NewSlot(app_layout, app_row));
panel_ui.MainFigure = app_window.MainFigure;
panel_ui.ComponentHeight = 380;

  function react_figwin()
    if not(block_selector_ui.Initialized)
      return
    end  % if
    [~, block_name, ~] = fileparts(gcb);
    ModelUtil1.plotLookupTable1DBlocks(gcs, Blocks=block_name, ParentType="Axes", ParentAxes=axes(figure))
  end  % nested function

  function get_parameters_from_block()
    if not(block_selector_ui.Initialized)
      return
    end  % if
    [~, block_name, ~] = fileparts(gcb);
    ModelUtil1.plotLookupTable1DBlocks(gcs, Blocks=block_name, ParentType="Panel", ParentPanel=panel_ui.MainPanel)
  end  % nested function

%%
Show(app_window)

% Call this after the Show.
get_parameters_from_block()

if nargout > 0
  App.Window = app_window;
end  % if
end  % function
