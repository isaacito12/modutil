classdef unittest_AbstractMotorEfficiency_plot_and_DataSet < matlab.unittest.TestCase
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
      AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet
    end  % function

    function PassingTest_1_2(~)
      AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(Initialization=true)
    end  % function

    function PassingTest_2(~)
      AbstractMotorEfficiency_SampleParams1
    end  % function

    % -------------------------------------------------------------------------
    % The plot function
    %
    % For the visual inspection of a plot, manually run the content of a test function.
    % Programmatically running these tests only check that they run without errors.

    function Plot_1(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency
    end  % function

    function Plot_2(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency(ParentAxes = axes(uipanel))
    end  % function

    function Plot_3_1(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency(ThemeMode="manual", Theme="light", PlotContourLevelsPercent=[1 80 93 97])
    end  % function

    function Plot_3_2(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency(ThemeMode="manual", Theme="dark", ShowContourText="off")
    end  % function

    function Plot_3_3(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency(ThemeMode="auto", ShowTorqueEnvelope="off")
    end  % function

    % -------------------------------------------------------------------------
    % Test options for torque.

    function option_torque_1(~)
      % PlotAutoRange must appreciate MaxTorque for plot torque upper bound.
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "on", ... 
        MaxTorque = simscape.Value(100, "lbf*ft") );
    end  % function

    function option_torque_2_1(~)
      % PlotAutoRange is "off".
      % Torque is configured by MaxTorque and PlotTorqueUpperBound.
      %
      % MaxAngularSpeedMode is "on" by default, thus angular speed is automatically determined.
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "off", ...
        MaxTorque = simscape.Value(80, "N*m"), ...
        PlotTorqueUpperBound = simscape.Value(100, "N*m") );
    end  % function

    function option_torque_2_2(~)
      % Even when PlotAutoRange is "off", angular speed is still automatically determined by MaxAngularSpeedRate.
      % Compare this case with the previous one. (Visually inspect.)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "off", ...
        MaxTorque = simscape.Value(80, "N*m"), ...
        PlotTorqueUpperBound = simscape.Value(100, "N*m"), ...
        MaxAngularSpeedRate = 0.5 );
    end  % function

    % -------------------------------------------------------------------------
    % Test options for angular speed.

    function option_speed_1_1(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "on", ...
        MaxAngularSpeedMode = "auto" );
    end  % function

    function option_speed_1_2(~)
      % MaxAngularSpeed is ignored when MaxAngularSpeedMode is "auto".
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "on", ...
        MaxAngularSpeedMode = "auto", ...
        MaxAngularSpeed = simscape.Value(6000, "rpm") );  % must be ignored.
    end  % function

    function option_speed_1_3(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "on", ...
        MaxAngularSpeedMode = "auto", ...
        MaxAngularSpeed = simscape.Value(6000, "rpm"), ... must be ignored.
        MaxAngularSpeedRate = 0.5);  % must be used.
    end  % function

    % -------------------------------------------------------------------------
    % PlotAutoRange = "on"
    % and
    % MaxAngularSpeedMode = "specify"
    %
    % When PlotAutoRange is "on", it is not recommended to use MaxAngularSpeedMode="specify",
    % but it should still work.

    function option_speed_2_1_1(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "on", ...
        MaxAngularSpeedMode = "specify" );
    end  % function

    function option_speed_2_1_2(~)
      % MaxAngularSpeedRate is used only when MaxAngularSpeedMode is "auto".
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "on", ...
        MaxAngularSpeedMode = "specify", ...
        MaxAngularSpeedRate = 0.6 );  % must be ignored.
    end  % function

    function option_speed_2_1_3(~)
      % MaxAngularSpeed can be specified, but the plot angular speed upper bound is
      % determined by the plot auto range logic.
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "on", ...
        MaxAngularSpeedMode = "specify", ...
        MaxAngularSpeedRate = 0.6, ... must be ignored.
        MaxAngularSpeed = simscape.Value(6000, "rpm") );  % must be used.
    end  % function

    function option_speed_2_1_4(~)
      % PlotAngularSpeedUpperBound can be used to override the plot auto range logic.
      % In this case, the plot auto range logic works for the torque only.
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "on", ...
        MaxAngularSpeedMode = "specify", ...
        MaxAngularSpeedRate = 0.6, ... must be ignored.
        MaxAngularSpeed = simscape.Value(6000, "rpm"), ... must be used.
        PlotAngularSpeedUpperBound = simscape.Value(7000, "rpm") );  % must be used.
    end  % function

    function option_speed_2_1_5(~)
      % If PlotAutoRange is "on", MaxTorque is used but PlotTorqueUpperBound is ignored.
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "on", ...
        MaxAngularSpeedMode = "specify", ...
        MaxAngularSpeedRate = 0.6, ... must be ignored.
        MaxAngularSpeed = simscape.Value(6000, "rpm"), ... must be used.
        PlotAngularSpeedUpperBound = simscape.Value(7000, "rpm"), ... must be used.
        MaxTorque = simscape.Value(200, "N*m"), ...
        PlotTorqueUpperBound = simscape.Value(210, "N*m") );  % must be ignored.
    end  % function

    % -------------------------------------------------------------------------
    % PlotAutoRange = "off"
    % and
    % MaxAngularSpeedMode = "specify"

    function option_speed_2_2(~)
      % To use PlotTorqueUpperBound, PlotAutoRange must be "off".
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotAutoRange = "off", ... Must be off for the plot torque upper bound.
        MaxAngularSpeedMode = "specify", ...
        MaxAngularSpeedRate = 0.6, ... must be ignored.
        MaxAngularSpeed = simscape.Value(6000, "rpm"), ... must be used.
        PlotAngularSpeedUpperBound = simscape.Value(7000, "rpm"), ... must be used.
        MaxTorque = simscape.Value(200, "N*m"), ...
        PlotTorqueUpperBound = simscape.Value(250, "N*m") );  % must be used.
    end  % function

    % -------------------------------------------------------------------------
    % Additional coverage tests for the plot function.

    function option_speed_6(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        MaxAngularSpeedMode = "specify", ...
        MaxAngularSpeedRate = 0.3, ...
        PlotAutoRange = "on" );
    end  % function

    function option_speed_7(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        MaxAngularSpeedMode = "specify", ...
        PlotAutoRange = "off", ...
        PlotAngularSpeedUpperBound = simscape.Value(2000, "rad/s") );
    end  % function

    function option_resolution_1(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency( ...
        PlotResolution = 50 );
    end  % function

    function Plot_output_1(testcase)
      fig = AbstractMotorEfficiency1.plotAbstractMotorEfficiency;
      verifyTrue(testcase, isa(fig, 'matlab.ui.Figure'))
    end  % function

    function Plot_error_contour_levels(testcase)
      verifyError(testcase, @test_target, "plotAbstractMotorEfficiency:NotEnoughElements")
      function test_target
        AbstractMotorEfficiency1.plotAbstractMotorEfficiency(PlotContourLevelsPercent=[50 90])  % !test-target
      end  % nested function
    end  % function

    % -------------------------------------------------------------------------

    function Plot_error_1(testcase)
      verifyError(testcase, @test_target, "MATLAB:validation:UnableToConvert")
      function test_target
        % ParentAxes must be of type matlab.graphics.axis.Axes.
        % Directly passing uipanel to ParentAxes must fail.
        % (To use uipanel, pass axes(uipanel) to ParentAxes.)
        AbstractMotorEfficiency1.plotAbstractMotorEfficiency(ParentAxes = uipanel)  % !test-target
      end  % nested function
    end  % function

    % -------------------------------------------------------------------------
    % The plot function with the data set
    %
    % For the visual inspection of a plot, manually run the content of a test function.
    % Programmatically running these tests only check that they run without errors.

    function Plot_DataSet_1(~)
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency(DataSource="dataset")  % !test-target
    end  % function

    function Plot_DataSet_2_1(~)
      ds = AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(Initialization=true);
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency(DataSource="dataset", DataSet=ds)  % !test-target
    end  % function

    function Plot_DataSet_2_2(~)
      ds = AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(Initialization=true);

      ds.PlotAutoRange = "off";

      % When PlotAutoRange is "off", PlotTorqueUpperBound is used.
      ds.PlotTorqueUpperBound = simscape.Value(160, "lbf*ft");
      ds.ModelParams.MaxTorque = simscape.Value(150, "lbf*ft");

      % When PlotAutoRange is "off" and MaxAngularSpeedMode is "specify", PlotAngularSpeedUpperBound is used.
      ds.MaxAngularSpeedMode = "specify";
      ds.PlotAngularSpeedUpperBound = simscape.Value(2000, "rad/s");
      ds.MaxAngularSpeed = simscape.Value(1800, "rad/s");

      ds.ModelParams.MaxPower = simscape.Value(90, "kW");

      updateDataSet(ds)

      AbstractMotorEfficiency1.plotAbstractMotorEfficiency(DataSource="dataset", DataSet=ds)  % !test-target
    end  % function

    function Plot_DataSet_2_3(~)
      ds = AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.ShowContourText = "off";
      ds.ShowTorqueEnvelope = "off";
      AbstractMotorEfficiency1.plotAbstractMotorEfficiency(DataSource="dataset", DataSet=ds)  % !test-target
    end  % function

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
        MaxTorque = simscape.Value(10, "N*m"), ...
        MaxPower = simscape.Value(10, "kW"), ...
        OverallEfficiencyPercent = 94, ...
        MeasuredAngularSpeed = simscape.Value(30, "rad/s"), ...
        MeasuredTorque = simscape.Value(5, "N*m"), ...
        MeasuredIronLosses = simscape.Value(1, "W") );

      ds = AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.ModelParams.MaxTorque = simscape.Value(10, "N*m");
      ds.ModelParams.MaxPower = simscape.Value(10, "kW");
      ds.ModelParams.OverallEfficiencyPercent = 94;
      ds.ModelParams.MeasuredAngularSpeed = simscape.Value(30, "rad/s");
      ds.ModelParams.MeasuredTorque = simscape.Value(5, "N*m");
      ds.ModelParams.MeasuredIronLosses = simscape.Value(1, "W");
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

    %% Tests

    function Test_1_1(testcase)
      model_name = "AbstractMotorEfficiency_SampleModel_refsub_24b";

      % Make sure the model exists in the MATLAB path.
      target_fullpath = FileUtil1.getFileFullPath(model_name);
      verifyTrue(testcase, isscalar(target_fullpath))
      verifyTrue(testcase, isfile(target_fullpath))

      block_path = model_name + "/Motor & Drive (System Level)1";

      ds = AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(BlockPath=block_path);  % !test-target

      verifyEqual(testcase, ds.BlockPath, block_path)
      verifyEqual(testcase, ds.ModelName, model_name)
      verifyEqual(testcase, ds.ModelParams.MaxTorque, simscape.Value(160, "N*m"))
      verifyEqual(testcase, ds.ModelParams.MaxPower, simscape.Value(55, "kW"))
      verifyEqual(testcase, ds.ModelParams.OverallEfficiencyPercent, 95)
      verifyEqual(testcase, ds.ModelParams.MeasuredAngularSpeed, simscape.Value(2000, "rpm"))
      verifyEqual(testcase, ds.ModelParams.MeasuredTorque, simscape.Value(50, "N*m"))
      verifyEqual(testcase, ds.ModelParams.MeasuredIronLosses, simscape.Value(55, "W"))
      verifyEqual(testcase, ds.ModelParams.FixedLosses, simscape.Value(40, "W"))
      verifyEqual(testcase, ds.ModelParams.RotorDampingCoefficient, simscape.Value(0.05, "N*m/(rad/s)"))

    end  % function

    function Test_1_2(testcase)

      model_name = "AbstractMotorEfficiency_SampleModel_refsub_24b";

      % Make sure the model exists in the MATLAB path.
      target_fullpath = FileUtil1.getFileFullPath(model_name);
      verifyTrue(testcase, isscalar(target_fullpath))
      verifyTrue(testcase, isfile(target_fullpath))

      % The target block uses the base workspace variables for the block parameters.
      % Load the variables from the script.
      evalin("base", "AbstractMotorEfficiency_SampleParams2")

      block_path = model_name + "/Motor & Drive (System Level)2";

      ds = AbstractMotorEfficiency1.AbstractMotorEfficiencyDataSet(BlockPath=block_path);  % !test-target

      verifyEqual(testcase, ds.BlockPath, block_path)
      verifyEqual(testcase, ds.ModelName, model_name)
      verifyEqual(testcase, ds.ModelParams.MaxTorque, simscape.Value(160, "N*m"))
      verifyEqual(testcase, ds.ModelParams.MaxPower, simscape.Value(55, "kW"))
      verifyEqual(testcase, ds.ModelParams.OverallEfficiencyPercent, simscape.Value(95, "1"))
      verifyEqual(testcase, ds.ModelParams.MeasuredAngularSpeed, simscape.Value(2000, "rpm"))
      verifyEqual(testcase, ds.ModelParams.MeasuredTorque, simscape.Value(50, "N*m"))
      verifyEqual(testcase, ds.ModelParams.MeasuredIronLosses, simscape.Value(55, "W"))
      verifyEqual(testcase, ds.ModelParams.FixedLosses, simscape.Value(40, "W"))
      verifyEqual(testcase, ds.ModelParams.RotorDampingCoefficient, simscape.Value(0.05, "N*m/(rad/s)"))

    end  % function

  end  % methods
end  % classdef
