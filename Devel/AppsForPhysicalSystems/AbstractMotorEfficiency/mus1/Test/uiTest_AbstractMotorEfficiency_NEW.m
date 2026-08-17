classdef uiTest_AbstractMotorEfficiency_NEW < matlab.uitest.TestCase
  % Tests for the constant power curve and auto-range bound sync fixes.
  %
  % These tests validate:
  % 1. Constant power curves span the full x-axis when MaxTorque is reduced
  %    below the threshold where auto-calculated speed exceeds the old
  %    hardcoded 18000 rpm bound.
  % 2. PlotAngularSpeedUpperBound and PlotTorqueUpperBound in the DataSet
  %    are updated to reflect effective values when PlotAutoRange is ON.
  % 3. The UI fields for plot bounds display the auto-computed values
  %    when PlotAutoRange is ON.

  % Copyright 2026 The MathWorks, Inc.

  methods (TestMethodSetup)

    function test_method_setup_1(testcase)
      %%
      close all
      bdclose all
      evalin("base", "clearvars")

      addTeardown(testcase, @closeAllAfterTest)
      function closeAllAfterTest
        figs = findall(0, Type="Figure");
        if not(any(isempty(figs)))
          delete(figs)
        end  % if
        bdclose all
      end  % nested function
    end  % function

  end  % methods

  methods (Test)

    %% DataSet: constant power curve speed vector matches effective plot bound

    function constant_power_speed_vector_auto_mode_below_threshold(testcase)
      %% When MaxTorque < ~117 N*m, auto speed exceeds 18000 rpm.
      % The constant power speed vector must extend to the auto-calculated speed.
      ds = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.ModelParams.MaxTorque = simscape.Value(110, "N*m");
      ds.PlotAutoRange = "on";
      ds.MaxAngularSpeedMode = "auto";
      ds = updateDataSet(ds);

      max_motor_power_W = value(ds.ModelParams.MaxPower, "W");
      max_motor_torque_Nm = value(ds.ModelParams.MaxTorque, "N*m");
      expected_speed_radps = max_motor_power_W / (ds.MaxAngularSpeedRate * max_motor_torque_Nm);
      expected_speed_rpm = value(simscape.Value(expected_speed_radps, "rad/s"), "rpm");

      actual_max_speed = value(ds.AngularSpeedValuesForConstantPower(end), "rpm");

      verifyEqual(testcase, actual_max_speed, expected_speed_rpm, RelTol=0.01)
    end  % function

    function constant_power_speed_vector_auto_mode_above_threshold(testcase)
      %% When MaxTorque > ~117 N*m, auto speed is below 18000 rpm.
      % The constant power speed vector must still match auto-calculated speed.
      ds = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.ModelParams.MaxTorque = simscape.Value(140, "N*m");
      ds.PlotAutoRange = "on";
      ds.MaxAngularSpeedMode = "auto";
      ds = updateDataSet(ds);

      max_motor_power_W = value(ds.ModelParams.MaxPower, "W");
      max_motor_torque_Nm = value(ds.ModelParams.MaxTorque, "N*m");
      expected_speed_radps = max_motor_power_W / (ds.MaxAngularSpeedRate * max_motor_torque_Nm);
      expected_speed_rpm = value(simscape.Value(expected_speed_radps, "rad/s"), "rpm");

      actual_max_speed = value(ds.AngularSpeedValuesForConstantPower(end), "rpm");

      verifyEqual(testcase, actual_max_speed, expected_speed_rpm, RelTol=0.01)
    end  % function

    function constant_power_speed_vector_specify_mode_auto_range(testcase)
      %% MaxAngularSpeedMode "specify" with PlotAutoRange ON.
      ds = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.MaxAngularSpeedMode = "specify";
      ds.MaxAngularSpeed = simscape.Value(12000, "rpm");
      ds.PlotAutoRange = "on";
      ds = updateDataSet(ds);

      actual_max_speed = value(ds.AngularSpeedValuesForConstantPower(end), "rpm");

      verifyEqual(testcase, actual_max_speed, 12000, RelTol=0.01)
    end  % function

    function constant_power_speed_vector_auto_range_off(testcase)
      %% PlotAutoRange OFF: use PlotAngularSpeedUpperBound.
      ds = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.PlotAutoRange = "off";
      ds.PlotAngularSpeedUpperBound = simscape.Value(25000, "rpm");
      ds = updateDataSet(ds);

      actual_max_speed = value(ds.AngularSpeedValuesForConstantPower(end), "rpm");

      verifyEqual(testcase, actual_max_speed, 25000, RelTol=0.01)
    end  % function

    %% DataSet: PlotAngularSpeedUpperBound and PlotTorqueUpperBound sync

    function plot_bounds_sync_auto_mode(testcase)
      %% PlotAngularSpeedUpperBound must reflect auto-calculated speed.
      ds = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.ModelParams.MaxTorque = simscape.Value(100, "N*m");
      ds.PlotAutoRange = "on";
      ds.MaxAngularSpeedMode = "auto";
      ds = updateDataSet(ds);

      max_motor_power_W = value(ds.ModelParams.MaxPower, "W");
      max_motor_torque_Nm = value(ds.ModelParams.MaxTorque, "N*m");
      expected_speed_radps = max_motor_power_W / (ds.MaxAngularSpeedRate * max_motor_torque_Nm);
      expected_speed_rpm = value(simscape.Value(expected_speed_radps, "rad/s"), "rpm");

      actual_bound_rpm = value(ds.PlotAngularSpeedUpperBound, "rpm");

      verifyEqual(testcase, actual_bound_rpm, expected_speed_rpm, RelTol=0.01)
    end  % function

    function plot_torque_bound_sync_auto_range(testcase)
      %% PlotTorqueUpperBound must reflect MaxTorque when PlotAutoRange is ON.
      ds = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.ModelParams.MaxTorque = simscape.Value(90, "N*m");
      ds.PlotAutoRange = "on";
      ds = updateDataSet(ds);

      verifyEqual(testcase, ds.PlotTorqueUpperBound, simscape.Value(90, "N*m"))
    end  % function

    function plot_bounds_not_overwritten_when_auto_range_off(testcase)
      %% PlotAngularSpeedUpperBound must NOT be overwritten when PlotAutoRange is OFF.
      ds = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyDataSet(Initialization=true);
      ds.PlotAutoRange = "off";
      ds.PlotAngularSpeedUpperBound = simscape.Value(20000, "rpm");
      ds.PlotTorqueUpperBound = simscape.Value(250, "N*m");
      ds = updateDataSet(ds);

      verifyEqual(testcase, value(ds.PlotAngularSpeedUpperBound, "rpm"), 20000, RelTol=0.01)
      verifyEqual(testcase, value(ds.PlotTorqueUpperBound, "N*m"), 250, RelTol=0.01)
    end  % function

    %% App UI: bound fields reflect auto-computed values

    function app_ui_speed_bound_updates_with_max_torque(testcase)
      %% When MaxTorque is changed and PlotAutoRange is ON, the speed bound UI must update.
      app = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyAppMain;

      type(testcase, app.MaxTorqueUI.ValueTextUI.MainEditField, "110")

      max_power_W = value(app.DataSet.ModelParams.MaxPower, "W");
      expected_speed_radps = max_power_W / (app.DataSet.MaxAngularSpeedRate * 110);
      expected_speed_rpm = value(simscape.Value(expected_speed_radps, "rad/s"), "rpm");

      actual_bound_rpm = value(app.PlotAngularSpeedUpperBoundUI.SimscapeValue, "rpm");

      verifyEqual(testcase, actual_bound_rpm, expected_speed_rpm, RelTol=0.01)
    end  % function

    function app_ui_torque_bound_updates_with_max_torque(testcase)
      %% When MaxTorque is changed and PlotAutoRange is ON, torque bound must reflect MaxTorque.
      app = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyAppMain;

      type(testcase, app.MaxTorqueUI.ValueTextUI.MainEditField, "90")

      actual_bound_Nm = value(app.PlotTorqueUpperBoundUI.SimscapeValue, "N*m");

      verifyEqual(testcase, actual_bound_Nm, 90, RelTol=0.01)
    end  % function

    function app_ui_bounds_not_overwritten_when_auto_range_off(testcase)
      %% When PlotAutoRange is OFF, bounds stay as user-specified.
      app = mus1.app.AbstractMotorEfficiency.AbstractMotorEfficiencyAppMain;

      % Turn off auto range.
      press(testcase, app.PlotAutoRangeUI.MainCheckBox)

      % Set custom bounds.
      type(testcase, app.PlotAngularSpeedUpperBoundUI.ValueTextUI.MainEditField, "22000")
      type(testcase, app.PlotTorqueUpperBoundUI.ValueTextUI.MainEditField, "300")

      % Change MaxTorque — bounds should not change.
      type(testcase, app.MaxTorqueUI.ValueTextUI.MainEditField, "100")

      actual_speed_bound = value(app.PlotAngularSpeedUpperBoundUI.SimscapeValue, "rpm");
      actual_torque_bound = value(app.PlotTorqueUpperBoundUI.SimscapeValue, "N*m");

      verifyEqual(testcase, actual_speed_bound, 22000, RelTol=0.01)
      verifyEqual(testcase, actual_torque_bound, 300, RelTol=0.01)
    end  % function

  end  % methods
end  % classdef
