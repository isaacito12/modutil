classdef unittest_AbstractMotorEfficiency_core < matlab.unittest.TestCase
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

    function Test_DataSet_1(testcase)
      %%

      ds = AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(Initialization=true);

      verifyTrue(testcase, ds.PlotResolution > 3)

      N = ds.PlotResolution;

      verifyTrue(testcase, numel(ds.AngularSpeedValues) == N)
      verifyTrue(testcase, all(ds.AngularSpeedValues > 0))

      verifyTrue(testcase, numel(ds.TorqueValues) == N)
      verifyTrue(testcase, all(ds.TorqueValues >= 0))

      verifyTrue(testcase, numel(ds.TorqueEnvelopeValues) == N)
      verifyTrue(testcase, all(ds.TorqueEnvelopeValues > 0))

      verifyTrue(testcase, all(all(ds.EfficiencyPercentMeshData >= 0)))

    end  % function

    function Test_DataSet_2(testcase)
      %%

      [~, result_direct] = AbstractMotorEfficiency1.plotAbstractMotorEfficiency(DataSource="direct");

      ds = AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(Initialization=true);
      [~, result_dataset] = AbstractMotorEfficiency1.plotAbstractMotorEfficiency(DataSource="dataset", DataSet=ds);

      u1 = string(unit(result_direct.TorqueValues));
      u2 = string(unit(result_dataset.TorqueValues));
      verifyEqual(testcase, u1, u2)
      v1 = value(result_direct.TorqueValues);
      v2 = value(result_dataset.TorqueValues);
      verifyEqual(testcase, v1, v2, AbsTol=0.01)

      u1 = string(unit(result_direct.AngularSpeedValues));
      u2 = string(unit(result_dataset.AngularSpeedValues));
      verifyEqual(testcase, u1, u2)
      v1 = value(result_direct.AngularSpeedValues);
      v2 = value(result_dataset.AngularSpeedValues);
      verifyEqual(testcase, v1, v2, AbsTol=0.01)

      u1 = string(unit(result_direct.TorqueEnvelopeValues));
      u2 = string(unit(result_dataset.TorqueEnvelopeValues));
      verifyEqual(testcase, u1, u2)
      v1 = value(result_direct.TorqueEnvelopeValues);
      v2 = value(result_dataset.TorqueEnvelopeValues);
      verifyEqual(testcase, v1, v2, AbsTol=0.01)

      % EfficiencyPercentMeshData is of type double, not simscape.Value.
      v1 = result_direct.EfficiencyPercentMeshData;
      v2 = result_dataset.EfficiencyPercentMeshData;
      verifyEqual(testcase, v1, v2, AbsTol=0.01)

    end  % function

    function Test_DataSet_3(testcase)
      %%

      [~, result_direct] = AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        DataSource = "direct", ...
        MaxTorque = simscape.Value(123, "N*m"), ...
        MaxPower = simscape.Value(150, "kW") );

      ds = AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.ModelParams.MaxTorque = simscape.Value(123, "N*m");
      ds.ModelParams.MaxPower = simscape.Value(150, "kW");
      ds = updateDataSet(ds);
      [~, result_dataset] = AbstractMotorEfficiency1.plotAbstractMotorEfficiency(DataSource="dataset", DataSet=ds);

      u1 = string(unit(result_direct.TorqueValues));
      u2 = string(unit(result_dataset.TorqueValues));
      verifyEqual(testcase, u1, u2)
      v1 = value(result_direct.TorqueValues);
      v2 = value(result_dataset.TorqueValues);
      verifyEqual(testcase, v1, v2, AbsTol=0.01)

      u1 = string(unit(result_direct.AngularSpeedValues));
      u2 = string(unit(result_dataset.AngularSpeedValues));
      verifyEqual(testcase, u1, u2)
      v1 = value(result_direct.AngularSpeedValues);
      v2 = value(result_dataset.AngularSpeedValues);
      verifyEqual(testcase, v1, v2, AbsTol=0.01)

      u1 = string(unit(result_direct.TorqueEnvelopeValues));
      u2 = string(unit(result_dataset.TorqueEnvelopeValues));
      verifyEqual(testcase, u1, u2)
      v1 = value(result_direct.TorqueEnvelopeValues);
      v2 = value(result_dataset.TorqueEnvelopeValues);
      verifyEqual(testcase, v1, v2, AbsTol=0.01)

      % EfficiencyPercentMeshData is of type double, not simscape.Value.
      v1 = result_direct.EfficiencyPercentMeshData;
      v2 = result_dataset.EfficiencyPercentMeshData;
      verifyEqual(testcase, v1, v2, AbsTol=0.01)

    end  % function

  end  % methods
end  % classdef
