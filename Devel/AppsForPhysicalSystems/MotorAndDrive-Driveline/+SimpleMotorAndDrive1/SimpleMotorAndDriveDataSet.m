classdef SimpleMotorAndDriveDataSet < handle
  % Data set for the simple motor and drive model and block for visualization.
  %
  % This class holds a complete data set required to visualize the efficiency contour of
  % the motor and drive model. The model is used by the Motor & Drive block in Simscape Driveline.
  %
  % Calling this class without any options creates an instance without initializing some properties.
  % To create an instance ready for visualization, use Initialization=true.
  %
  % To create an instance initialized with parameters defined in a Motor & Drive block in a model,
  % use the BlockPath option to specify the block path.

  % Copyright 2026 The MathWorks, Inc.

  properties (Access=private, Constant)
    errorID (1,1) string = "SimpleMotorAndDriveDataSet:"
  end  % properties

  properties

    % Parameters of the simple motor and drive model
    ModelParams (1,1) SimpleMotorAndDrive1.SimpleMotorAndDriveParameters = SimpleMotorAndDrive1.SimpleMotorAndDriveParameters(Initialization=true)

    % Block path to the target Motor & Drive block in a model
    BlockPath (1,1) string = ""
    ModelName (1,1) string = ""

    PlotResolution { mustBeInteger, mustBePositive } = 10

    % -------------------------------------------------------------------------
    % X axis - Angular speed

    % Values of angular speed (X axis)
    SpeedValues (:,1) simscape.Value { mustBeVector, simscape.mustBeCommensurateUnit(SpeedValues, "rad/s") } = simscape.Value([0, 1]', "rpm")

    % Physical unit of angular speed for plot (X axis)
    PlotSpeedUnit simscape.Unit { simscape.mustBeCommensurateUnit(PlotSpeedUnit, "rad/s") } = simscape.Unit("rpm")

    % Plot upper bound of angular speed
    PlotSpeedMax simscape.Value { mustBeScalarOrEmpty, simscape.mustBeCommensurateUnit(PlotSpeedMax, "rad/s") } = simscape.Value(1, "rpm")

    % In the road vehicle applications, maximum motor speed is determined by vehicle top speed,
    % tire rolling radius, and reduction gear ratio.
    % The simple motor and drive model and the Motor & Drive block do not have a parameter for the max speed.
    MaxMotorSpeed (1,1) simscape.Value { CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "rpm")

    % Minimum value of angular speed data
    % MotorSpeedMin simscape.Value { mustBeScalarOrEmpty, simscape.mustBeCommensurateUnit(MotorSpeedMin, "rad/s") } = simscape.Value(0, "rpm")

    % -------------------------------------------------------------------------
    % Y axis - Motor torque

    % Data set of torque
    TorqueValues (:,1) simscape.Value { mustBeVector, simscape.mustBeCommensurateUnit(TorqueValues, "N*m") } = simscape.Value([0, 0]', "N*m")

    % Physical unit of torque for plot (Y axis)
    PlotTorqueUnit simscape.Unit { simscape.mustBeCommensurateUnit(PlotTorqueUnit, "N*m") } = simscape.Unit("N*m")

    % Plot upper bound of torque
    PlotTorqueMax simscape.Value { mustBeScalarOrEmpty, simscape.mustBeCommensurateUnit(PlotTorqueMax, "N*m") } = simscape.Value(nan, "N*m")

    % -------------------------------------------------------------------------
    % X-Y data

    % Contour levels need 3 or more points for lower bound, upper bound,
    % and one or more points in between.
    ContourLevelsPercent (1,:) double { mustBeNonnegative } = [0 50 99]

    EfficiencyPercentMeshData double = zeros(2, 2);

    % -------------------------------------------------------------------------
    % States of plot app

    % State of enabled button (button with enable/disable check box) for plot auto-update
    AutoUpdatePlot matlab.lang.OnOffSwitchState = "on"

  end  % properties

  methods

    function DataSet = SimpleMotorAndDriveDataSet(NameValuePair)
      %%
      arguments (Input)
        NameValuePair.Initialization (1,1) logical = false
        NameValuePair.BlockPath (1,1) string = ""
      end  % arguments

      if NameValuePair.BlockPath ~= ""
        DataSet.BlockPath = NameValuePair.BlockPath;
        DataSet.ModelName = extractBefore(NameValuePair.BlockPath, "/");

        NameValuePair.Initialization = true;
      end  % if

      if not(NameValuePair.Initialization)

        return

      end  % if

      if DataSet.ModelName == ""
        % Set up a data set using default values.

        resetDataSet(DataSet)

      else
        % Set up a data set using the specified block in the model.

        load_system(DataSet.ModelName)

        DataSet.ModelParams.MaxTorque = ModelUtil1.getSimscapeValueFromBlockParameter(DataSet.BlockPath, "torque_max");
        DataSet.ModelParams.MaxPower = ModelUtil1.getSimscapeValueFromBlockParameter(DataSet.BlockPath, "power_max");
        DataSet.ModelParams.TorqueControlTimeConstant = ModelUtil1.getSimscapeValueFromBlockParameter(DataSet.BlockPath, "Tc");
        DataSet.ModelParams.MeasuredEfficiencyPercent = ModelUtil1.getSimscapeValueFromBlockParameter(DataSet.BlockPath, "eff");
        DataSet.ModelParams.MeasuredSpeed = ModelUtil1.getSimscapeValueFromBlockParameter(DataSet.BlockPath, "w_eff");
        DataSet.ModelParams.MeasuredTorque = ModelUtil1.getSimscapeValueFromBlockParameter(DataSet.BlockPath, "T_eff");
        DataSet.ModelParams.ThermalPort = ModelUtil1.getSimscapeValueFromBlockParameter(DataSet.BlockPath, "thermal_port");

        resetCommonSettings(DataSet)
      end  % if

      updateMotorTorqueValues(DataSet)
    end  % function

    function resetDataSet(DataSet)
      %%
      resetPublicParameters(DataSet.ModelParams)
      resetCommonSettings(DataSet)
    end  % function

    function resetCommonSettings(DataSet)
      %%
      DataSet.MaxMotorSpeed = simscape.Value(15000, "rpm");

      DataSet.ContourLevelsPercent = [1 60 80 90 92 94 96 97 98 99];
      DataSet.PlotResolution = 500;

      DataSet.PlotSpeedUnit = "rpm";
      DataSet.PlotSpeedMax = simscape.Value(17000, "rpm");

      DataSet.PlotTorqueUnit = "N*m";
      DataSet.PlotTorqueMax = simscape.Value(600, "N*m");

      DataSet.AutoUpdatePlot = "on";
    end  % function

    function updateMotorTorqueValues(DataSet)
      %%
      max_motor_torque_Nm = value(DataSet.ModelParams.MaxTorque, "N*m");
      max_motor_speed_rpm = value(DataSet.MaxMotorSpeed, "rpm");
      max_motor_power_W = value(DataSet.ModelParams.MaxPower, "W");
      eff_norm = value(DataSet.ModelParams.MeasuredEfficiencyPercent, "1") / 100;
      spd_eff_rpm = value(DataSet.ModelParams.MeasuredSpeed, "rpm");
      trq_eff_Nm = value(DataSet.ModelParams.MeasuredTorque, "N*m");

      iron_to_nominal_loss_ratio = 0;  % 0 in the simple motor and drive model.
      loss_const_W = 0;  % 0 in the simple motor and drive model.
      k_damp = 0;  % this could be non zero if the model has a frictional loss block.

      contour_levels = DataSet.ContourLevelsPercent;
      if numel(contour_levels) <= 2
        id = DataSet.errorID + "InvalidContourLevels";
        msg = CodeUtil1.i18n("Contour needs 3 or more levels.");

        throw(MException(id, msg))

      end  % if

      plot_resolution = DataSet.PlotResolution;

      % -----------------------------------------------------------------------
      % Derived parameters
      % !todo: Manage derived parameters in the SimpleMotorAndDriveParameters class.

      spd_eff_radps = spd_eff_rpm*2*pi/60;

      % Mechanical power at efficiency measurement point
      mechpow_eff = spd_eff_radps * trq_eff_Nm;

      % Nominal loss (total loss) at efficiency measurement point
      nominal_loss_eff = (1/eff_norm - 1) * mechpow_eff;

      % Iron loss at efficiency measurement point
      iron_loss_eff = iron_to_nominal_loss_ratio * nominal_loss_eff;

      % Copper loss at efficiency measurement point
      copper_loss_eff = nominal_loss_eff - iron_loss_eff;

      % Copper loss coefficient for copper loss model
      k_copper = copper_loss_eff/trq_eff_Nm^2;

      % Iron loss coefficient for iron loss model
      k_iron = iron_loss_eff/spd_eff_radps^2;

      % -----------------------------------------------------------------------

      % x-axis ... speed
      % !attention: Speed should be non zero because it is in the denominator to calculate torque envelope.
      w_plot_min_rpm = 1;  % Use 1. avoid 0.
      w_plot_max_rpm = value(DataSet.PlotSpeedMax, "rpm");
      w_vec_rpm = linspace(w_plot_min_rpm, w_plot_max_rpm, plot_resolution);
      w_vec_radps = w_vec_rpm/60*2*pi;  % rad/s

      % !todo: simscape.Value shoud accept a column vector or a row vector, but it only accepts a row vector.
      DataSet.SpeedValues = simscape.Value(transpose(w_vec_rpm), "rpm");

      % y-axis ... torque
      trq_plot_max_Nm = value(DataSet.PlotTorqueMax, "N*m");
      trq_vec_Nm = transpose(linspace(0, trq_plot_max_Nm, plot_resolution));

      DataSet.TorqueValues = simscape.Value(trq_vec_Nm, "N*m");

      % -----------------------------------------------------------------------
      % Calculations below are done in x-y mesh.
      [w_mat_radps, trq_mat_Nm] = meshgrid(w_vec_radps, trq_vec_Nm);

      % Fixed electrical loss
      Pb = loss_const_W*ones(plot_resolution, plot_resolution);

      kc = k_copper;  % Copper loss coefficient
      ki = k_iron;  % Iron loss coefficient
      kd = k_damp;  % Rotor friction coefficient

      trq_elec = abs(trq_mat_Nm) - kd*w_mat_radps;  % Steady state
      Lc = kc*trq_elec.^2;  % Copper loss model
      Li = ki*w_mat_radps.^2;  % Iron loss model
      L_elec = Pb + Lc + Li;  % Total electrical loss
      mech_power_mat_W = trq_mat_Nm .* w_mat_radps;  % Mechanical power
      efficiency_mat_pct = 100 * abs(mech_power_mat_W) ./(L_elec + abs(mech_power_mat_W));  % Efficiency in percent

      % !attention: Speed should be non zero because it is in the denominator.
      max_trq_envelope_vec_Nm = min(max_motor_power_W ./ w_vec_radps, max_motor_torque_Nm);

      valid_torque_region_mat = trq_mat_Nm < max_trq_envelope_vec_Nm;
      valid_speed_region_mat = w_mat_radps < (max_motor_speed_rpm/60*2*pi);
      efficiency_mat_pct = valid_torque_region_mat .* efficiency_mat_pct;
      efficiency_mat_pct = valid_speed_region_mat .* efficiency_mat_pct;

      DataSet.EfficiencyPercentMeshData = efficiency_mat_pct;
    end  % function

  end  % methods
end  % classdef
