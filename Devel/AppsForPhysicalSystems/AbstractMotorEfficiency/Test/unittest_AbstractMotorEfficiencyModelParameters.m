classdef unittest_AbstractMotorEfficiencyModelParameters < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
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
    % Functions in this "Test" section are the tests.
    % Before each function in this section runs, functions defined in the TestMethodSetup section run.

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    function PassingTest_1(~)
      AbstractMotorEfficiency1.AbstractMotorEfficiencyModelParameters
    end  % function

    function PassingTest_2(~)
      AbstractMotorEfficiency1.AbstractMotorEfficiencyModelParameters(Initialization=true)
    end  % function

    % -------------------------------------------------------------------------

    function error_1(testcase)
      %%
      % Wrong parameter values for torques.

      params = AbstractMotorEfficiency1.AbstractMotorEfficiencyModelParameters(Initialization=true);

      params.MaxTorque = simscape.Value(1, "N*m");
      params.MeasuredTorque = simscape.Value(10, "N*m");

      verifyError(testcase, @test_target, "AbstractMotorEfficiencyModelParameters:InvalidTorqueParameters")
      function test_target
        updateDerivedParameters(params)
      end  % nested function
    end  % function

    function error_2(testcase)
      %%
      % Wrong parameter values for angular speeds.

      params = AbstractMotorEfficiency1.AbstractMotorEfficiencyModelParameters(Initialization=true);

      % MaxPower/MaxTorque must be smaller than MeasuredAngularSpeed.
      % These settings violate it.
      params.MaxPower = simscape.Value(1, "W");
      params.MaxTorque = simscape.Value(1, "N*m");
      params.MeasuredAngularSpeed = simscape.Value(2, "rad/s");

      % Measured torque must be smaller than max torque.
      params.MeasuredTorque = simscape.Value(0.5, "N*m");

      verifyError(testcase, @test_target, "AbstractMotorEfficiencyModelParameters:SpeedConstraintViolation")
      function test_target
        updateDerivedParameters(params)
      end  % nested function
    end  % function

    function error_3(testcase)
      %%
      % Wrong parameter value for efficiency, resulting in inconsistency in derived iron loss value.

      params = AbstractMotorEfficiency1.AbstractMotorEfficiencyModelParameters(Initialization=true);

      params.OverallEfficiencyPercent = 99.7;

      % The code below is to calculate the nominal losses to display its value.
      % verifyError below does not depend on it.
      normalized_measured_efficiency = params.OverallEfficiencyPercent / 100;
      measured_mechanical_power = params.MeasuredAngularSpeed * params.MeasuredTorque;
      measured_nominal_losses = convert((1/normalized_measured_efficiency - 1) * measured_mechanical_power, "W");
      disp("Measured nominal losses (derived): " + value(measured_nominal_losses, "W") + " (W)")
      disp("Measured iron losses (specified): " + value(params.MeasuredIronLosses, "W") + " (W)")

      verifyError(testcase, @test_target, "AbstractMotorEfficiencyModelParameters:InvalidIronLosses")
      function test_target
        updateDerivedParameters(params)
      end  % nested function
    end  % function

    % -------------------------------------------------------------------------

    function test_1(testcase)
      %%
      % Ideal motor settings

      params = AbstractMotorEfficiency1.AbstractMotorEfficiencyModelParameters(Initialization=true);

      % Conversion efficiency above the internal threshold of 99.8 % sets the motor to be ideal.
      params.OverallEfficiencyPercent = 99.9;

      params = updateDerivedParameters(params);

      verifyTrue(testcase, params.MeasuredNominalLosses == simscape.Value(0, "W"))
      verifyTrue(testcase, params.IronToNominalLossRatioPercent == 0)
      verifyTrue(testcase, params.MeasuredCopperLosses == simscape.Value(0, "W"))
      verifyTrue(testcase, params.MeasuredIronLossCoefficient == simscape.Value(0, "W/rpm^2"))
      verifyTrue(testcase, params.MeasuredCopperLossCoefficient == simscape.Value(0, "W/(N*m)^2"))

    end  % function

    function test_2(testcase)
      %%
      % Measured iron losses can be 0, i.e., ignored, for example if the motor model type is "Simplified" which
      % corresponds to the Motor & Drive block in Simscape Driveline.
      % Note that measured copper loss is still non-zero.

      params = AbstractMotorEfficiency1.AbstractMotorEfficiencyModelParameters(Initialization=true);

      params.MeasuredIronLosses = simscape.Value(0, "W");

      params = updateDerivedParameters(params);

      verifyTrue(testcase, params.IronToNominalLossRatioPercent == 0)
      verifyTrue(testcase, params.MeasuredIronLossCoefficient == simscape.Value(0, "W/rpm^2"))

      verifyTrue(testcase, params.MeasuredCopperLosses > simscape.Value(0, "W"))

    end  % function

  end  % methods
end  % classdef
