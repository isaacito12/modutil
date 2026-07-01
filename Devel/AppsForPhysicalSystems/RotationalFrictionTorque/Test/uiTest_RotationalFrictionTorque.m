classdef uiTest_RotationalFrictionTorque < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2024-2026 The MathWorks, Inc.

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

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @RotationalFrictionTorque1.RotationalFrictionTorqueAppMain)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @RotationalFrictionTorqueApp)
    end  % function

    %% Error case tests

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "RotationalFrictionTorqueAppMain:AppParameterStructNameIsRequired")
      function test_target
        paramfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams1.m");
        [~, param_basefilename, ~] = fileparts(paramfile_fullpath);
        evalin("base", param_basefilename)
        RotationalFrictionTorqueApp(AppParameterFileName=paramfile_fullpath)  % !test-target
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target, "RotationalFrictionTorqueAppMain:InvalidModelName")
      function test_target
        % The model does not exist.
        model_name = "test_test_test";
        RotationalFrictionTorque1.RotationalFrictionTorqueAppMain(ModelName=model_name)  % !test-target
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @() test_target, "RotationalFrictionTorqueAppMain:InvalidModelName")
      function test_target
        % The model name must not be "".
        block_path = "/test";
        RotationalFrictionTorque1.RotationalFrictionTorqueAppMain(BlockPath=block_path)  % !test-target
      end  % nested function
    end  % function

    function Test_error_4(testcase)
      % Pass a model which has no Simscape blocks.
      model_filename = "TestUtil_common_model_empty.mdl";
      [~, model_name, ~] = fileparts(model_filename);

      verifyError(testcase, @() test_target, "RotationalFrictionTorqueAppMain:SimscapeBlockWasNotFound")
      function test_target
        RotationalFrictionTorque1.RotationalFrictionTorqueAppMain(ModelName=model_name)  % !test-target
      end  % nested function
    end  % function

    function Test_error_5(testcase)
      % Pass a model which has Simscape blocks but not the intended block.
      model_filename = "TestUtil_common_model_SimscapeBlocks.mdl";
      [~, model_name, ~] = fileparts(model_filename);

      verifyError(testcase, @() test_target, "RotationalFrictionTorqueAppMain:SimscapeBlockWasNotFound")
      function test_target
        RotationalFrictionTorque1.RotationalFrictionTorqueAppMain(ModelName=model_name)  % !test-target
      end  % nested function
    end  % function

    function Test_error_6(testcase)
      verifyError(testcase, @() test_target, "RotationalFrictionTorqueAppMain:InvalidAppParameterFileName")
      function test_target
        % Specified parameter file does not exist. Some parameter struct name must be specified.
        paramfile_name = "test_test_test";
        RotationalFrictionTorque1.RotationalFrictionTorqueAppMain(AppParameterFileName=paramfile_name, AppParameterStructName="dummy")  % !test-target
      end  % nested function
    end  % function

    function Test_error_7_InvalidBlockPath(testcase)
      % Model has Rotational Friction blocks, but specified BlockPath is not among them.
      model_name = "RotationalFrictionTorque_SampleModel_refsub_24b";
      block_path = model_name + "/NonExistentFrictionBlock";
      verifyError(testcase, @() test_target, "RotationalFrictionTorqueAppMain:InvalidBlockPath")
      function test_target
        RotationalFrictionTorque1.RotationalFrictionTorqueAppMain(BlockPath=block_path)
      end  % nested function
    end  % function

    function Test_error_8_ParamFileEvalFailure(testcase)
      % Parameter file exists but throws an error when evaluated.
      temp_file = fullfile(tempdir, "bad_rot_fric_param_file.m");
      fid = fopen(temp_file, "w");
      fprintf(fid, "error('Intentional test error');\n");
      fclose(fid);
      addpath(tempdir)
      addTeardown(testcase, @() cleanup())
      function cleanup
        rmpath(tempdir)
        if isfile(temp_file), delete(temp_file); end
      end  % nested function

      verifyError(testcase, @() test_target, ?MException)
      function test_target
        RotationalFrictionTorque1.RotationalFrictionTorqueAppMain( ...
          AppParameterFileName=temp_file, AppParameterStructName="dummy")
      end  % nested function
    end  % function

    function updateApp_error_recovery(testcase)
      % Trigger updateDataSet failure via incompatible plot unit to exercise catch block.
      app = RotationalFrictionTorqueApp;

      % Type an incompatible unit into the angular velocity plot unit dropdown.
      % "N*m" is a torque unit, not an angular velocity unit.
      % This will cause the DataSet property assignment to fail,
      % which is caught by the try/catch in updateApp.
      type(testcase, app.PlotAngularVelocityUnitUI.DropDownUI.MainDropDown, "kg")

      % App should show uialert but not crash.
      verifyTrue(testcase, isvalid(app.MainFigure))
    end  % function

    %% Tests

    function command_option_1_1(~)
      % Use a base workspace variable to set up the app.
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams1.m");
      [~, param_basefilename, ~] = fileparts(paramfile_fullpath);
      evalin("base", param_basefilename)
      RotationalFrictionTorqueApp(AppParameterStructName="FrictionParams1")  % !test-target
    end  % function

    function command_option_1_2(~)
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams1.m");
      RotationalFrictionTorqueApp(AppParameterFileName=paramfile_fullpath, AppParameterStructName="FrictionParams1")
    end  % function

    function command_option_2_1(~)
      % Use a base workspace variable to set up the app.
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams2.m");
      RotationalFrictionTorqueApp(AppParameterFileName=paramfile_fullpath, AppParameterStructName="Params.Friction2")
    end  % function

    function command_option_3_paramfile_with_block(~)
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams1.m");
      model_name = "RotationalFrictionTorque_SampleModel_refsub_24b";
      block_path = model_name + "/Rotational Friction1";
      RotationalFrictionTorqueApp( ...
        AppParameterFileName=paramfile_fullpath, ...
        AppParameterStructName="FrictionParams1", ...
        BlockPath=block_path)
    end  % function

    function open_in_figure_window_1(testcase)
      app = RotationalFrictionTorqueApp;
      press(testcase, app.OpenInFigureWindowUI.MainHyperlink)
    end  % function

    function model_parameters_drop_downs_1(testcase)
      app = RotationalFrictionTorqueApp;

      choose(testcase, app.BreakawayTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbf*ft")
      choose(testcase, app.BreakawayTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m")
      type(testcase,   app.BreakawayTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "mN*in")

      choose(testcase, app.BreakawayVelocityUI.UnitDropDownUI.DropDownUI.MainDropDown, "rad/s")
      choose(testcase, app.BreakawayVelocityUI.UnitDropDownUI.DropDownUI.MainDropDown, "rev/s")
      type(testcase,   app.BreakawayVelocityUI.UnitDropDownUI.DropDownUI.MainDropDown, "rev/min")

      choose(testcase, app.CoulombTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbf*ft")
      choose(testcase, app.CoulombTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m")
      type(testcase,   app.CoulombTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "mN*in")

      choose(testcase, app.ViscousCoefficientUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m/rpm")
      choose(testcase, app.ViscousCoefficientUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m/(rad/s)")
      type(testcase,   app.ViscousCoefficientUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbf*ft/rpm")
    end  % function

    function derived_parameters_drop_downs_1(testcase)
      app = RotationalFrictionTorqueApp;

      choose(testcase, app.StribeckScaledTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbf*ft")
      choose(testcase, app.StribeckScaledTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "N*m")
      type(testcase,   app.StribeckScaledTorqueUI.UnitDropDownUI.DropDownUI.MainDropDown, "mN*in")

      choose(testcase, app.StribeckThresholdVelocityUI.UnitDropDownUI.DropDownUI.MainDropDown, "rad/s")
      choose(testcase, app.StribeckThresholdVelocityUI.UnitDropDownUI.DropDownUI.MainDropDown, "rev/s")
      type(testcase,   app.StribeckThresholdVelocityUI.UnitDropDownUI.DropDownUI.MainDropDown, "rev/min")

      choose(testcase, app.CoulombThresholdVelocityUI.UnitDropDownUI.DropDownUI.MainDropDown, "rad/s")
      choose(testcase, app.CoulombThresholdVelocityUI.UnitDropDownUI.DropDownUI.MainDropDown, "rev/s")
      type(testcase,   app.CoulombThresholdVelocityUI.UnitDropDownUI.DropDownUI.MainDropDown, "rev/min")
    end  % function

    function plot_customization_check_boxes_1(testcase)
      app = RotationalFrictionTorqueApp;

      press(testcase, app.ShowStribeckTorqueUI.MainCheckBox)
      press(testcase, app.ShowCoulombTorqueUI.MainCheckBox)
      press(testcase, app.ShowViscousTorqueUI.MainCheckBox)

      press(testcase, app.ShowStribeckTorqueUI.MainCheckBox)
      press(testcase, app.ShowStribeckTorqueUI.MainCheckBox)

      press(testcase, app.ShowCoulombTorqueUI.MainCheckBox)
      press(testcase, app.ShowCoulombTorqueUI.MainCheckBox)

      press(testcase, app.ShowViscousTorqueUI.MainCheckBox)
      press(testcase, app.ShowViscousTorqueUI.MainCheckBox)
    end  % function

    function plot_customization_drop_downs_1(testcase)
      app = RotationalFrictionTorqueApp;

      choose(testcase, app.PlotAngularVelocityUnitUI.DropDownUI.MainDropDown, "rpm")
      choose(testcase, app.PlotAngularVelocityUnitUI.DropDownUI.MainDropDown, "rev/s")
      type(testcase,   app.PlotAngularVelocityUnitUI.DropDownUI.MainDropDown, "rev/min")

      choose(testcase, app.PlotTorqueUnitUI.DropDownUI.MainDropDown, "lbf*ft")
      type(testcase,   app.PlotTorqueUnitUI.DropDownUI.MainDropDown, "mN*in")
    end  % function

    %% Test with base workspace

    function base_workspace_1(testcase)

      paramfile1_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams1.m");
      [~, param1_basefilename, ~] = fileparts(paramfile1_fullpath);
      evalin("base", param1_basefilename)

      paramfile2_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams2.m");
      [~, param2_basefilename, ~] = fileparts(paramfile2_fullpath);
      evalin("base", param2_basefilename)

      app = RotationalFrictionTorqueApp;

      type(testcase, app.StructParameterUI.StructNameDropDownUI.MainDropDown, "FrictionParams1")
      type(testcase, app.StructParameterUI.StructNameDropDownUI.MainDropDown, "Params.Friction2")

      choose(testcase, app.StructParameterUI.StructNameDropDownUI.MainDropDown, "FrictionParams1")

      press(testcase, app.StructParameterUI.GetParametersFromBaseWorkspaceUI.MainButton)

      verifyEqual(testcase, app.BreakawayTorqueUI.ValueText, "FrictionParams1.BreakawayTorque")

    end  % function

    function base_workspace_with_invalid_struct(testcase)
      % Load a struct that has fields not matching the app's expected field names.
      evalin("base", "BadFrictionStruct.NonExistentField = simscape.Value(1, 'N*m');")
      addTeardown(testcase, @() evalin("base", "clear BadFrictionStruct"))

      app = RotationalFrictionTorqueApp;

      type(testcase, app.StructParameterUI.StructNameDropDownUI.MainDropDown, "BadFrictionStruct")
      press(testcase, app.StructParameterUI.GetParametersFromBaseWorkspaceUI.MainButton)

      % App should not crash; fields that don't match are skipped via the catch block.
      verifyTrue(testcase, isvalid(app.MainFigure))
    end  % function

    function load_params_empty_struct_name(testcase)
      %% Press Get Parameters with empty struct name -- should return early without error.
      app = RotationalFrictionTorqueApp;

      % Struct name dropdown is empty by default -- just press the button.
      press(testcase, app.StructParameterUI.GetParametersFromBaseWorkspaceUI.MainButton)

      % App must not crash; figure remains valid.
      verifyTrue(testcase, isvalid(app.MainFigure))
    end  % function

    %% Test with a model

    function launch_with_model_name_1(~)
      %%
      modelfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleModel_refsub_24b.mdl");
      [~, model_name, ~] = fileparts(modelfile_fullpath);

      RotationalFrictionTorqueApp(ModelName=model_name)

    end  % function

    function launch_with_block_path_1(~)
      %%
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams2.m");
      [~, paramfile_name, ~] = fileparts(paramfile_fullpath);
      evalin("base", paramfile_name)

      modelfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleModel_refsub_24b.mdl");
      [~, model_name, ~] = fileparts(modelfile_fullpath);

      % Specify a block whose parameters are defined in a struct in the base workspace variable.
      block_path = model_name + "/Rotational Friction2";

      RotationalFrictionTorqueApp(BlockPath=block_path)

    end  % function

    function get_set_parameters_with_model_1(testcase)
      %%
      % Test with a block containing numbers for the block parameters.

      modelfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleModel_refsub_24b.mdl");
      [~, model_name, ~] = fileparts(modelfile_fullpath);

      app = RotationalFrictionTorqueApp(ModelName=model_name);

      % !test-target: Select a block containing numbers for the block parameters.
      logical_index = endsWith(app.AppBlockSelectorUI.BlockPathDropDownUI.Items, " / Rotational Friction1");
      choose(testcase, app.AppBlockSelectorUI.BlockPathDropDownUI.MainDropDown, find(logical_index))

      press(testcase, app.AppBlockSelectorUI.GetParametersFromBlockUI.MainButton)  % !test-target

      press(testcase, app.AppBlockSelectorUI.SetParametersToBlockUI.MainButton)  % !test-target

    end  % function

    function get_set_parameters_with_model_2(testcase)
      %%
      % Test with a block containing simscape.Value objects for the block parameters.
      % Parameters must be loaded in the base workspace.

      paramfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams2.m");
      [~, paramfile_name, ~] = fileparts(paramfile_fullpath);
      evalin("base", paramfile_name)

      modelfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleModel_refsub_24b.mdl");
      [~, model_name, ~] = fileparts(modelfile_fullpath);

      app = RotationalFrictionTorqueApp(ModelName=model_name);

      % !test-target: Select a block containing simscape.Value objects for the block parameters.
      logical_index = endsWith(app.AppBlockSelectorUI.BlockPathDropDownUI.Items, " / Rotational Friction2");
      choose(testcase, app.AppBlockSelectorUI.BlockPathDropDownUI.MainDropDown, find(logical_index))

      press(testcase, app.AppBlockSelectorUI.GetParametersFromBlockUI.MainButton)  % !test-target

      press(testcase, app.AppBlockSelectorUI.SetParametersToBlockUI.MainButton)  % !test-target

      verifyEqual(testcase, app.BreakawayTorqueUI.ValueText, "Params.Friction2.BreakawayTorque.value(""in*lbf"")")

    end  % function

    function set_parameters_with_simscapevalue_text(testcase)
      %% Test that Set Parameters works when ValueText contains simscape.Value expressions.
      model_name = "RotationalFrictionTorque_SampleModel_refsub_24b";
      app = RotationalFrictionTorqueApp(ModelName=model_name);

      % Type simscape.Value expressions directly into the value fields.
      type(testcase, app.BreakawayTorqueUI.ValueTextUI.MainEditField, "simscape.Value(30, ""N*m"")")
      type(testcase, app.BreakawayVelocityUI.ValueTextUI.MainEditField, "simscape.Value(0.2, ""rad/s"")")
      type(testcase, app.CoulombTorqueUI.ValueTextUI.MainEditField, "simscape.Value(15, ""N*m"")")
      type(testcase, app.ViscousCoefficientUI.ValueTextUI.MainEditField, "simscape.Value(0.005, ""N*m*s/rad"")")

      % Select a block and press Set Parameters.
      logical_index = endsWith(app.AppBlockSelectorUI.BlockPathDropDownUI.Items, " / Rotational Friction1");
      choose(testcase, app.AppBlockSelectorUI.BlockPathDropDownUI.MainDropDown, find(logical_index))
      press(testcase, app.AppBlockSelectorUI.SetParametersToBlockUI.MainButton)

      % Verify app is still valid.
      verifyTrue(testcase, isvalid(app.MainFigure))
    end  % function

    %% Test error handling with visible figure

    function get_parameters_error_visible_figure(testcase)
      % Open app normally with a valid model (figure becomes visible).
      % Then clear workspace variables so that Get fails with figure visible.
      paramfile_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorque_SampleParams2.m");
      [~, paramfile_name, ~] = fileparts(paramfile_fullpath);
      evalin("base", paramfile_name)

      model_name = "RotationalFrictionTorque_SampleModel_refsub_24b";
      app = RotationalFrictionTorqueApp(ModelName=model_name);

      % Clear base workspace variables so that block parameter evaluation fails.
      evalin("base", "clear Params")

      % Select the block that references workspace variables.
      logical_index = endsWith(app.AppBlockSelectorUI.BlockPathDropDownUI.Items, " / Rotational Friction2");
      choose(testcase, app.AppBlockSelectorUI.BlockPathDropDownUI.MainDropDown, find(logical_index))

      % Press Get -- this should trigger the uialert path (lines 638-643).
      press(testcase, app.AppBlockSelectorUI.GetParametersFromBlockUI.MainButton)

      % App should not crash.
      verifyTrue(testcase, isvalid(app.MainFigure))
    end  % function

    function safeupdate_catch_block_with_incompatible_unit(testcase)
      %% Trigger safeupdate catch block by injecting incompatible unit (lines 800-813).
      app = RotationalFrictionTorqueApp;

      % Type a simscape.Value with an incompatible unit (mass instead of torque).
      % When updateApp fires, it calls safeupdate_DataSetModelParams_from_SimscapeValue
      % which tries to assign this to ModelParams.BreakawayTorque (expects "N*m").
      % The mustBeCommensurateUnit validator throws, triggering the catch block.
      type(testcase, app.BreakawayTorqueUI.ValueTextUI.MainEditField, "simscape.Value(1, ""kg"")")

      % The catch block shows uialert when figure is visible and reverts the value.
      % App must remain valid.
      verifyTrue(testcase, isvalid(app.MainFigure))
    end  % function

    %% Test sample models
%{
% !todo: get_param does not robustly return a text as it should, which can cause test failure.
% The issue occurs locally in 24b and remotely (i.e., in GitHub Actions) in 26a.

    function button_in_sample_model_1(testcase)
      if isMATLABReleaseOlderThan("R2026a")
        disp("Skipping this test in R2025b and older.")

        return

      end  % if
      % Test the command in the ClickFcn of a Callback Button.
      % Rather than clicking the button programmatically, get the command text and evaluate it.

      model_name = "RotationalFrictionTorque_SampleModel_refsub_24b";
      block_path = model_name + "/Open Rotational Friction Torque App";

      load_system(model_name)

      pause(1)  % !todo: This pause must be eliminated.

      open_system(block_path);

      pause(1)  % !todo: This pause must be eliminated.

      % Theoretically, get_param must return a non-empty char array here.
      command_text = get_param(block_path, "ClickFcn");

      disp("Command text in the block: " + command_text)

      verifyTrue(testcase, not(isempty(command_text)))  % !flaky-test: 24b. even in 26a.

      if contains(command_text, "bdroot")
        % "bdroot" in the command text is not expanded by eval to the model name.
        command_text = replace(command_text, "bdroot", """" + model_name + """");
      end  % if

      disp("Command text to test: " + command_text)
      eval(command_text)  % !test-target

    end  % function
%}
  end  % methods
end  % classdef
