classdef uiTest_AbstractMotorEfficiency < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in this "TestMethodSetup" section always run before
    % each test defined in the "Test" section runs.

    function test_method_setup_1(testcase)
      %%
      % Close all before test
      close all
      bdclose all
      evalin("base", "clearvars")

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAllAfterTest)
      function closeAllAfterTest
        % Close/delete all figure windows. This closes/deletes not only the test targets but also
        % all the other figure windows too to provide clean state for the next test.
        figs = findall(0, Type="Figure");
        if not(any(isempty(figs)))
          disp("Deleting figures (" + numel(figs) + ")")
          delete(figs)
        end  % if

        bdclose all

        % Do not clear variables in the base workspace at the end of a test
        % to make it easy to debug after test if necessary.

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

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @AbstractMotorEfficiency1.AbstractMotorEfficiencyAppMain)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @AbstractMotorEfficiencyApp)
    end  % function

    %% Error case tests

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target(), "AbstractMotorEfficiencyAppMain:InvalidModelName")
      function test_target
        % The model does not exist.
        model_name = "test_test_test";
        AbstractMotorEfficiency1.AbstractMotorEfficiencyAppMain(ModelName=model_name)  % !test-target
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target(), "AbstractMotorEfficiencyAppMain:InvalidModelName")
      function test_target
        % The model name must not be "".
        block_path = "/test";
        AbstractMotorEfficiency1.AbstractMotorEfficiencyAppMain(BlockPath=block_path)  % !test-target
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      % Pass a model which has no Simscape blocks.
      model_filename = "TestUtil_common_model_empty.mdl";
      [~, model_name, ~] = fileparts(model_filename);

      verifyError(testcase, @() test_target(), "AbstractMotorEfficiencyAppMain:SimscapeBlockWasNotFound")
      function test_target
        AbstractMotorEfficiency1.AbstractMotorEfficiencyAppMain(ModelName=model_name)  % !test-target
      end  % nested function
    end  % function

    function Test_error_4(testcase)
      % Pass a model which has Simscape blocks but not the intended block.
      model_filename = "TestUtil_common_model_SimscapeBlocks.mdl";
      [~, model_name, ~] = fileparts(model_filename);

      verifyError(testcase, @() test_target(), "AbstractMotorEfficiencyAppMain:SimscapeBlockWasNotFound")
      function test_target
        AbstractMotorEfficiency1.AbstractMotorEfficiencyAppMain(ModelName=model_name)  % !test-target
      end  % nested function

      if isfile(model_filename)
        delete(model_filename)
        disp("Deleted the temporary model file.")
      end  % if
    end  % function

    function Test_error_5(testcase)
      verifyError(testcase, @() test_target(), "AbstractMotorEfficiencyAppMain:InvalidAppParameterFileName")
      function test_target
        % Specified parameter file does not exist. Some parameter struct name must be specified.
        paramfile_name = "test_test_test";
        AbstractMotorEfficiency1.AbstractMotorEfficiencyAppMain( ...
          AppParameterFileName=paramfile_name, AppParameterStructName="dummy")  % !test-target
      end  % nested function
    end  % function

    function Test_error_6(testcase)
      verifyError(testcase, @() test_target(), "AbstractMotorEfficiencyAppMain:AppParameterStructNameIsRequired")
      function test_target
        paramfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleParams1.m");
        [~, param_basefilename, ~] = fileparts(paramfile_fullpath);
        evalin("base", param_basefilename)
        AbstractMotorEfficiencyApp(AppParameterFileName=paramfile_fullpath)  % !test-target
      end  % nested function
    end  % function

    %% Command option tests

    function command_option_1_1(~)
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleParams1.m");
      [~, param_basefilename, ~] = fileparts(paramfile_fullpath);
      evalin("base", param_basefilename)
      AbstractMotorEfficiencyApp(AppParameterStructName="MotorParams")  % !test-target
    end  % function

    function command_option_1_2(~)
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleParams1.m");
      AbstractMotorEfficiencyApp(AppParameterFileName=paramfile_fullpath, AppParameterStructName="MotorParams")
    end  % function

    function command_option_2_1(~)
      % Test a nested struct.
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleParams2.m");
      AbstractMotorEfficiencyApp(AppParameterFileName=paramfile_fullpath, AppParameterStructName="Params.Motor")
    end  % function

    %% Visual tests
    % These tests need visual inspection.

    function open_in_figure_window_1(testcase)
      app = AbstractMotorEfficiencyApp;
      press(testcase, app.OpenInFigureWindowUI.MainHyperlink)
    end  % function

    %% Gesture tests

    % Visually inspect that the app reacts to (programmatic) user actions.

    function model_parameters_drop_downs_1(testcase)
      app = AbstractMotorEfficiencyApp;

      choose(testcase, app.MaxAngularSpeedModeUI.MainDropDown, "Specify")
      choose(testcase, app.MaxAngularSpeedUI.UnitDropDownUI.DropDownUI.MainDropDown, "rad/s")
      choose(testcase, app.MaxAngularSpeedUI.UnitDropDownUI.DropDownUI.MainDropDown, "rpm")
      type(testcase,   app.MaxAngularSpeedUI.UnitDropDownUI.DropDownUI.MainDropDown, "rev/s")

      choose(testcase, app.MaxTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbf*ft")
      choose(testcase, app.MaxTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m")

      type(testcase, app.MeasuredAngularSpeedUI.ValueTextUI.MainEditField, "1000")

      type(testcase, app.MaxPowerUI.ValueTextUI.MainEditField, "20000")
      choose(testcase, app.MaxPowerUI.UnitDropDownUI.DropDownUI.MainDropDown, "W")
      choose(testcase, app.MaxPowerUI.UnitDropDownUI.DropDownUI.MainDropDown, "kW")
      type(testcase, app.MaxPowerUI.ValueTextUI.MainEditField, "120")

      choose(testcase, app.MeasuredTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbf*ft")
      choose(testcase, app.MeasuredTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m")

      choose(testcase, app.RotorDampingCoefficientUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m/rpm")
      choose(testcase, app.RotorDampingCoefficientUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m/(rad/s)")
      type(testcase,   app.RotorDampingCoefficientUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbf*ft/rpm")
    end  % function

    function plot_customization_drop_downs_1(testcase)
      app = AbstractMotorEfficiencyApp;

      press(testcase, app.PlotAutoRangeUI.MainCheckBox)

      choose(testcase, app.PlotAngularSpeedUpperBoundUI.UnitDropDownUI.DropDownUI.MainDropDown, "rad/s")
      choose(testcase, app.PlotAngularSpeedUpperBoundUI.UnitDropDownUI.DropDownUI.MainDropDown, "rpm")
      type(testcase,   app.PlotAngularSpeedUpperBoundUI.UnitDropDownUI.DropDownUI.MainDropDown, "rev/s")

      choose(testcase, app.PlotTorqueUpperBoundUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbf*ft")
      choose(testcase, app.PlotTorqueUpperBoundUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m")
    end  % function

    function hyperlink_1(testcase)
      app = AbstractMotorEfficiency1.AbstractMotorEfficiencyAppMain;
      press(testcase, app.DescriptionLinkUI.MainHyperlink)
    end  % function

    function update_button_1(testcase)
      app = AbstractMotorEfficiency1.AbstractMotorEfficiencyAppMain;
      press(testcase, app.UpdateButtonUI.ButtonUI.MainButton)
    end  % function

    %% Test with base workspace

    function base_workspace_1(testcase)
      %%
      paramfile1_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleParams1.m");
      [~, param1_basefilename, ~] = fileparts(paramfile1_fullpath);
      evalin("base", param1_basefilename)

      paramfile2_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleParams2.m");
      [~, param2_basefilename, ~] = fileparts(paramfile2_fullpath);
      evalin("base", param2_basefilename)

      app = AbstractMotorEfficiencyApp;

      type(testcase, app.StructParameterUI.StructNameDropDownUI.MainDropDown, "MotorParams")
      type(testcase, app.StructParameterUI.StructNameDropDownUI.MainDropDown, "Params.Motor")

      choose(testcase, app.StructParameterUI.StructNameDropDownUI.MainDropDown, "MotorParams")

      press(testcase, app.StructParameterUI.GetParametersFromBaseWorkspaceUI.MainButton)

      verifyEqual(testcase, app.MaxTorqueUI.ValueText, "MotorParams.MaxTorque")

    end  % function

    function base_workspace_2(testcase)
      %%
      paramfile1_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleParams1.m");
      [~, param1_basefilename, ~] = fileparts(paramfile1_fullpath);
      evalin("base", param1_basefilename)

      app = AbstractMotorEfficiencyApp(AppParameterStructName="MotorParams");

      % "Variable name" UI in the app must contain the struct variable in the base workspace as text.
      verifyEqual(testcase, app.StructParameterUI.StructNameDropDownUI.Value, "MotorParams")

      % Check a couple of UI components.

      verifyEqual(testcase, app.MaxAngularSpeedModeUI.Value, "auto")

      verifyEqual(testcase, app.MaxTorqueUI.ValueText, "MotorParams.MaxTorque")
      verifyEqual(testcase, app.MaxTorqueUI.SimscapeValue, simscape.Value(260, "N*m"))

    end  % function

    %% Test with a model

    function launch_with_model_name_1(~)
      %%
      modelfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleModel_refsub_24b.mdl");
      [~, model_name, ~] = fileparts(modelfile_fullpath);

      AbstractMotorEfficiencyApp(ModelName=model_name)

    end  % function

    function launch_with_block_path_1(~)
      %%
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleParams2.m");
      [~, paramfile_name, ~] = fileparts(paramfile_fullpath);
      evalin("base", paramfile_name)

      modelfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleModel_refsub_24b.mdl");
      [~, model_name, ~] = fileparts(modelfile_fullpath);

      % Specify a block whose parameters are defined in a struct in the base workspace variable.
      block_path = model_name + "/Motor & Drive" + newline + "(System Level)2";

      AbstractMotorEfficiencyApp(BlockPath=block_path)

    end  % function

    function get_set_parameters_with_model_1(testcase)
      %%
      % Test with the first Motor & Drive (System Level) block.

      modelfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleModel_refsub_24b.mdl");
      [~, model_name, ~] = fileparts(modelfile_fullpath);

      app = AbstractMotorEfficiencyApp(ModelName=model_name);

      % !test-target: Select the first block.
      logical_index = endsWith(app.AppBlockSelectorUI.BlockPathDropDownUI.Items, "(System Level)1");
      choose(testcase, app.AppBlockSelectorUI.BlockPathDropDownUI.MainDropDown, find(logical_index))

      press(testcase, app.AppBlockSelectorUI.GetParametersFromBlockUI.MainButton)  % !test-target

      press(testcase, app.AppBlockSelectorUI.SetParametersToBlockUI.MainButton)  % !test-target

    end  % function

    function get_set_parameters_with_model_2(testcase)
      %%
      % Test with a block containing simscape.Value objects for the block parameters.
      % Parameters must be loaded in the base workspace.

      paramfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleParams2.m");
      [~, paramfile_name, ~] = fileparts(paramfile_fullpath);
      evalin("base", paramfile_name)

      modelfile_fullpath = mus1.FileUtil.getFileFullPath("AbstractMotorEfficiency_SampleModel_refsub_24b.mdl");
      [~, model_name, ~] = fileparts(modelfile_fullpath);

      app = AbstractMotorEfficiencyApp(ModelName=model_name);

      % !test-target: Select the second block with workspace variable references.
      logical_index = endsWith(app.AppBlockSelectorUI.BlockPathDropDownUI.Items, "(System Level)2");
      choose(testcase, app.AppBlockSelectorUI.BlockPathDropDownUI.MainDropDown, find(logical_index))

      press(testcase, app.AppBlockSelectorUI.GetParametersFromBlockUI.MainButton)  % !test-target

      press(testcase, app.AppBlockSelectorUI.SetParametersToBlockUI.MainButton)  % !test-target

    end  % function

    %% Test sample models

    function button_in_sample_model_1(testcase)
      if isMATLABReleaseOlderThan("R2026a")
        disp("Skipping this test in R2025b and older.")

        return

      end  % if
      % Test the command in the ClickFcn of a Callback Button.
      % Rather than clicking the button programmatically, get the command text and evaluate it.

      model_name = "AbstractMotorEfficiency_SampleModel_refsub_24b";
      block_path = model_name + "/Open Abstract Motor Efficiency app";

      load_system(model_name)

      pause(1)  % !todo: This pause must be eliminated.

      open_system(block_path);

      pause(1)  % !todo: This pause must be eliminated.

      % Theoretically, get_param must return a non-empty char array here.
      command_text = get_param(block_path, "ClickFcn");

      disp("Command text in the block: " + command_text)

      verifyTrue(testcase, not(isempty(command_text)))  % !flaky-test: 24b

      if contains(command_text, "bdroot")
        % "bdroot" in the command text is not expanded by eval to the model name.
        command_text = replace(command_text, "bdroot", """" + model_name + """");
      end  % if

      disp("Command text to test: " + command_text)
      eval(command_text)  % !test-target

    end  % function

  end  % methods
end  % classdef
