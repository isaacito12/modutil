classdef SimpleMotorAndDriveParameters < handle
  % Model parameters for the simple motor and drive model
  %
  % The parameters of this class correspond to those in the Motor & Drive block in Simscape Driveline.
  %
  % To create an uninitialized instance, call this class without any options.
  % To create an instance initialized with default parameter values,
  % use the Initialize=true option.

  % Copyright 2026 The MathWorks, Inc.

  properties
    % Public parameters of the simple motor and drive model
    MaxTorque simscape.Value { simscape.mustBeCommensurateUnit(MaxTorque, "N*m"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "N*m")
    MaxPower simscape.Value { simscape.mustBeCommensurateUnit(MaxPower, "kW"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "kW")
    TorqueControlTimeConstant simscape.Value { simscape.mustBeCommensurateUnit(TorqueControlTimeConstant, "s"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "s")
    MeasuredEfficiencyPercent simscape.Value { simscape.mustBeCommensurateUnit(MeasuredEfficiencyPercent, "1"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "1")
    MeasuredSpeed simscape.Value { simscape.mustBeCommensurateUnit(MeasuredSpeed, "rpm"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "rpm")
    MeasuredTorque simscape.Value { simscape.mustBeCommensurateUnit(MeasuredTorque, "N*m"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "N*m")
    ThermalPort (1,1) string {mustBeMember(ThermalPort, ["omit" "model"])} = "omit"
  end  % properties

  methods

    function params = SimpleMotorAndDriveParameters(NameValuePair)
      arguments (Input)
        NameValuePair.Initialization (1,1) logical = false
      end  % arguments

      if NameValuePair.Initialization
        resetPublicParameters(params)
      end  % if
    end  % function

    function resetPublicParameters(params)
      % Default settings in the Motor & Drive block
      params.MaxTorque = simscape.Value(400, "N*m");
      params.MaxPower = simscape.Value(200, "kW");
      params.TorqueControlTimeConstant = simscape.Value(0.02, "s");
      params.MeasuredEfficiencyPercent = simscape.Value(100, "1");
      params.MeasuredSpeed = simscape.Value(3750, "rpm");
      params.MeasuredTorque = simscape.Value(100, "N*m");
      params.ThermalPort = "omit";
    end  % function

  end  % methods
end  % classdef
