classdef unittest_AbstractMotor < matlab.unittest.TestCase
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
    % Functions in this section always run before each test defined in the Test section runs.

    function test_method_setup_1(testcase)
      function closeAll
        close all
        bdclose all
      end  % nested function
      closeAll
      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAll)
    end  % function

  end  % methods

  methods (Test)
    % Functions in this "Test" section are the tests.
    % Before each function in this section runs, functions defined in the TestMethodSetup section run.

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    function PassingTest_1_1(~)
      AbstractMotor1.AbstractMotorModelParameters
    end  % function

    function PassingTest_1_2(~)
      AbstractMotor1.AbstractMotorModelParameters(Initialization=true)
    end  % function

    function PassingTest_2_1(~)
      AbstractMotor1.AbstractMotorDataSet
    end  % function

    function PassingTest_2_2(~)
      AbstractMotor1.AbstractMotorDataSet(Initialization=true)
    end  % function

    function PassingTest_3(~)
      SampleParams_AbstractMotor
    end  % function

    % -------------------------------------------------------------------------
    % The plot function
    %
    % For the visual inspection of a plot, manually run the content of a test function.
    % Programmatically running these tests only check that they run without errors.

    function Plot_1(~)
      AbstractMotor1.plotAbstractMotorEfficiency
    end  % function

    function Plot_2(~)
      AbstractMotor1.plotAbstractMotorEfficiency(ParentAxes = axes(uipanel))
    end  % function

    function Plot_3_1(~)
      AbstractMotor1.plotAbstractMotorEfficiency(ThemeMode="manual", Theme="light", ContourLevelsPercent=[1 80 93 97])
    end  % function

    function Plot_3_2(~)
      AbstractMotor1.plotAbstractMotorEfficiency(ThemeMode="manual", Theme="dark", ShowContourText="off")
    end  % function

    function Plot_3_3(~)
      AbstractMotor1.plotAbstractMotorEfficiency(ThemeMode="auto", ShowTorqueEnvelope="off")
    end  % function

    % -------------------------------------------------------------------------
    % Test options for torque.

    function option_torque_1(~)
      % Auto-range for plotting torque must work nicely to determine plot upper bound.
      AbstractMotor1.plotAbstractMotorEfficiency( ...
        AutoRangeTorque = true, ...
        MaxTorque = simscape.Value(100, "lbf*ft") );
    end  % function

    function option_torque_2(~)
      AbstractMotor1.plotAbstractMotorEfficiency( ...
        AutoRangeTorque = false, ...
        PlotTorqueUpperBound = simscape.Value(250, "N*m"), ...
        MaxTorque = simscape.Value(100, "N*m") );
    end  % function

    % -------------------------------------------------------------------------
    % Test options for angular speed.

    function option_speed_1(~)
      AbstractMotor1.plotAbstractMotorEfficiency( ...
        SpecifyMaxAngularSpeed = true, ...
        AutoRangeAngularSpeed = true, ...
        MaxAngularSpeed = simscape.Value(6000, "rpm") );
    end  % function

    function option_speed_2(~)
      AbstractMotor1.plotAbstractMotorEfficiency( ...
        SpecifyMaxAngularSpeed = true, ...
        AutoRangeAngularSpeed = false, ...
        MaxAngularSpeed = simscape.Value(500, "rev/s"), ...
        PlotAngularSpeedUpperBound = simscape.Value(600, "rev/s") );
    end  % function

    function option_speed_3(~)
      AbstractMotor1.plotAbstractMotorEfficiency( ...
        SpecifyMaxAngularSpeed = false, ...
        AutoRangeAngularSpeed = true );
    end  % function

    function option_speed_4(~)
      AbstractMotor1.plotAbstractMotorEfficiency( ...
        SpecifyMaxAngularSpeed = false, ...
        AutoRangeAngularSpeed = false, ...
        PlotAngularSpeedUpperBound = simscape.Value(8000, "rpm") );
    end  % function

    % -------------------------------------------------------------------------

    function Plot_error_1(testcase)
      verifyError(testcase, @test_target, "MATLAB:validation:UnableToConvert")
      function test_target
        % ParentAxes must be of type matlab.graphics.axis.Axes.
        % Directly passing uipanel to ParentAxes must fail.
        % (To use uipanel, pass axes(uipanel) to ParentAxes.)
        AbstractMotor1.plotAbstractMotorEfficiency(ParentAxes = uipanel)  % !test-target
      end  % nested function
    end  % function

    % -------------------------------------------------------------------------
    % The plot function with the data set
    %
    % For the visual inspection of a plot, manually run the content of a test function.
    % Programmatically running these tests only check that they run without errors.

    function Plot_DataSet_1(~)
      AbstractMotor1.plotAbstractMotorEfficiency(DataSource="dataset")  % !test-target
    end  % function

    function Plot_DataSet_2_1(~)
      ds = AbstractMotor1.AbstractMotorDataSet(Initialization=true);
      AbstractMotor1.plotAbstractMotorEfficiency(DataSource="dataset", DataSet=ds)  % !test-target
    end  % function

    function Plot_DataSet_2_2(~)
      ds = AbstractMotor1.AbstractMotorDataSet(Initialization=true);
      ds.PlotAngularSpeedUpperBound = simscape.Value(2000, "rad/s");
      ds.PlotTorqueUpperBound = simscape.Value(160, "lbf*ft");
      ds.ModelParams.MaxPower = simscape.Value(70, "kW");
      AbstractMotor1.plotAbstractMotorEfficiency(DataSource="dataset", DataSet=ds)  % !test-target
    end  % function

    %% Tests

    function Test_1_1(testcase)
      model_name = "SampleModel_AbstractMotor_refsub_24b";

      % Make sure the model exists in the MATLAB path.
      target_fullpath = FileUtil1.getFileFullPath(model_name);
      verifyTrue(testcase, isscalar(target_fullpath))
      verifyTrue(testcase, isfile(target_fullpath))

      block_path = model_name + "/Motor & Drive (System Level)1";

      ds = AbstractMotor1.AbstractMotorDataSet(BlockPath=block_path);  % !test-target

      verifyEqual(testcase, ds.BlockPath, block_path)
      verifyEqual(testcase, ds.ModelName, model_name)
      verifyEqual(testcase, ds.ModelParams.MaxTorque, simscape.Value(160, "N*m"))
      verifyEqual(testcase, ds.ModelParams.MaxPower, simscape.Value(55, "kW"))
      verifyEqual(testcase, ds.ModelParams.MeasuredEfficiencyPercent, 95)
      verifyEqual(testcase, ds.ModelParams.MeasuredAngularSpeed, simscape.Value(2000, "rpm"))
      verifyEqual(testcase, ds.ModelParams.MeasuredTorque, simscape.Value(50, "N*m"))
      verifyEqual(testcase, ds.ModelParams.MeasuredIronLoss, simscape.Value(55, "W"))
      verifyEqual(testcase, ds.ModelParams.FixedLoss, simscape.Value(40, "W"))
      verifyEqual(testcase, ds.ModelParams.RotorDamping, simscape.Value(0.05, "N*m/(rad/s)"))

    end  % function

    function Test_1_2(testcase)

      model_name = "SampleModel_AbstractMotor_refsub_24b";

      % Make sure the model exists in the MATLAB path.
      target_fullpath = FileUtil1.getFileFullPath(model_name);
      verifyTrue(testcase, isscalar(target_fullpath))
      verifyTrue(testcase, isfile(target_fullpath))

      % The target block uses the base workspace variables for the block parameters.
      % Load the variables from the script.
      evalin("base", "SampleParams_AbstractMotor")

      block_path = model_name + "/Motor & Drive (System Level)2";

      ds = AbstractMotor1.AbstractMotorDataSet(BlockPath=block_path);  % !test-target

      verifyEqual(testcase, ds.BlockPath, block_path)
      verifyEqual(testcase, ds.ModelName, model_name)
      verifyEqual(testcase, ds.ModelParams.MaxTorque, simscape.Value(160, "N*m"))
      verifyEqual(testcase, ds.ModelParams.MaxPower, simscape.Value(55, "kW"))
      verifyEqual(testcase, ds.ModelParams.MeasuredEfficiencyPercent, simscape.Value(95, "1"))
      verifyEqual(testcase, ds.ModelParams.MeasuredAngularSpeed, simscape.Value(2000, "rpm"))
      verifyEqual(testcase, ds.ModelParams.MeasuredTorque, simscape.Value(50, "N*m"))
      verifyEqual(testcase, ds.ModelParams.MeasuredIronLoss, simscape.Value(55, "W"))
      verifyEqual(testcase, ds.ModelParams.FixedLoss, simscape.Value(40, "W"))
      verifyEqual(testcase, ds.ModelParams.RotorDamping, simscape.Value(0.05, "N*m/(rad/s)"))

    end  % function

  end  % methods
end  % classdef
