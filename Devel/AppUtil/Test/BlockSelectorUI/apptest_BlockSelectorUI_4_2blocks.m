function App = apptest_BlockSelectorUI_4_2blocks

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

% !test-target
% BlockSelectorUI should be able to accept two or more blocks to seacrh in
% the specified model and show them in the drop down.
% Texts in the array below must be those returned by get_param(gcb, "MaskType").
target_blockname = [
  "Motor & Drive"
  "Motor & Drive" + newline + "(System Level)"
  ];

if isMATLABReleaseOlderThan("R2025a")
  modelfile_fullpath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_3_motor_24b.mdl");
else
  modelfile_fullpath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_3_motor.mdl");
end

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

block_selector_ui.MainFigure = main_figure;
block_selector_ui.TargetSimscapeBlockNames = target_blockname;  % !test-target

block_selector_ui.GetParametersFromBlockCallback = @() getp();
  function getp()
    % The Get button reports the currently selected block for testing purpose.
    disp("gcb: " + string(gcb))
  end  % nested function

block_selector_ui.SetParametersToBlockCallback = @() setp();
  function setp()
    % The Set button only reports the currently active block path for testing pupsoe.
    disp("SetParametersToBlockCallback| BlockPath: " + block_selector_ui.BlockPath)
  end  % nested function

% Set the model file programmatically.
block_selector_ui.ModelFileFullPath = modelfile_fullpath;

%%
movegui(main_figure, "center")
main_figure.Visible = "on";
drawnow
if nargout > 0
  App = struct;
  App.Window.MainFigure = main_figure;
  App.BlockSelectorUI = block_selector_ui;
end % if
end  % function
