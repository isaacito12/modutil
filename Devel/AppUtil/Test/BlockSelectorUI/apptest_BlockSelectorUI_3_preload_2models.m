function App = apptest_BlockSelectorUI_3_preload_2models

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

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

block_selector_ui.MainFigure = main_figure;  % !test-target
block_selector_ui.TargetSimscapeBlockNames = "Rotational Friction";  % !test-target

% Add two models to the drop down.
if isMATLABReleaseOlderThan("R2025a")
  block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric_24b.mdl");  % !test-target
  block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_2_fric2_24b.mdl");  % !test-target
else
  block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric.mdl");  % !test-target
  block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_2_fric2.mdl");  % !test-target
end  % if

% Select an existing item to make it the current in the drop down.
if isMATLABReleaseOlderThan("R2025a")
  block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric_24b.mdl");  % !test-target
else
  block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric.mdl");  % !test-target
end  % if

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
