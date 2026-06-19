% Parameters for Longitudinal Vehicle block

% Copyright 2026 The MathWorks, Inc.

Vehicle1D.VehicleMass = simscape.Value(1800, "kg");
Vehicle1D.TireRollingRadius = simscape.Value(0.3, "m");
Vehicle1D.TireRollingCoefficient = 0.0136;
Vehicle1D.AirDragCoefficient = 0.31;
Vehicle1D.FrontalArea = simscape.Value(2.36, "m^2");

Vehicle1D.GravitationalAcceleration = simscape.Value(9.81, "m/s^2");
Vehicle1D.AirDensity = simscape.Value(1.184, "kg/m^3");
