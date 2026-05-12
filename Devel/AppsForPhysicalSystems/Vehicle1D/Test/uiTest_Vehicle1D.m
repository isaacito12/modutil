classdef uiTest_Vehicle1D < matlab.uitest.TestCase
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
      verifyWarningFree(testcase, @Vehicle1D1.Vehicle1DAppMain)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @Vehicle1DApp)
    end  % function

    %% Error case tests

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "Vehicle1DAppMain:InvalidModelName")
      function test_target
        % The model does not exist.
        model_name = "test_test_test";
        Vehicle1D1.Vehicle1DAppMain(ModelName=model_name)  % !test-target
      end  % nested function
    end  % function

    %% Gesture test

    function Gesture_1(testcase)
      app = Vehicle1D1.Vehicle1DAppMain;
      choose(testcase, app.VehicleMassUI.UnitDropDownUI.DropDownUI.MainDropDown, "lbm")
      type(testcase, app.VehicleMassUI.ValueTextUI.MainEditField, "4000")
    end  % function

    function Gesture_2(testcase)
      app = Vehicle1D1.Vehicle1DAppMain;
      choose(testcase, app.TopSpeedUI.UnitDropDownUI.DropDownUI.MainDropDown, "mph")
      type(testcase, app.TopSpeedUI.ValueTextUI.MainEditField, "100")
    end  % function

    function Gesture_preset(testcase)
      app = Vehicle1D1.Vehicle1DAppMain;
      choose(testcase, app.PresetDropDownUI.MainDropDown, "Small car")
      choose(testcase, app.PresetDropDownUI.MainDropDown, "Large SUV")
      choose(testcase, app.PresetDropDownUI.MainDropDown, "Medium car")
    end  % function

    function Gesture_figure_window_1(testcase)
      app = Vehicle1D1.Vehicle1DAppMain;
      press(testcase, app.OpenInFigureWindowUI.MainHyperlink)
    end  % function

    function Gesture_figure_window_2(~)
      % Directly invoke the callback, which allows manual select-and-run for interactive visual inspection.
      app = Vehicle1D1.Vehicle1DAppMain;
      app.PresetDropDownUI.Value = "Large SUV";
      app.OpenInFigureWindowUI.HyperlinkClickedCallback()
      app.PresetDropDownUI.Value = "Medium car";
      app.OpenInFigureWindowUI.HyperlinkClickedCallback()
    end  % function

    %% Test with a model

    function option_ModelName_1(~)
      model_name = "SampleModel_Vehicle1D_refsub_24b";
      Vehicle1D1.Vehicle1DAppMain(ModelName=model_name)
    end  % function

    function option_BlockPath_1(~)
      block_path = "SampleModel_Vehicle1D_refsub_24b/Longitudinal Vehicle";
      Vehicle1D1.Vehicle1DAppMain(BlockPath=block_path)
    end  % function

    function option_BlockPath_2(~)
      % Load parameter definitions in the base workspace.
      evalin("base", "SampleParams_Vehicle1D")
      % Specify the block which refers to the base workspace variables.
      block_path = "SampleModel_Vehicle1D_refsub_24b/Longitudinal Vehicle1";
      model_name = "SampleModel_Vehicle1D_refsub_24b";
      % BlockPath must win over ModelName.
      Vehicle1D1.Vehicle1DAppMain(BlockPath=block_path, ModelName=model_name)
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
      savedfile_fullpath = string(save_system(model_name, model_name+".mdl"));

      verifyEqual(testcase, savedfile_fullpath, fullfile(pwd, model_filename))

      % -----------------------------------------------------------------------
      % Open the app with the target block in the model.
      % Change values in the app, send the values to the block by clicking the Set button.

      app = Vehicle1D1.Vehicle1DAppMain(BlockPath=block_path);

      choose(testcase, app.PresetDropDownUI.MainDropDown, "Large SUV")

      press(testcase, app.AppBlockSelectorUI.SetParametersToBlockUI.MainButton)

      % -----------------------------------------------------------------------
      % Check that the values were transferred from the app to the block.

      savedfile_fullpath = string(save_system(model_name, model_name+".mdl"));
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

  end  % methods
end  % classdef
