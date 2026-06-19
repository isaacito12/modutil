classdef uiTest_Vehicle1DForce < matlab.uitest.TestCase
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

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @Vehicle1DForce1.Vehicle1DForceAppMain)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @Vehicle1DForceApp)
    end  % function

    %% Error case tests

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "Vehicle1DForceAppMain:InvalidModelName")
      function test_target
        % The model does not exist.
        model_name = "test_test_test";
        Vehicle1DForce1.Vehicle1DForceAppMain(ModelName=model_name)  % !test-target
      end  % nested function
    end  % function

    %% Gesture test

    function Gesture_1(testcase)
      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      choose(testcase, app.VehicleMassUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbm")
      type(testcase, app.VehicleMassUI.ValueTextUI.MainEditField, "4000")
    end  % function

    function Gesture_2(testcase)
      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      choose(testcase, app.TopSpeedUI.UnitDropDownUI.DropDownUI.MainDropDown, "mph")
      type(testcase, app.TopSpeedUI.ValueTextUI.MainEditField, "100")
    end  % function

    function Gesture_preset(testcase)
      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      choose(testcase, app.PresetDropDownUI.MainDropDown, "Small car")
      choose(testcase, app.PresetDropDownUI.MainDropDown, "Large SUV")
      choose(testcase, app.PresetDropDownUI.MainDropDown, "Medium car")
    end  % function

    function Gesture_figure_window_1(testcase)
      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      press(testcase, app.OpenInFigureWindowUI.MainHyperlink)
    end  % function

    function Gesture_figure_window_2(~)
      % Directly invoke the callback, which allows manual select-and-run for interactive visual inspection.
      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      app.PresetDropDownUI.Value = "Large SUV";
      app.OpenInFigureWindowUI.HyperlinkClickedCallback()
      app.PresetDropDownUI.Value = "Medium car";
      app.OpenInFigureWindowUI.HyperlinkClickedCallback()
    end  % function

    %% Test with a model

    function option_ModelName_1(~)
      model_name = "Vehicle1DForce_SampleModel_refsub_24b";
      Vehicle1DForce1.Vehicle1DForceAppMain(ModelName=model_name)
    end  % function

    function option_BlockPath_1(~)
      block_path = "Vehicle1DForce_SampleModel_refsub_24b/Longitudinal Vehicle";
      Vehicle1DForce1.Vehicle1DForceAppMain(BlockPath=block_path)
    end  % function

    function option_BlockPath_2(~)
      % Load parameter definitions in the base workspace.
      evalin("base", "Vehicle1DForce_SampleParams1")
      % Specify the block which refers to the base workspace variables.
      block_path = "Vehicle1DForce_SampleModel_refsub_24b/Longitudinal Vehicle1";
      model_name = "Vehicle1DForce_SampleModel_refsub_24b";
      % BlockPath must win over ModelName.
      Vehicle1DForce1.Vehicle1DForceAppMain(BlockPath=block_path, ModelName=model_name)
    end  % function

    function set_parameter_to_block_1(testcase)

      % -----------------------------------------------------------------------
      % Create a new model, put a vehicle block, and save.
      %
      % By default, the "Parameterization type" of the block is "Regular parameter set",
      % which the app requires.

      model_filename = FileUtil1.getUnusedFilename("tmp_model.mdl");
      [~, model_name, ~] = fileparts(model_filename);

      block_path = model_name + "/Longitudinal Vehicle";

      mdl = new_system(model_name);
      open_system(mdl)
      add_block("sdl_lib/Tires & Vehicles/Longitudinal Vehicle", block_path)
      savedfile_fullpath = string(save_system(model_name));

      verifyEqual(testcase, savedfile_fullpath, fullfile(pwd, model_filename))

      % -----------------------------------------------------------------------
      % Open the app with the target block in the model.
      % Change values in the app, send the values to the block by clicking the Set button.

      app = Vehicle1DForce1.Vehicle1DForceAppMain(BlockPath=block_path);

      choose(testcase, app.PresetDropDownUI.MainDropDown, "Large SUV")

      press(testcase, app.AppBlockSelectorUI.SetParametersToBlockUI.MainButton)

      % -----------------------------------------------------------------------
      % Check that the values were transferred from the app to the block.

      savedfile_fullpath = string(save_system(model_name));
      disp("Saved the model file: " + savedfile_fullpath)

      x = string(get_param(block_path, "M_vehicle"));
      verifyEqual(testcase, x, "2600")

      x = string(get_param(block_path, "M_vehicle_unit"));
      verifyEqual(testcase, x, "kg")

      x = string(get_param(block_path, "C_tireroll"));
      verifyEqual(testcase, x, "0.014")

      x = string(get_param(block_path, "C_airdrag"));
      verifyEqual(testcase, x, "0.36")

      x = string(get_param(block_path, "A_front"));
      verifyEqual(testcase, x, "3.13")

      x = string(get_param(block_path, "A_front_unit"));
      verifyEqual(testcase, x, "m^2")

      x = string(get_param(block_path, "g"));
      verifyEqual(testcase, x, "9.81")

      x = string(get_param(block_path, "g_unit"));
      verifyEqual(testcase, x, "m/s^2")

      if isfile(savedfile_fullpath)
        delete(savedfile_fullpath)
        disp("Deleted the model file.")
      end  % if
    end  % function

    %% Constructor error paths

    function Test_error_InvalidModelName_from_BlockPath(testcase)
      % BlockPath without "/" yields empty model name.
      verifyError(testcase, ...
        @() Vehicle1DForce1.Vehicle1DForceAppMain(BlockPath="NoSlashHere"), ...
        "Vehicle1DForceAppMain:InvalidModelName")
    end  % function

    function Test_error_SimscapeBlockWasNotFound(testcase)
      % Model exists but has no Longitudinal Vehicle block.
      model_name = "tmp_empty_model_v1d_test";
      new_system(model_name);
      save_system(model_name);
      addTeardown(testcase, @() bdclose(model_name))
      addTeardown(testcase, @() delete(which(model_name)))
      verifyError(testcase, ...
        @() Vehicle1DForce1.Vehicle1DForceAppMain(ModelName=model_name), ...
        "Vehicle1DForceAppMain:SimscapeBlockWasNotFound")
    end  % function

    function Test_error_InvalidBlockPath(testcase)
      % Model has the target block, but BlockPath points elsewhere.
      model_name = "Vehicle1DForce_SampleModel_refsub_24b";
      wrong_path = model_name + "/Nonexistent Block XYZ";
      verifyError(testcase, ...
        @() Vehicle1DForce1.Vehicle1DForceAppMain(BlockPath=wrong_path), ...
        "Vehicle1DForceAppMain:InvalidBlockPath")
    end  % function

    %% AppParameterFile error paths

    function Test_error_InvalidAppParameterFileName(testcase)
      verifyError(testcase, ...
        @() Vehicle1DForce1.Vehicle1DForceAppMain( ...
          AppParameterFileName="nonexistent_file_xyz_123.m", ...
          AppParameterStructName="SomeStruct"), ...
        "Vehicle1DForceAppMain:InvalidAppParameterFileName")
    end  % function

    function Test_error_AppParameterStructNameIsRequired(testcase)
      param_file = which("Vehicle1DForce_SampleParams1.m");
      verifyError(testcase, ...
        @() Vehicle1DForce1.Vehicle1DForceAppMain( ...
          AppParameterFileName=param_file, ...
          AppParameterStructName=""), ...
        "Vehicle1DForceAppMain:AppParameterStructNameIsRequired")
    end  % function

    function Test_AppParameterFile_success(testcase)
      param_file = which("Vehicle1DForce_SampleParams1.m");
      addTeardown(testcase, @() evalin("base", "clear VehicleParams1"))
      app = Vehicle1DForce1.Vehicle1DForceAppMain( ...
        AppParameterFileName=param_file, ...
        AppParameterStructName="VehicleParams1");
      verifyEqual(testcase, app.AppParameterStructName, "VehicleParams1")
      verifyEqual(testcase, ...
        string(app.StructParameterUI.ParameterFileDropDownUI.Value), ...
        string(param_file))
    end  % function

    function Test_AppParameterStructName_only(testcase)
      evalin("base", "Vehicle1DForce_SampleParams1");
      addTeardown(testcase, @() evalin("base", "clear VehicleParams1"))
      app = Vehicle1DForce1.Vehicle1DForceAppMain( ...
        AppParameterStructName="VehicleParams1");
      verifyEqual(testcase, app.AppParameterStructName, "VehicleParams1")
    end  % function

    %% callback_set_parameters with SimscapeValue

    function Test_set_parameters_simscape_value(testcase)
      model_filename = FileUtil1.getUnusedFilename("tmp_model_sv.mdl");
      [~, model_name, ~] = fileparts(model_filename);
      block_path = model_name + "/Longitudinal Vehicle";
      new_system(model_name);
      open_system(model_name);
      add_block("sdl_lib/Tires & Vehicles/Longitudinal Vehicle", block_path);
      save_system(model_name);
      addTeardown(testcase, @() bdclose(model_name))
      addTeardown(testcase, @() delete(which(model_name)))

      app = Vehicle1DForce1.Vehicle1DForceAppMain(BlockPath=block_path);

      % Set ValueText to simscape.Value expressions.
      app.VehicleMassUI.ValueText = "simscape.Value(1500, 'kg')";
      app.FrontalAreaUI.ValueText = "simscape.Value(2.5, 'm^2')";
      app.GravitationalAccelerationUI.ValueText = "simscape.Value(9.81, 'm/s^2')";

      % Trigger set parameters callback.
      press(testcase, app.AppBlockSelectorUI.SetParametersToBlockUI.MainButton)

      % Verify block parameters use .value("unit") notation.
      x = string(get_param(block_path, "M_vehicle"));
      verifyTrue(testcase, contains(x, ".value(""kg"")"))

      x = string(get_param(block_path, "A_front"));
      verifyTrue(testcase, contains(x, ".value(""m^2"")"))

      x = string(get_param(block_path, "g"));
      verifyTrue(testcase, contains(x, ".value(""m/s^2"")"))
    end  % function

    %% callback_get_parameters error paths

    function Test_get_parameters_error_visible(testcase)
      % Create model with RoadLoad parameterization (unsupported by app).
      model_filename = FileUtil1.getUnusedFilename("tmp_model_rl.mdl");
      [~, model_name, ~] = fileparts(model_filename);
      block_path = model_name + "/Longitudinal Vehicle";
      new_system(model_name);
      add_block("sdl_lib/Tires & Vehicles/Longitudinal Vehicle", block_path);
      set_param(block_path, "vehParamType", "sdl.enum.VehicleParameterizationType.RoadLoad");
      save_system(model_name);
      addTeardown(testcase, @() bdclose(model_name))
      addTeardown(testcase, @() delete(which(model_name)))

      % Launch app normally (figure becomes visible).
      app = Vehicle1DForce1.Vehicle1DForceAppMain;

      % Point the block path dropdown to the bad block.
      app.AppBlockSelectorUI.BlockPathDropDownUI.Items(end+1) = replace(block_path, "/", " / ");
      app.AppBlockSelectorUI.BlockPathDropDownUI.Value = replace(block_path, "/", " / ");

      % Trigger get parameters. Should show uialert, not throw.
      app.callback_get_parameters();
      verifyTrue(testcase, true)
    end  % function

    function Test_get_parameters_error_invisible(testcase)
      % Create model with RoadLoad parameterization.
      model_filename = FileUtil1.getUnusedFilename("tmp_model_inv.mdl");
      [~, model_name, ~] = fileparts(model_filename);
      block_path = model_name + "/Longitudinal Vehicle";
      new_system(model_name);
      add_block("sdl_lib/Tires & Vehicles/Longitudinal Vehicle", block_path);
      set_param(block_path, "vehParamType", "sdl.enum.VehicleParameterizationType.RoadLoad");
      save_system(model_name);
      addTeardown(testcase, @() bdclose(model_name))
      addTeardown(testcase, @() delete(which(model_name)))

      % During app construction with BlockPath, the figure is not yet visible.
      % The DataSet constructor will throw InvalidParameterization, which gets rethrown.
      verifyError(testcase, ...
        @() Vehicle1DForce1.Vehicle1DForceAppMain(BlockPath=block_path), ...
        "Vehicle1DForceDataSet:InvalidParameterization")
    end  % function

    %% loadParametersFromBaseWorkspace

    function Test_loadParams_empty_returns_early(testcase)
      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      app.StructParameterUI.StructNameDropDownUI.Value = "";
      % Should return immediately without error.
      app.loadParametersFromBaseWorkspace();
      verifyEqual(testcase, app.AppParameterStructName, "")
    end  % function

    function Test_loadParams_dotted_struct_name(testcase)
      evalin("base", "Vehicle1DForce_SampleParams1");
      evalin("base", "test_nested_v1d.sub = VehicleParams1;");
      addTeardown(testcase, @() evalin("base", "clear VehicleParams1 test_nested_v1d"))

      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      app.loadParametersFromBaseWorkspace(StructName="test_nested_v1d.sub");
      verifyEqual(testcase, app.AppParameterStructName, "test_nested_v1d.sub")
    end  % function

    function Test_loadParams_struct_not_found(testcase)
      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      verifyError(testcase, ...
        @() app.loadParametersFromBaseWorkspace(StructName="nonexistent_var_xyz"), ...
        "Vehicle1DForceAppMain:StructNotFoundInBaseWorkspace")
    end  % function

    function Test_loadParams_from_dropdown(testcase)
      evalin("base", "Vehicle1DForce_SampleParams1");
      addTeardown(testcase, @() evalin("base", "clear VehicleParams1"))

      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      app.StructParameterUI.StructNameDropDownUI.Items(end+1) = "VehicleParams1";
      app.StructParameterUI.StructNameDropDownUI.Value = "VehicleParams1";
      app.loadParametersFromBaseWorkspace();
      verifyEqual(testcase, app.AppParameterStructName, "VehicleParams1")
    end  % function

    function Test_loadParams_setupParameterUI_exception(testcase)
      % Create a struct in base workspace with a field that will cause
      % ValueText assignment to fail (invalid expression).
      evalin("base", "bad_v1d_struct.VehicleMass = 'invalid([';");
      addTeardown(testcase, @() evalin("base", "clear bad_v1d_struct"))

      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      original_value = app.VehicleMassUI.ValueText;
      % Should not throw; gracefully handles the error.
      app.loadParametersFromBaseWorkspace(StructName="bad_v1d_struct");
      % Original value should be restored on failure.
      verifyEqual(testcase, app.VehicleMassUI.ValueText, original_value)
    end  % function

    %% updateApp
    % Test the error handling in the updateApp.

    function invalid_data_1(testcase)
      % Test with DataSet.ModelParams.
      % There are multiple properties in DataSet.ModelParams, but test with just one.

      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      value_before = value(app.DataSet.ModelParams.VehicleMass, "kg");

      % This results in uialert and reverts DataSet.
      type(testcase, app.VehicleMassUI.ValueTextUI.MainEditField, "-1")

      value_after = value(app.DataSet.ModelParams.VehicleMass, "kg");
      verifyEqual(testcase, value_after, value_before)
    end  % function

    function invalid_data_2(testcase)
      % Test with DataSet.
      % There are multiple properties in DataSet, but test with just one.

      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      value_before = value(app.DataSet.PlotSpeedUpperBound, "km/hr");

      % This results in uialert and reverts DataSet.
      type(testcase, app.PlotSpeedUpperBoundUI.ValueTextUI.MainEditField, "-1")

      value_after = value(app.DataSet.PlotSpeedUpperBound, "km/hr");
      verifyEqual(testcase, value_after, value_before)
    end  % function

    % !wip: does not run as expected.
    function WIP_updateApp_error_recovery(testcase)
      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      original_mass = value(app.DataSet.ModelParams.VehicleMass, "kg");

      % Set invalid value that will make updateDataSet throw.
      app.VehicleMassUI.ValueText = "-1000";
      % updateApp should not throw (shows uialert, reverts DataSet).
      updateApp(app);

      % DataSet should revert to previous valid values.
      verifyEqual(testcase, value(app.DataSet.ModelParams.VehicleMass, "kg"), original_mass)
    end  % function

    function Test_updateApp_PlotMode_skip(testcase)
      app = Vehicle1DForce1.Vehicle1DForceAppMain;
      % Call with PlotMode="skip" — should compute derived params but skip plot.
      app.updateApp(PlotMode="skip");
      % Verify derived parameters were still computed.
      verifyTrue(testcase, strlength(app.MaxForceUI.ValueText) > 0)
    end  % function

  end  % methods
end  % classdef
