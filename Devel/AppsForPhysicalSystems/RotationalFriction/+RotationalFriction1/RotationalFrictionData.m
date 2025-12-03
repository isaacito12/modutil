classdef RotationalFrictionData < handle
  % Data class of the rotational friction torque model and block for visualization.
  %
  % This class holds data for the rotational friction model, which is used
  % by the Rotational Friction block in Simscape.
  % Use this class for visualizing the torque model based on the specified model parameters.
  %
  % Call this class without any options, and an uninitialized instance of this class is created.
  %
  % To create an instance which is ready for making a plot of the torque model,
  % use the Initialize=true option.
  %
  % To create an instance initialized with parameters defined in a Rotational Friction block in a model,
  % specify the block path to the BlockPath option.

  % Copyright 2025 The MathWorks, Inc.

  properties

    % Parameters of the rotational friction torque model
    ModelParams (1,1) RotationalFriction1.RotationalFrictionModelParameters = RotationalFriction1.RotationalFrictionModelParameters(Initialize=true)

    % Block path to the target Rotational Friction block in a model
    BlockPath (1,1) string = ""
    ModelName (1,1) string = ""

    % -------------------------------------------------------------------------
    % X axis - Angular speed

    % Physical unit of angular speed for plot (X axis)
    VelocityPlotUnit simscape.Unit { simscape.mustBeCommensurateUnit(VelocityPlotUnit, "rad/s") } = simscape.Unit("rad/s")

    % Number of values of angular speed (X axis)
    NumVelocityValues { mustBeInteger, mustBePositive } = 200

    % Values of angular speed (X axis)
    VelocityValues (:,1) simscape.Value { mustBeVector, simscape.mustBeCommensurateUnit(VelocityValues, "rad/s") } = simscape.Value([-1, 1]', "rad/s")

    % Minimum value of angular speed data
    VelocityMin simscape.Value { mustBeScalarOrEmpty, simscape.mustBeCommensurateUnit(VelocityMin, "rad/s") } = simscape.Value(-1, "rad/s")

    % Maximum value of angular speed data
    VelocityMax simscape.Value { mustBeScalarOrEmpty, simscape.mustBeCommensurateUnit(VelocityMax, "rad/s") } = simscape.Value(1, "rad/s")

    % -------------------------------------------------------------------------
    % Y axis - Friction torque

    % Physical unit of torque for plot (Y axis)
    TorquePlotUnit simscape.Unit { simscape.mustBeCommensurateUnit(TorquePlotUnit, "N*m") } = simscape.Unit("N*m")

    % Data set of torque (Y axis)
    TorqueValues (:,1) simscape.Value { mustBeVector, simscape.mustBeCommensurateUnit(TorqueValues, "N*m") } = simscape.Value([0, 0]', "N*m")

    % Data set of Stribeck torque (Y axis)
    StribeckTorqueValues simscape.Value { mustBeVector, simscape.mustBeCommensurateUnit(StribeckTorqueValues, "N*m") } = simscape.Value([0, 0]', "N*m")

    % Data set of Coulomb torque (Y axis)
    CoulombTorqueValues simscape.Value { mustBeVector, simscape.mustBeCommensurateUnit(CoulombTorqueValues, "N*m") } = simscape.Value([0, 0]', "N*m")

    % Data set of viscous torque (Y axis)
    ViscousTorqueValues simscape.Value { mustBeVector, simscape.mustBeCommensurateUnit(ViscousTorqueValues, "N*m") } = simscape.Value([0, 0]', "N*m")

    % -------------------------------------------------------------------------
    % States of plot app

    % State of enabled button (button with enable/disable check box) for plot auto-update
    AutoUpdatePlot matlab.lang.OnOffSwitchState = "on"

    % Switch to show or hide Stribeck torque plot
    ShowStribeckTorque (1,1) logical = true

    % Switch to show or hide Coulomb torque plot
    ShowCoulombTorque (1,1) logical = true

    % Switch to show or hide viscous torque plot
    ShowViscousTorque (1,1) logical = true

  end  % properties

  methods

    function DataObj = RotationalFrictionData(NameValuePair)
      %%
      arguments (Input)
        NameValuePair.Initialize (1,1) logical = false
        NameValuePair.BlockPath (1,1) string = ""
      end

      if NameValuePair.BlockPath ~= ""
        DataObj.BlockPath = NameValuePair.BlockPath;
        DataObj.ModelName = extractBefore(NameValuePair.BlockPath, "/");

        NameValuePair.Initialize = true;
      end  % if

      if not(NameValuePair.Initialize)

        return

      end  % if

      if DataObj.ModelName == ""
        % Setup TorqueDataObj with default values.

        resetTorqueData(DataObj)

      else
        % Setup using the specified block in the model.

        % Model name was specified.
        % Open it and read the parameters from the specified block in it.
        if not(bdIsLoaded(DataObj.ModelName))
          load_system(DataObj.ModelName)
        end  % if

        DataObj.ModelParams.BreakawayTorque = ModelUtil1.getSimscapeValueFromBlockParameter(DataObj.BlockPath, "brkwy_trq");
        DataObj.ModelParams.BreakawayVelocity = ModelUtil1.getSimscapeValueFromBlockParameter(DataObj.BlockPath, "brkwy_vel");
        DataObj.ModelParams.CoulombTorque = ModelUtil1.getSimscapeValueFromBlockParameter(DataObj.BlockPath, "Col_trq");
        DataObj.ModelParams.ViscousCoefficient = ModelUtil1.getSimscapeValueFromBlockParameter(DataObj.BlockPath, "visc_coef");

        resetCommonTorqueData(DataObj)
      end  % if

      updateFrictionTorqueValues(DataObj)
    end  % function

    function resetTorqueData(DataObj)
      %%
      resetPublicParameters(DataObj.ModelParams)
      resetCommonTorqueData(DataObj)
    end  % function

    function resetCommonTorqueData(DataObj)
      %%
      DataObj.AutoUpdatePlot = "on";
      DataObj.NumVelocityValues = 200;
      DataObj.VelocityPlotUnit = "rad/s";
      DataObj.TorquePlotUnit = "N*m";
    end  % function

    function updateFrictionTorqueValues(DataObj)
      %%

      updateDerivedParameters(DataObj.ModelParams)

      % Determine the plot range in x-axis (velocity) from the friction model.
      threshold_velocity = value(DataObj.ModelParams.StribeckThresholdVelocity);
      velocity_hi = floor(5 * threshold_velocity);
      if velocity_hi < 1
        velocity_hi = 5 * threshold_velocity;
      end
      upper_bound = simscape.Value(velocity_hi, unit(DataObj.ModelParams.StribeckThresholdVelocity));
      lower_bound = -upper_bound;
      velocity_values = transpose(linspace(lower_bound, upper_bound, DataObj.NumVelocityValues));

      DataObj.VelocityValues = velocity_values;
      DataObj.VelocityMin = lower_bound;
      DataObj.VelocityMax = upper_bound;

      coeff = DataObj.ModelParams.ViscousCoefficient;
      DataObj.ViscousTorqueValues = coeff * velocity_values;  % !friction-model

      trq_c = DataObj.ModelParams.CoulombTorque;
      th_c = DataObj.ModelParams.CoulombThresholdVelocity;
      DataObj.CoulombTorqueValues = trq_c * tanh(velocity_values ./ th_c);  % !friction-model

      scale_s = DataObj.ModelParams.StribeckScaledTorque;
      th_s = DataObj.ModelParams.StribeckThresholdVelocity;
      DataObj.StribeckTorqueValues = scale_s * (velocity_values ./ th_s .* exp(-(velocity_values ./ th_s).^2));  % !friction-model

      DataObj.TorqueValues = DataObj.StribeckTorqueValues + DataObj.CoulombTorqueValues + DataObj.ViscousTorqueValues;  % !friction-model

    end  % function

  end  % methods
end  % classdef
