classdef unittest_Vehicle1D < matlab.unittest.TestCase
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
      Vehicle1D1.Vehicle1DModelParameters  % !test-target
    end  % function

    function PassingTest_1_2(~)
      Vehicle1D1.Vehicle1DModelParameters(Initialization=true)  % !test-target
    end  % function

    function PassingTest_2_1(~)
      Vehicle1D1.Vehicle1DDataSet  % !test-target
    end  % function

    function PassingTest_2_2(~)
      Vehicle1D1.Vehicle1DDataSet(Initialization=true)  % !test-target
    end  % function

    function PassingTest_2_3(~)
      Vehicle1D1.Vehicle1DParameterPresets  % !test-target
    end  % function

    % -------------------------------------------------------------------------
    % plot - direct data source

    function PassingTest_3_1(~)
      Vehicle1D1.plotVehicle1DPerformance  % !test-target
    end  % function

    function PassingTest_3_2(~)
      Vehicle1D1.plotVehicle1DPerformance(DataSource="direct")  % !test-target
    end  % function

    % -------------------------------------------------------------------------
    % plot - external data source

    function PassingTest_4_1(~)
      Vehicle1D1.plotVehicle1DPerformance(DataSource="dataset")  % !test-target
    end  % function

    function PassingTest_4_2(~)
      ds = Vehicle1D1.Vehicle1DDataSet(Initialization=true);  % !test-target
      Vehicle1D1.plotVehicle1DPerformance(DataSource="dataset", DataSet=ds)  % !test-target
    end  % function

    function PassingTest_4_3(~)
      ds = Vehicle1D1.Vehicle1DDataSet(Initialization=true);
      ds.PlotSpeedUpperBound = simscape.Value(200, "mph");  % !test-target

      ds.ModelParams.VehicleMass = simscape.Value(1000, "lbm");  % !test-target

      % When modifying model parameters, make sure to update derived parameters.
      updateDerivedParameters(ds.ModelParams)

      Vehicle1D1.plotVehicle1DPerformance(DataSource="dataset", DataSet=ds)
    end  % function

    % -------------------------------------------------------------------------
    % SampleParams

    function PassingTest_5_1(~)
      SampleParams_Vehicle1D  % !test-target
    end  % function

    %% Tests - Derived parameters

    function Test_derived_1(testcase)
      params = Vehicle1D1.Vehicle1DModelParameters(Initialization=true);

      verifyTrue(testcase, value(params.RoadLoadA, "N") > 0)
      verifyTrue(testcase, value(params.RoadLoadC, "N/(m/s)^2") > 0)
      verifyTrue(testcase, value(params.MaxForce, "N") > 0)
      verifyTrue(testcase, value(params.MaxClimbPower, "kW") > 0)
    end  % function

    function Test_derived_2(testcase)
      params = Vehicle1D1.Vehicle1DModelParameters(Initialization=true);

      % RoadLoadA = C_roll * M_veh * g
      expected_A = value(params.TireRollingCoefficient * params.VehicleMass * params.GravitationalAcceleration, "N");
      actual_A = value(params.RoadLoadA, "N");
      verifyEqual(testcase, actual_A, expected_A, RelTol=1e-10)
    end  % function

    %% Tests - Presets

    function Test_presets_1(testcase)
      presets = Vehicle1D1.Vehicle1DParameterPresets;
      preset_dict = presets.PresetDictionary;

      verifyTrue(testcase, isKey(preset_dict, "Small car"))
      verifyTrue(testcase, isKey(preset_dict, "Medium car"))
      verifyTrue(testcase, isKey(preset_dict, "Large SUV"))
    end  % function

    function Test_presets_2(testcase)
      presets = Vehicle1D1.Vehicle1DParameterPresets;

      small = presets.PresetDictionary("Small car");
      verifyEqual(testcase, value(small.VehicleMass, "kg"), 1100)

      medium = presets.PresetDictionary("Medium car");
      verifyEqual(testcase, value(medium.VehicleMass, "kg"), 1800)

      large = presets.PresetDictionary("Large SUV");
      verifyEqual(testcase, value(large.VehicleMass, "kg"), 2600)
    end  % function

    function Test_presets_3(testcase)
      presets = Vehicle1D1.Vehicle1DParameterPresets;

      medium = presets.PresetDictionary("Medium car");
      verifyTrue(testcase, value(medium.RoadLoadA, "N") > 0)
      verifyTrue(testcase, value(medium.RoadLoadC, "N/(m/s)^2") > 0)
      verifyTrue(testcase, value(medium.MaxForce, "N") > 0)
      verifyTrue(testcase, value(medium.MaxClimbPower, "kW") > 0)
    end  % function

    %% Tests - DataSet update

    function Test_dataset_1(testcase)
      ds = Vehicle1D1.Vehicle1DDataSet(Initialization=true);

      verifyEqual(testcase, ds.NumSpeedPoints, 200)
      verifyEqual(testcase, numel(ds.PlotGrades), 5)
      verifyTrue(testcase, size(ds.VehicleForceValues, 1) == ds.NumSpeedPoints)
      verifyTrue(testcase, size(ds.VehicleForceValues, 2) == numel(ds.PlotGrades))
    end  % function

    function Test_dataset_2(testcase)
      ds = Vehicle1D1.Vehicle1DDataSet(Initialization=true);

      ds.ModelParams.VehicleMass = simscape.Value(2000, "kg");
      updateDataSet(ds);

      verifyTrue(testcase, value(ds.ModelParams.RoadLoadA, "N") > 0)
    end  % function

    %% Tests - ModelParameters uninitialized

    function Test_params_uninit_1(testcase)
      params = Vehicle1D1.Vehicle1DModelParameters(Initialization=false);

      verifyTrue(testcase, isnan(value(params.VehicleMass, "kg")))
      verifyTrue(testcase, isnan(params.TireRollingCoefficient))
      verifyTrue(testcase, isnan(params.AirDragCoefficient))
      verifyTrue(testcase, isnan(value(params.FrontalArea, "m^2")))
      verifyTrue(testcase, isnan(value(params.GravitationalAcceleration, "m/s^2")))
      verifyTrue(testcase, isnan(value(params.AirDensity, "kg/m^3")))
      verifyTrue(testcase, isnan(value(params.RoadLoadA, "N")))
      verifyTrue(testcase, isnan(value(params.RoadLoadC, "N/(m/s)^2")))
      verifyTrue(testcase, isnan(value(params.MaxForce, "N")))
      verifyTrue(testcase, isnan(value(params.MaxClimbPower, "kW")))
    end  % function

    %% Tests - DataSet uninitialized

    function Test_dataset_uninit_1(testcase)
      ds = Vehicle1D1.Vehicle1DDataSet;

      verifyTrue(testcase, isnan(value(ds.ModelParams.VehicleMass, "kg")))
      verifyEqual(testcase, ds.VehicleForceValues, simscape.Value([0, 0]', "N"))
    end  % function

    %% Tests - Derived parameters (additional)

    function Test_derived_RoadLoadC(testcase)
      params = Vehicle1D1.Vehicle1DModelParameters(Initialization=true);

      expected_C = value((1/2) * params.AirDragCoefficient * params.FrontalArea * params.AirDensity, "N/(m/s)^2");
      actual_C = value(params.RoadLoadC, "N/(m/s)^2");
      verifyEqual(testcase, actual_C, expected_C, RelTol=1e-10)
    end  % function

    function Test_derived_MaxForce(testcase)
      params = Vehicle1D1.Vehicle1DModelParameters(Initialization=true);

      expected_F = value(params.MaxAcceleration * params.VehicleMass * params.GravitationalAcceleration, "N");
      actual_F = value(params.MaxForce, "N");
      verifyEqual(testcase, actual_F, expected_F, RelTol=1e-10)
    end  % function

    function Test_derived_MaxClimbPower(testcase)
      params = Vehicle1D1.Vehicle1DModelParameters(Initialization=true);

      A_rl = params.RoadLoadA;
      B_rl = params.RoadLoadB;
      C_rl = params.RoadLoadC;
      v_max = params.TopSpeed;
      road_angle_max = simscape.Value(atan(params.MaxClimbGradePercent/100), "rad");
      F_max = (A_rl + B_rl*v_max)*cos(road_angle_max) + C_rl*v_max^2 ...
        + params.VehicleMass*params.GravitationalAcceleration*sin(road_angle_max);
      expected_P = value(F_max * v_max, "kW");
      actual_P = value(params.MaxClimbPower, "kW");
      verifyEqual(testcase, actual_P, expected_P, RelTol=1e-10)
    end  % function

    %% Tests - DataSet dimensions

    function Test_dataset_ForceAtConstantPower_size(testcase)
      ds = Vehicle1D1.Vehicle1DDataSet(Initialization=true);

      verifyEqual(testcase, size(ds.ForceValuesAtConstantPower, 1), ds.NumSpeedPoints)
      verifyEqual(testcase, size(ds.ForceValuesAtConstantPower, 2), numel(ds.PlotPowers))
    end  % function

    function Test_dataset_update_PlotGrades(testcase)
      ds = Vehicle1D1.Vehicle1DDataSet(Initialization=true);

      ds.PlotGrades = [0, 10, 20];
      updateDataSet(ds);

      verifyEqual(testcase, size(ds.VehicleForceValues, 1), ds.NumSpeedPoints)
      verifyEqual(testcase, size(ds.VehicleForceValues, 2), 3)
    end  % function

  end  % methods
end  % classdef
