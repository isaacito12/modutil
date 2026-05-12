classdef unittest_RotationalFriction < matlab.unittest.TestCase
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
      RotationalFriction1.RotationalFrictionModelParameters  % !test-target
    end  % function

    function PassingTest_1_2(~)
      RotationalFriction1.RotationalFrictionModelParameters(Initialization=true)  % !test-target
    end  % function

    function PassingTest_2_1(~)
      RotationalFriction1.RotationalFrictionDataSet  % !test-target
    end  % function

    function PassingTest_2_2(~)
      RotationalFriction1.RotationalFrictionDataSet(Initialization=true)  % !test-target
    end  % function

    function PassingTest_3(~)
      SampleParams_RotationalFriction  % !test-target
    end  % function

    function PassingTest_4_1(~)
      RotationalFriction1.plotRotationalFrictionTorque  % !test-target
    end  % function

    function PassingTest_4_2(~)
      RotationalFriction1.plotRotationalFrictionTorque(DataSource="direct")  % !test-target
    end  % function

    function PassingTest_4_3(~)
      RotationalFriction1.plotRotationalFrictionTorque(DataSource="dataset")  % !test-target
    end  % function

    function PassingTest_4_4(~)
      ds = RotationalFriction1.RotationalFrictionDataSet(Initialization=true);

      ds.PlotVelocityUnit = "rad/s";
      ds.PlotTorqueUnit = "lbf*ft";

      ds.ModelParams.ViscousCoefficient = simscape.Value(0.1, "N*m/(rad/s)");

      RotationalFriction1.plotRotationalFrictionTorque(DataSource="dataset", DataSet=ds)  % !test-target

    end  % function

    %% Tests

    function Test_1_1(testcase)
      model_name = "SampleModel_RotationalFriction_refsub_24b";

      % Make sure the model exists in the MATLAB path.
      target_fullpath = FileUtil1.getFileFullPath(model_name);
      verifyTrue(testcase, isscalar(target_fullpath))
      verifyTrue(testcase, isfile(target_fullpath))

      block_path = model_name + "/Rotational Friction1";

      ds = RotationalFriction1.RotationalFrictionDataSet(BlockPath=block_path);  % !test-target

      verifyEqual(testcase, ds.BlockPath, block_path)
      verifyEqual(testcase, ds.ModelName, model_name)
      verifyEqual(testcase, ds.ModelParams.BreakawayTorque, simscape.Value(50, "N*m"))
      verifyEqual(testcase, ds.ModelParams.BreakawayVelocity, simscape.Value(10, "rpm"))
      verifyEqual(testcase, ds.ModelParams.CoulombTorque, simscape.Value(10, "N*m"))
      verifyEqual(testcase, ds.ModelParams.ViscousCoefficient, simscape.Value(0.3, "N*m/rpm"))

    end  % function

    function Test_1_2(testcase)

      model_name = "SampleModel_RotationalFriction_refsub_24b";

      % Make sure the model exists in the MATLAB path.
      target_fullpath = FileUtil1.getFileFullPath(model_name);
      verifyTrue(testcase, isscalar(target_fullpath))
      verifyTrue(testcase, isfile(target_fullpath))

      % The target block uses the base workspace variables for the block parameters.
      % Load the variables from the script.
      evalin("base", "SampleParams_RotationalFriction")

      block_path = model_name + "/Rotational Friction2";

      ds = RotationalFriction1.RotationalFrictionDataSet(BlockPath=block_path);  % !test-target

      verifyEqual(testcase, ds.BlockPath, block_path)
      verifyEqual(testcase, ds.ModelName, model_name)
      verifyEqual(testcase, ds.ModelParams.BreakawayTorque, simscape.Value(400, "lbf*in"))
      verifyEqual(testcase, ds.ModelParams.BreakawayVelocity, simscape.Value(0.3, "rev/s"))
      verifyEqual(testcase, ds.ModelParams.CoulombTorque, simscape.Value(200, "lbf*in"))
      verifyEqual(testcase, ds.ModelParams.ViscousCoefficient, simscape.Value(50, "lbf*in/(rev/s)"))

    end  % function

  end  % methods
end  % classdef
