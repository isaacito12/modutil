classdef RotationalFrictionModelParameters < handle
  % Model parameters of rotational friction model
  %
  % The parameters of this class correspond to those in the Rotational Friction block in Simscape.
  %
  % To create an uninitialized instance, call this class without any options.
  % To create an instance initialized with default parameter values,
  % use the Initialize=true option.

  % Copyright 2025 The MathWorks, Inc.

  properties

    % Public parameters of the friction torque model
    BreakawayTorque simscape.Value { simscape.mustBeCommensurateUnit(BreakawayTorque, "N*m"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "N*m")
    BreakawayVelocity simscape.Value { simscape.mustBeCommensurateUnit(BreakawayVelocity, "rad/s"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "rad/s")
    CoulombTorque simscape.Value { simscape.mustBeCommensurateUnit(CoulombTorque, "N*m"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "N*m")
    ViscousCoefficient simscape.Value { simscape.mustBeCommensurateUnit(ViscousCoefficient, "N*m*s/rad"), CodeUtil1.mustBeSimscapeValuePositive } = simscape.Value(nan, "N*m*s/rad")

    % Derived parameters
    StribeckScaledTorque simscape.Value { simscape.mustBeCommensurateUnit(StribeckScaledTorque, "N*m") } = simscape.Value(nan, "N*m")
    StribeckThresholdVelocity simscape.Value { simscape.mustBeCommensurateUnit(StribeckThresholdVelocity, "rad/s") } = simscape.Value(nan, "rad/s")
    CoulombThresholdVelocity simscape.Value { simscape.mustBeCommensurateUnit(CoulombThresholdVelocity, "rad/s") } = simscape.Value(nan, "rad/s")

  end  % properties

  methods

    function params = RotationalFrictionModelParameters(NameValuePair)
      arguments (Input)
        NameValuePair.Initialize (1,1) logical = false
      end  % arguments

      if NameValuePair.Initialize
        resetPublicParameters(params)
        updateDerivedParameters(params)
      end  % if
    end  % function

    function resetPublicParameters(params)
      params.BreakawayTorque = simscape.Value(25, "N*m");
      params.BreakawayVelocity = simscape.Value(0.1, "rad/s");
      params.CoulombTorque = simscape.Value(20, "N*m");
      params.ViscousCoefficient = simscape.Value(0.001, "N*m*s/rad");
    end  % function

    function updateDerivedParameters(params)
      % These are the derived parameters of the equation-based models of the rotational friction model.
      params.StribeckScaledTorque = sqrt(2 * exp(1)) * (params.BreakawayTorque - params.CoulombTorque);
      params.StribeckThresholdVelocity = sqrt(2) * params.BreakawayVelocity;
      params.CoulombThresholdVelocity = params.BreakawayVelocity / 10;
    end  % function

  end  % methods
end  % classdef
