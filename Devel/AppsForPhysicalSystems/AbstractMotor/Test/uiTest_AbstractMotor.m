classdef uiTest_AbstractMotor < matlab.uitest.TestCase
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

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @AbstractMotor1.AbstractMotorEfficiencyAppMain)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @AbstractMotorEfficiencyApp)
    end  % function

%{
    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AbstractMotorEfficiencyCustomApp1  % !test-target
      end  % nested function
    end  % function
%}

    %% Error case tests

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "AbstractMotorEfficiencyAppMain:InvalidModelName")
      function test_target
        % The model does not exist.
        model_name = "test_test_test";
        AbstractMotor1.AbstractMotorEfficiencyAppMain(ModelName=model_name)  % !test-target
      end  % nested function
    end  % function

    %% Visual tests
    % These tests need visual inspection.
%{
    function VisualTest_1_1(~)
      % Specify unit options.
      AbstractMotor1.AbstractMotorEfficiencyAppMain(PlotTorqueUnit="lbf*ft", PlotAngularSpeedUnit="rad/s")
    end  % function

    function VisualTest_1_2(~)
      % Specify unit options.
      AbstractMotorEfficiencyApp(PlotTorqueUnit="lbf*ft", PlotVelocityUnit="rad/s")
    end  % function

    function VisualTest_2_1(testcase)
      % Select units for plot.
      app = AbstractMotorEfficiencyApp;

      % Items must be defined for the drop down.
      choose(testcase, app.PlotVelocityUnitUI.MainDropDown, "rev/s")
      choose(testcase, app.PlotVelocityUnitUI.MainDropDown, "rpm")
    end  % function

    function VisualTest_2_2(testcase)
      % Select units for plot.
      app = AbstractMotorEfficiencyApp;

      % Items must be defined for the drop down.
      choose(testcase, app.PlotTorqueUnitUI.MainDropDown, "lbf*ft")
      choose(testcase, app.PlotTorqueUnitUI.MainDropDown, "N*m")
    end  % function

    function VisualTest_3(testcase)
      % Select/deselect torque components for plot.
      app = AbstractMotorEfficiencyApp;

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
%}
    %% Test with a model
%{
    function check_callback_button_in_a_model_1(testcase)
      % Test the command in the ClickFcn of a Callback Button.
      % Rather than clicking the button programmatically, get the command text and evaluate it.

      model_name = "SampleModel_RotationalFriction_refsub_24b";

      load_system(model_name)

      % Theoretically, get_param must return a non-empty char array here.
      command_text = get_param(model_name + "/Rotational Friction App", "ClickFcn");
      % For some reason, sometimes the above line does not work as expected.
      % !todo: The if block below must be eliminated. 
      if isempty(command_text)
        open_system(model_name + "/Rotational Friction App")

        disp("Pausing...")
        pause(3)  % !todo: This pause must be eliminated.
        disp("done.")

        % Try again...
        command_text = get_param(model_name + "/Rotational Friction App", "ClickFcn");
      end  % if

      verifyTrue(testcase, not(isempty(command_text)))

      if contains(command_text, "bdroot")
        % "bdroot" in the command text is not expanded by eval to the model name.
        command_text = replace(command_text, "bdroot", """" + model_name + """");
      end  % if

      disp("Command text to test:")
      disp(command_text)
      eval(command_text)  % !test-target

    end  % function

    function Test_with_samplemodel_1(~)
      % Test the ModelName option.
      model_name = "SampleModel_RotationalFriction_refsub_24b";
      AbstractMotor1.AbstractMotorEfficiencyAppMain(ModelName=model_name)
    end  % function

    function Test_with_samplemodel_2(~)
      % Test the BlockPath option together with the plot unit options.
      % Specify the block which uses workspace variables for the block parameters.
      model_name = "SampleModel_RotationalFriction_refsub_24b";
      block_path = model_name + "/Rotational Friction2";
      evalin("base", "SampleParams_RotationalFriction")
      AbstractMotor1.AbstractMotorEfficiencyAppMain(BlockPath=block_path, PlotTorqueUnit="lbf*ft", PlotVelocityUnit="rev/s")
    end  % function
%}
    %% Regular tests
%{
    function Test_1(testcase)
      % If the app is launched with a model, the app must load parameters from an expected block.

      model_name = "SampleModel_RotationalFriction_refsub_24b";
      app = AbstractMotor1.AbstractMotorEfficiencyAppMain(ModelName=model_name);

      % The app must load this block:
      block_path = model_name + "/Rotational Friction1";

      % Check that the UI components have the expected data from the block.

      % Breakaway friction torque, value
      actual_value_text_in_app = app.BreakawayTorqueUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "brkwy_trq"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      % Breakaway friction torque, unit
      actual_unit_text_in_app = app.BreakawayTorqueUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "brkwy_trq_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)

      % Breakaway friction velocity, value
      actual_value_text_in_app = app.BreakawayVelocityUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "brkwy_vel"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      % Breakaway friction velocity, unit
      actual_unit_text_in_app = app.BreakawayVelocityUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "brkwy_vel_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)

      % Coulomb friction torque, value
      actual_value_text_in_app = app.CoulombTorqueUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "Col_trq"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      % Coulomb friction torque, unit
      actual_unit_text_in_app = app.CoulombTorqueUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "Col_trq_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)

      % Viscous friction coefficient, value
      actual_value_text_in_app = app.ViscousCoefficientUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "visc_coef"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      % Viscous friction coefficient, unit
      actual_unit_text_in_app = app.ViscousCoefficientUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "visc_coef_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)
    end  % function

    function Test_2(testcase)
      % If the app is launched with a block path, the app must load parameters from the specified block.
      model_name = "SampleModel_RotationalFriction_refsub_24b";
      block_path = model_name + "/Rotational Friction1";
      app = AbstractMotor1.AbstractMotorEfficiencyAppMain(BlockPath=block_path);

      % Check that the UI components have the expected data from the block.
      % This test is basically the same as Test_1. Omit some checks in this test.

      actual_value_text_in_app = app.BreakawayTorqueUI.ValueText;
      expected_value_text_in_block = string(get_param(block_path, "brkwy_trq"));
      verifyEqual(testcase, actual_value_text_in_app, expected_value_text_in_block)

      actual_unit_text_in_app = app.BreakawayTorqueUI.UnitText;
      expected_unit_text_in_block = string(get_param(block_path, "brkwy_trq_unit"));
      verifyEqual(testcase, actual_unit_text_in_app, expected_unit_text_in_block)

    end  % function

    function Test_3(testcase)

      app = AbstractMotorEfficiencyCustomApp1;

      app.PlotButtonUI.ButtonEnable = true;

      evalin("base", "friction.BreakawayTorque = simscape.Value(500, ""lbf*in"")")

      press(testcase, app.PlotButtonUI.ButtonUI.MainButton)

      % The returned text contains "in*lbf", not "lbf*in".
      % It is what simscape.Unit returns.
      actual_text = app.BreakawayTorqueUI.InfoUI.Value;
      verifyTrue(testcase, actual_text == "500 (in*lbf)")

    end  % function
%}
    %% Gesture test

    % Visually inspect that the app reacts to (programmatic) user actions.
%{
    function Gesture_1(testcase)
      app = AbstractMotor1.AbstractMotorEfficiencyAppMain;
      choose(testcase, app.ViscousCoefficientUI.UnitDropDownUI.MainDropDown, "N*m/rpm")
      type(testcase, app.ViscousCoefficientUI.ValueTextUI.MainEditField, "1")
    end  % function
%}
  end  % methods
end  % classdef
