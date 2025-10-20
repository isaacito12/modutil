function App = apptest_BlockSelectorUI_5_mix
% This is a function-based test app with direct use of uifigure and uigridlayout,
% instead of using AppUtilWindow and its layout property.

% Test:
% Use both TargetSimscapeBlockNames and FindBlockCallback properties to find blocks
% and show in Block path drop down. There should be no duplicate in the items.
% TargetSimscapeBlockNames has both Simscape library block and Simscape Component block.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

% Use getFileFullPath to validate that the specified file is found.
% If not, an error is issued and the app does not open.
modelfile_fullpath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_5_mix.mdl");

% -----------------------------------------------------------------------------
main_figure = uifigure(Visible="off");
main_figure.Position(3) = 1200;  % width
main_figure.Position(4) = 200;  % height

main_layout = uigridlayout(main_figure, [1 1]);
main_layout.RowHeight = {'fit'};
main_layout.ColumnWidth = {'1x'};
main_layout.Padding = [0 0 0 0];
main_layout.ColumnSpacing = 0;
main_layout.RowSpacing = 0;

%% Test the UI component

block_selector_ui = AppUtil1.Component.BlockSelectorUI(main_layout);

% -----------------------------------------------------------------------------
% To make BlockSelectorUI work properly, three properties: MainFigure,
% TargetSimscapeBlockNames, and FindBlockCallback must be configured.

block_selector_ui.MainFigure = main_figure;

% The "Sample Component" specified for TargetSimscapeBlockNames is a custom Simscape component
% which is set in the Simscape Component block.
%
% findLookupTable1DBlocks for FindBlockCallback finds both Simscape and Simulink lookup table blocks.
%
% Notice that the "PS Lookup Table (1D)" block is specified in TargetSimscapeBlockNames and
% FindBlockCallback. The drop down list of the discovered blocks must show only one item for
% one "PS Lookup Table (1D)" block.

block_selector_ui.TargetSimscapeBlockNames = ["Sample Component", "PS Lookup Table (1D)"];  % !test-target
block_selector_ui.FindBlockCallback = @ModelUtil1.findLookupTable1DBlocks;  % !test-target
% -----------------------------------------------------------------------------

block_selector_ui.SetParametersToBlockCallback = @() setp();
block_selector_ui.GetParametersFromBlockCallback = @() getp();

  function setp()
    disp("BlockPath: " + block_selector_ui.BlockPath)
  end  % nested function

  function getp()
    disp("gcb: " + string(gcb))
  end  % nested function

% Set the model file programmatically.
block_selector_ui.ModelFileFullPath = modelfile_fullpath;

%%
movegui(main_figure, "center")
main_figure.Visible = "on";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.BlockSelectorUI = block_selector_ui;
end % if
end  % function
