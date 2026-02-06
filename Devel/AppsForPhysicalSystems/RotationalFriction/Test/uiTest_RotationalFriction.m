classdef uiTest_RotationalFriction < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2026 The MathWorks, Inc.

  properties
    % Do not specify the class name for a property to hold a handle to an app.
    % For class-based test apps, the class name is the app name, making
    % it difficult to use a common teardown if the class name is specified here.
    App (1,1)
  end  % properties

  methods (TestMethodSetup)
    % Functions in this "TestMethodSetup" section always run before
    % each test defined in the "Test" section runs.

    function test_method_setup(testcase)
      %%
      function closeAll
        delete(testcase.App.Window.MainFigure)
        close all
        bdclose all
      end  % nested function

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAll)

      close all
      bdclose all
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
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = RotationalFriction1.RotationalFrictionAppMain;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = RotationalFrictionApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = RotationalFrictionCustomApp1;  % !test-target
      end  % nested function
    end  % function

    %% Error case tests

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target(), "RotationalFrictionAppMain:InvalidModelName")
      function test_target()
        % A valid testcase.App.Window.MainFigure is required by the tear down.
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");
        % The model does not exist.
        model_name = "test_test_test";
        RotationalFriction1.RotationalFrictionAppMain(ModelName=model_name)  % !test-target
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target(), "RotationalFrictionAppMain:SimscapeBlockWasNotFound")
      function test_target()
        % A valid testcase.App.Window.MainFigure is required by the tear down.
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");
        % The model exists, but the target block does not exist in the model.
        model_name = "SampleModel_RotationalFriction_test1_empty";
        block_path = model_name + "/Rotational Friction1";
        RotationalFriction1.RotationalFrictionAppMain(BlockPath=block_path)  % !test-target
      end  % nested function
    end  % function

    %% Visual tests
    % These tests need visual inspection.

    function VisualTest_1_1(testcase)
      % Specify unit options.
      testcase.App = RotationalFriction1.RotationalFrictionAppMain(TorquePlotUnit="lbf*ft", VelocityPlotUnit="deg/s");
    end  % function

    function VisualTest_1_2(testcase)
      % Specify unit options.
      testcase.App = RotationalFrictionApp(TorquePlotUnit="lbf*ft", VelocityPlotUnit="deg/s");
    end  % function

    function VisualTest_2_1(testcase)
      % Select units for plot.
      testcase.App = RotationalFrictionApp;

      % Items must be defined for the drop down.
      choose(testcase, testcase.App.VelocityPlotUnitUI.MainDropDown, "deg/s")
      choose(testcase, testcase.App.VelocityPlotUnitUI.MainDropDown, "rpm")
    end  % function

    function VisualTest_2_2(testcase)
      % Select units for plot.
      testcase.App = RotationalFrictionApp;

      % Items must be defined for the drop down.
      choose(testcase, testcase.App.TorquePlotUnitUI.MainDropDown, "lbf*ft")
      choose(testcase, testcase.App.TorquePlotUnitUI.MainDropDown, "N*m")
    end  % function

    function VisualTest_3(testcase)
      % Select/deselect torque components for plot.
      testcase.App = RotationalFrictionApp;

      press(testcase, testcase.App.ShowStribeckTorqueUI.MainCheckBox)
      press(testcase, testcase.App.ShowCoulombTorqueUI.MainCheckBox)
      press(testcase, testcase.App.ShowViscousTorqueUI.MainCheckBox)

      press(testcase, testcase.App.ShowStribeckTorqueUI.MainCheckBox)
      press(testcase, testcase.App.ShowStribeckTorqueUI.MainCheckBox)

      press(testcase, testcase.App.ShowCoulombTorqueUI.MainCheckBox)
      press(testcase, testcase.App.ShowCoulombTorqueUI.MainCheckBox)

      press(testcase, testcase.App.ShowViscousTorqueUI.MainCheckBox)
      press(testcase, testcase.App.ShowViscousTorqueUI.MainCheckBox)
    end  % function

    %% Test with a model

    function Test_samplemodel_1(testcase)
      % Test a Callback Button which opens the app.
      % Rather than clicking the button programmatically, get the command text and evaluate it.

      model_name = "SampleModel_RotationalFriction_refsub_24b";

      load_system(model_name)

      command_text = string( get_param(model_name + "/Rotational Friction App", "ClickFcn"));
      % The app must open.
      eval(command_text)

      % Because there is no handle to the figure of the app, close all figures.
      figs = findall(0, Type="Figure");
      close(figs)

      % A valid testcase.App.Window.MainFigure is required by the tear down.
      testcase.App = struct;
      testcase.App.Window.MainFigure = uifigure(Visible="off");
    end  % function

    function Test_with_samplemodel_1(testcase)
      % Test the ModelName option.
      model_name = "SampleModel_RotationalFriction_refsub_24b";
      testcase.App = RotationalFriction1.RotationalFrictionAppMain(ModelName=model_name);
    end  % function

    function Test_with_samplemodel_2(testcase)
      % Test the BlockPath option together with the plot unit options.
      % Specify the block which uses workspace variables for the block parameters.
      model_name = "SampleModel_RotationalFriction_refsub_24b";
      block_path = model_name + "/Rotational Friction2";
      evalin("base", "SampleParams_RotationalFriction")
      testcase.App = RotationalFriction1.RotationalFrictionAppMain(BlockPath=block_path, TorquePlotUnit="lbf*ft", VelocityPlotUnit="rev/s");
    end  % function

    %% Regular tests

    function Test_1(testcase)
      % If the app is launched with a model, the app must load parameters from an expected block.

      model_name = "SampleModel_RotationalFriction_refsub_24b";
      testcase.App = RotationalFriction1.RotationalFrictionAppMain(ModelName=model_name);

      % The app must load this block:
      block_path = model_name + "/Rotational Friction1";

      % Check that the UI components have the expected data from the block.

      % Breakaway friction torque, value
      actual_value_text_in_app = testcase.App.BreakawayTorqueUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "brkwy_trq"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      % Breakaway friction torque, unit
      actual_unit_text_in_app = testcase.App.BreakawayTorqueUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "brkwy_trq_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)

      % Breakaway friction velocity, value
      actual_value_text_in_app = testcase.App.BreakawayVelocityUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "brkwy_vel"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      % Breakaway friction velocity, unit
      actual_unit_text_in_app = testcase.App.BreakawayVelocityUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "brkwy_vel_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)

      % Coulomb friction torque, value
      actual_value_text_in_app = testcase.App.CoulombTorqueUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "Col_trq"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      % Coulomb friction torque, unit
      actual_unit_text_in_app = testcase.App.CoulombTorqueUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "Col_trq_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)

      % Viscous friction coefficient, value
      actual_value_text_in_app = testcase.App.ViscousCoefficientUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "visc_coef"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      % Viscous friction coefficient, unit
      actual_unit_text_in_app = testcase.App.ViscousCoefficientUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "visc_coef_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)
    end  % function

    function Test_2(testcase)
      % If the app is launched with a block path, the app must load parameters from the specified block.
      model_name = "SampleModel_RotationalFriction_refsub_24b";
      block_path = model_name + "/Rotational Friction1";
      testcase.App = RotationalFriction1.RotationalFrictionAppMain(BlockPath=block_path);

      % Check that the UI components have the expected data from the block.
      % This test is basically the same as Test_1. Omit some checks in this test.

      actual_value_text_in_app = testcase.App.BreakawayTorqueUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "brkwy_trq"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      actual_unit_text_in_app = testcase.App.BreakawayTorqueUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "brkwy_trq_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)

    end  % function

    %% Gesture test

    % Visually inspect that the app reacts to (programmatic) user actions.

    function Gesture_1(testcase)
      testcase.App = RotationalFriction1.RotationalFrictionAppMain;
      choose(testcase, testcase.App.ViscousCoefficientUI.UnitDropDownUI.MainDropDown, "N*m/rpm")
      type(testcase, testcase.App.ViscousCoefficientUI.ValueTextUI.MainEditField, "1")
    end  % function

  end  % methods
end  % classdef
