classdef uiTest_BlockSelectorUI < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2025-2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in this "TestMethodSetup" section always run before
    % each test defined in the "Test" section runs.

    function test_method_setup_1(testcase)
      %%
      % Close all before test
      close all
      bdclose all

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAllAfterTest)
      function closeAllAfterTest
        % Close all figure windows. This closes not only the test targets but also other figure windows.
        figs = findall(0, Type="Figure");
        if not(any(isempty(figs)))
          disp("Deleting figures (" + numel(figs) + ")")
          delete(figs)
        end  % if
        bdclose all
      end  % nested function
    end  % function

  end  % methods

  methods (Test)
    % Functions in the Test section are the tests.
    % Before a function in this section runs, the functions defined in the TestMethodSetup section run.

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function app_launches_without_warnings_1(testcase)
      verifyWarningFree(testcase, @DemoApp_BlockSelectorUI_1_simplest)
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @DemoApp_BlockSelectorUI_2_preselect_block)
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @DemoApp_BlockSelectorUI_3_preload_2models)
    end  % function

    function app_launches_without_warnings_4(testcase)
      verifyWarningFree(testcase, @DemoApp_BlockSelectorUI_4_2blocks)
    end  % function

    function app_launches_without_warnings_5(testcase)
      verifyWarningFree(testcase, @DemoApp_BlockSelectorUI_5_mix)
    end  % function

    %% Test

    function invalid_model(testcase)
      %%

      main_figure = uifigure(Visible="off");
      main_figure.Position(3) = 1200;  % width
      main_figure.Position(4) = 200;  % height

      layout = uigridlayout(main_figure, [1 1]);
      layout.RowHeight = {'fit'};
      layout.ColumnWidth = {'1x'};
      layout.Padding = [0 0 0 0];
      layout.ColumnSpacing = 0;
      layout.RowSpacing = 0;

      % ------------------------------------------------------------------------
      % Build test target

      block_selector_ui = AppUtil1.Component.BlockSelectorUI(layout);

      block_selector_ui.MainFigure = main_figure;

      % Specify a block which is not used in the model.
      block_selector_ui.TargetSimscapeBlockNames = "Rotational Friction";  % !test-target

      function issue_error()
        % This assignment checks that the target block exists in the specified model.
        if isMATLABReleaseOlderThan("R2025a")
          block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_6_invalid_24b.mdl");  % !test-target
        else
          block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_6_invalid.mdl");  % !test-target
        end  % if
      end  % nested function

      verifyError(testcase, @() issue_error(), "BlockSelectorUI:BlockNotFound")

    end  % function

    function duplicate_model_paths(testcase)
      %%
      % Attempt to set 2 model files multiple times to the Model file drop down.
      % Duplicate items must not be created, and the code should work without error.
      % The drop down must have only 3 items consisting of 1 empty item and 2 model file items.

      main_figure = uifigure(Visible="off");
      main_figure.Position(3) = 1200;  % width
      main_figure.Position(4) = 200;  % height

      layout = uigridlayout(main_figure, [1 1]);
      layout.RowHeight = {'fit'};
      layout.ColumnWidth = {'1x'};
      layout.Padding = [0 0 0 0];
      layout.ColumnSpacing = 0;
      layout.RowSpacing = 0;

      % ------------------------------------------------------------------------
      % Build test target

      block_selector_ui = AppUtil1.Component.BlockSelectorUI(layout);
      % block_selector_ui.Reporting = "on";

      block_selector_ui.MainFigure = main_figure;  % !test-target
      block_selector_ui.TargetSimscapeBlockNames = "Rotational Friction";  % !test-target

      if isMATLABReleaseOlderThan("R2025a")
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric_24b.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric_24b.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_2_fric2_24b.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_2_fric2_24b.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric_24b.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_2_fric2_24b.mdl");  % !test-target
      else
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_2_fric2.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_2_fric2.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_1_fric.mdl");  % !test-target
        block_selector_ui.ModelFileFullPath = FileUtil1.getFileFullPath("samplemodel_BlockSelectorUI_test_2_fric2.mdl");  % !test-target
      end  % if

      movegui(main_figure, "center")
      main_figure.Visible = "on";
      drawnow

      % ------------------------------------------------------------------------
      % Do test

      % 1 empty item and 2 model file paths.
      expected = 3;

      items = block_selector_ui.ModelFileDropDownUI.MainDropDown.Items;
      actual = numel(items);

      verifyEqual(testcase, actual, expected)

    end  % function

    function invalid_model_file(testcase)
      %%

      main_figure = uifigure(Visible="off");
      main_figure.Position(3) = 1200;  % width
      main_figure.Position(4) = 200;  % height

      layout = uigridlayout(main_figure, [1 1]);
      layout.RowHeight = {'fit'};
      layout.ColumnWidth = {'1x'};
      layout.Padding = [0 0 0 0];
      layout.ColumnSpacing = 0;
      layout.RowSpacing = 0;

      block_selector_ui = AppUtil1.Component.BlockSelectorUI(layout);
      block_selector_ui.Reporting = "on";

      block_selector_ui.MainFigure = main_figure;
      block_selector_ui.TargetSimscapeBlockNames = "Rotational Friction";

      function badcode()
        block_selector_ui.ModelFileFullPath = "not_a_model_file_path";  % !test-target
      end  % nested function

      verifyError(testcase, @() badcode(), "BlockSelectorUI:InvalidFile")

    end  % function

    %% Gesture test

    function Gesture_Highlight_Block(testcase)
      % The app programmatically opens a model.
      app = DemoApp_BlockSelectorUI_2_preselect_block;  % !test-target

      % Clicking "Highlight" button must work with the block in the opened model.
      press(testcase, app.BlockSelectorUI_1.HilitBlockUI.MainButton)  % !test-target
      press(testcase, app.BlockSelectorUI_1.HilitBlockUI.MainButton)  % !test-target
      press(testcase, app.BlockSelectorUI_1.HilitBlockUI.MainButton)  % !test-target
    end  % function

    function Gesture_Model_Dropdown(testcase)
      %% Open model, select block from drop down.

      % The app programmatically opens a model containing Rotational Friction blocks.
      app = DemoApp_BlockSelectorUI_2_preselect_block;
      % app.BlockSelectorUI_1.Reporting = "on";

      dropdown_items = app.BlockSelectorUI_1.BlockPathDropDownUI.Items;
      block_paths = replace(dropdown_items, " / ", "/");

      % There are 9 Rotational Friction blocks in the model.
      % The drop down has an empty item too.
      verifyTrue(testcase, numel(dropdown_items) == 10)

      % First drop down item is "".
      ii = 1;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))
      verifyTrue(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown.Value == "")  % !test-target

      % Test with Rotational Friction blocks.
      % Validate that gcb (modified by the Get button) matches the drop down item.
      ii = 2;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))  % !test-target
      press(testcase, app.BlockSelectorUI_1.GetParametersFromBlockUI.MainButton)  % !test-target
      actual = string(gcb);  % Updated by the button.
      expected = block_paths(ii);  % Updated by the drop down.
      verifyEqual(testcase, actual, expected)

      % Select the empty item.
      ii = 1;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))
      verifyTrue(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown.Value == "")  % !test-target

      % Select a valid model path again.
      ii = 8;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))  % !test-target

    end  % function

    function Gesture_Get_button(testcase)
      %% Open model, select block from drop down, and click "Get" button.

      % The app programmatically opens a model containing Rotational Friction blocks.
      app = DemoApp_BlockSelectorUI_2_preselect_block;
      % app.BlockSelectorUI_1.Reporting = "on";

      dropdown_items = app.BlockSelectorUI_1.BlockPathDropDownUI.Items;
      block_paths = replace(dropdown_items, " / ", "/");

      % There are 9 Rotational Friction blocks in the model.
      % The drop down has an empty item too.
      verifyTrue(testcase, numel(dropdown_items) == 10)

      % First drop down item is "".

      ii = 1;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))
      verifyTrue(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown.Value == "")  % !test-target

      % Test with Rotational Friction blocks.
      % Validate that gcb (modified by the Get button) matches the drop down item.

      ii = 2;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))  % !test-target
      press(testcase, app.BlockSelectorUI_1.GetParametersFromBlockUI.MainButton)  % !test-target
      actual = string(gcb);  % Updated by the button.
      expected = block_paths(ii);  % Updated by the drop down.
      verifyEqual(testcase, actual, expected)

      ii = 6;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))  % !test-target
      press(testcase, app.BlockSelectorUI_1.GetParametersFromBlockUI.MainButton)  % !test-target
      actual = string(gcb);  % Updated by the button.
      expected = block_paths(ii);  % Updated by the drop down.
      verifyEqual(testcase, actual, expected)

      ii = 10;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))  % !test-target
      press(testcase, app.BlockSelectorUI_1.GetParametersFromBlockUI.MainButton)  % !test-target
      actual = string(gcb);  % Updated by the button.
      expected = block_paths(ii);  % Updated by the drop down.
      verifyEqual(testcase, actual, expected)

    end  % function

    function Gesture_Set_button(testcase)
      %% Open model, select block from drop down, and click "Set" button.

      % The test app 2 internally opens the BlockSelector_test_model.
      app = DemoApp_BlockSelectorUI_2_preselect_block;
      % app.BlockSelectorUI_1.Reporting = "on";

      dropdown_items = app.BlockSelectorUI_1.BlockPathDropDownUI.Items;
      block_paths = replace(dropdown_items, " / ", "/");

      % There are 9 Rotational Friction blocks in the model.
      % The drop down has an empty item too.
      verifyTrue(testcase, numel(dropdown_items) == 10)

      % Validate that BlockPath property (modified by the Set button) matches the drop down item.

      ii = 3;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))  % !test-target
      press(testcase, app.BlockSelectorUI_1.SetParametersToBlockUI.MainButton)  % !test-target
      actual = app.BlockSelectorUI_1.BlockPath;  % Updated by the button.
      expected = block_paths(ii);  % Updated by the drop down.
      verifyEqual(testcase, actual, expected)

      ii = 7;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))  % !test-target
      press(testcase, app.BlockSelectorUI_1.SetParametersToBlockUI.MainButton)  % !test-target
      actual = app.BlockSelectorUI_1.BlockPath;  % Updated by the button.
      expected = block_paths(ii);  % Updated by the drop down.
      verifyEqual(testcase, actual, expected)

      ii = 9;
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(ii))  % !test-target
      press(testcase, app.BlockSelectorUI_1.SetParametersToBlockUI.MainButton)  % !test-target
      actual = app.BlockSelectorUI_1.BlockPath;  % Updated by the button.
      expected = block_paths(ii);  % Updated by the drop down.
      verifyEqual(testcase, actual, expected)

    end  % function

    function Gesture_Highlight_button(testcase)
      %% Open model, press "Highlight" button, and select block from drop down.
      % This test needs visual inspection.
      % In automated environment, this test only tests that there is no error in
      % the prescribed actions.

      % The app programmatically opens a model.
      app = DemoApp_BlockSelectorUI_2_preselect_block;
      % app.BlockSelectorUI_1.Reporting = "on";

      dropdown_items = app.BlockSelectorUI_1.BlockPathDropDownUI.Items;

      % There are 9 Rotational Friction blocks in the model.
      % The drop down has an empty item too.
      verifyTrue(testcase, numel(dropdown_items) == 10)
      verifyTrue(testcase, numel(dropdown_items) == 10)

      % Click "Highlight" button to set it to the "Pressed" state.
      press(testcase, app.BlockSelectorUI_1.HilitBlockUI.MainButton)  % !test-target

      % Select block from the drop down.
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(2))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(3))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(4))  % !test-target

      % Click "Highlight" button to set it to the "Unpressed" state.
      press(testcase, app.BlockSelectorUI_1.HilitBlockUI.MainButton)  % !test-target

      % Select block from the drop down.
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(2))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(3))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(4))  % !test-target

      % Click "Highlight" button to set it to the "Pressed" state.
      press(testcase, app.BlockSelectorUI_1.HilitBlockUI.MainButton)  % !test-target

      % Select block from the drop down.
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(5))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(6))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(7))  % !test-target

      % Click "Highlight" button to set it to the "Unpressed" state.
      press(testcase, app.BlockSelectorUI_1.HilitBlockUI.MainButton)  % !test-target

      % Select block from the drop down.
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(5))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(6))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(7))  % !test-target

      % Click "Highlight" button to set it to the "Pressed" state.
      press(testcase, app.BlockSelectorUI_1.HilitBlockUI.MainButton)  % !test-target

      % Select block from the drop down.
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(8))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(9))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(10))  % !test-target

      % Click "Highlight" button to set it to the "Unpressed" state.
      press(testcase, app.BlockSelectorUI_1.HilitBlockUI.MainButton)  % !test-target

      % Select block from the drop down.
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(8))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(9))  % !test-target
      choose(testcase, app.BlockSelectorUI_1.BlockPathDropDownUI.MainDropDown, dropdown_items(10))  % !test-target

    end  % function

  end  % methods
end  % classdef
