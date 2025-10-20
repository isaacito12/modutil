function App = apptest_BlockSelectorUI_2_preselect_block
% This is a function-based test app with direct use of uifigure and uigridlayout,
% instead of using AppUtilWindow and its layout property.

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

% Use getFileFullPath to validate that the specified file is found.
% If not, an error is issued and the app does not open.
modelfile_fullpath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric.mdl");

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

block_selector_ui = AppUtil1.Component.BlockSelectorUI(main_layout);  % !test-target

% To make BlockSelectorUI work properly, the following essential properties must be defined.
block_selector_ui.MainFigure = main_figure;  % !test-target
block_selector_ui.TargetSimscapeBlockNames = "Rotational Friction";  % !test-target
block_selector_ui.SetParametersToBlockCallback = @() setp();  % !test-target
block_selector_ui.GetParametersFromBlockCallback = @() getp();  % !test-target

  function setp()
    disp("BlockPath: " + block_selector_ui.BlockPath)
  end  % nested function

  function getp()
    disp("gcb: " + string(gcb))
  end  % nested function

% Optionally, set the model file programmatically.
% The app starts with the model preloaded.
block_selector_ui.ModelFileFullPath = modelfile_fullpath;  % !test-target

% Optionally, select the target block path programmatically.
block_selector_ui.BlockPath = "samplemodel_BlockSelectorUI_test_1_fric/Subsystem/Rotational Friction2";  % !test-target

% Optionally, press the Highlight button programmatically.
% This opens the model and highlights the target block.
openSystemWithBlockHighlight(block_selector_ui)  % !test-target

%%
movegui(main_figure, "center")
main_figure.Visible = "on";

if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.BlockSelectorUI = block_selector_ui;
end % if
end  % function
