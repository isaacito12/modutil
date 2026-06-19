classdef unittest_RotationalFrictionTorque < matlab.unittest.TestCase
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
      RotationalFrictionTorque1.RotationalFrictionTorqueModelParameters  % !test-target
    end  % function

    function PassingTest_1_2(~)
      RotationalFrictionTorque1.RotationalFrictionTorqueModelParameters(Initialization=true)  % !test-target
    end  % function

    function PassingTest_2_1(~)
      RotationalFrictionTorque1.RotationalFrictionTorqueDataSet  % !test-target
    end  % function

    function PassingTest_2_2(~)
      RotationalFrictionTorque1.RotationalFrictionTorqueDataSet(Initialization=true)  % !test-target
    end  % function

    function PassingTest_3_1(~)
      RotationalFrictionTorque_SampleParams1  % !test-target
    end  % function

    function PassingTest_3_2(~)
      RotationalFrictionTorque_SampleParams2  % !test-target
    end  % function

    function PassingTest_4_1(~)
      RotationalFrictionTorque1.plotRotationalFrictionTorque  % !test-target
    end  % function

    function PassingTest_4_2(~)
      RotationalFrictionTorque1.plotRotationalFrictionTorque(DataSource="direct")  % !test-target
    end  % function

    function PassingTest_4_3(~)
      RotationalFrictionTorque1.plotRotationalFrictionTorque(DataSource="dataset")  % !test-target
    end  % function

    function PassingTest_4_4(~)
      ds = RotationalFrictionTorque1.RotationalFrictionTorqueDataSet(Initialization=true);

      ds.PlotAngularVelocityUnit = "rad/s";
      ds.PlotTorqueUnit = "lbf*ft";

      ds.ModelParams.ViscousCoefficient = simscape.Value(0.1, "N*m/(rad/s)");

      RotationalFrictionTorque1.plotRotationalFrictionTorque(DataSource="dataset", DataSet=ds)  % !test-target

    end  % function

    function PassingTest_4_5_output_arg(testcase)
      fig = RotationalFrictionTorque1.plotRotationalFrictionTorque;
      addTeardown(testcase, @() delete(fig))
      verifyClass(testcase, fig, ?matlab.ui.Figure)
    end  % function

    %% Tests

    function Test_1_1(testcase)
      model_name = "RotationalFrictionTorque_SampleModel_refsub_24b";

      % Make sure the model exists in the MATLAB path.
      target_fullpath = FileUtil1.getFileFullPath(model_name);
      verifyTrue(testcase, isscalar(target_fullpath))
      verifyTrue(testcase, isfile(target_fullpath))

      block_path = model_name + "/Rotational Friction1";

      ds = RotationalFrictionTorque1.RotationalFrictionTorqueDataSet(BlockPath=block_path);  % !test-target

      verifyEqual(testcase, ds.BlockPath, block_path)
      verifyEqual(testcase, ds.ModelName, model_name)
      verifyEqual(testcase, ds.ModelParams.BreakawayTorque, simscape.Value(50, "N*m"))
      verifyEqual(testcase, ds.ModelParams.BreakawayVelocity, simscape.Value(10, "rpm"))
      verifyEqual(testcase, ds.ModelParams.CoulombTorque, simscape.Value(10, "N*m"))
      verifyEqual(testcase, ds.ModelParams.ViscousCoefficient, simscape.Value(0.3, "N*m/rpm"))

    end  % function

    function Test_1_2(testcase)

      model_name = "RotationalFrictionTorque_SampleModel_refsub_24b";

      % Make sure the model exists in the MATLAB path.
      target_fullpath = FileUtil1.getFileFullPath(model_name);
      verifyTrue(testcase, isscalar(target_fullpath))
      verifyTrue(testcase, isfile(target_fullpath))

      % The target block uses a variable in the base workspace.
      % Load the variables from the script.
      evalin("base", "RotationalFrictionTorque_SampleParams2")

      block_path = model_name + "/Rotational Friction2";

      ds = RotationalFrictionTorque1.RotationalFrictionTorqueDataSet(BlockPath=block_path);  % !test-target

      verifyEqual(testcase, ds.BlockPath, block_path)
      verifyEqual(testcase, ds.ModelName, model_name)
      verifyEqual(testcase, ds.ModelParams.BreakawayTorque, simscape.Value(400, "lbf*in"))
<<<<<<< HEAD:Devel/AppsForPhysicalSystems/RotationalFrictionTorque/Test/unittest_RotationalFrictionTorque.m
      verifyEqual(testcase, ds.ModelParams.BreakawayVelocity, simscape.Value(10, "rpm"))
      verifyEqual(testcase, ds.ModelParams.CoulombTorque, simscape.Value(300, "lbf*in"))
      verifyEqual(testcase, ds.ModelParams.ViscousCoefficient, simscape.Value(1, "lbf*in/rpm"))
=======
      verifyEqual(testcase, ds.ModelParams.BreakawayVelocity, simscape.Value(0.3, "rev/s"))
      verifyEqual(testcase, ds.ModelParams.CoulombTorque, simscape.Value(200, "lbf*in"))
      verifyEqual(testcase, ds.ModelParams.ViscousCoefficient, simscape.Value(50, "lbf*in/(rev/s)"))
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/RotationalFriction/Test/unittest_RotationalFriction.m

    end  % function

    function Test_DataSet_invalid_block_type(testcase)
      % Pass a block that exists but is not a Rotational Friction block.
      model_filename = FileUtil1.getUnusedFilename("temp_RotFric_wrongtype.mdl");
      [~, model_name, ~] = fileparts(model_filename);
      new_system(model_name)
      add_block("fl_lib/Mechanical/Rotational Elements/Rotational Spring", model_name + "/Spring")
      save_system(model_name)
      addTeardown(testcase, @() cleanup())
      function cleanup
        bdclose(model_name)
        if isfile(model_filename), delete(model_filename); end
      end  % nested function
      block_path = model_name + "/Spring";
      verifyError(testcase, ...
        @() RotationalFrictionTorque1.RotationalFrictionTorqueDataSet(BlockPath=block_path), ...
        "RotationalFrictionTorqueDataSet:InvalidBlock")
    end  % function

  end  % methods
end  % classdef
