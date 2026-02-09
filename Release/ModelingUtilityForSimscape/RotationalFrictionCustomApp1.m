function App = RotationalFrictionCustomApp1(NameValuePair)
% Example customization of the rotational friction app
%
% This is a customized version of the RotationalFrictionApp.
% This app runs a parameter definition script to load parameters in the base workspace.
% Then the app is configured to use the workspace variables for the friction model parameters.
% Parameters are defined as simscape.Value object.
% The app directly uses simscape.Value objects in the edit fields for parameters.

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Input)
  NameValuePair.ParameterScriptFullpath (1,1) string {mustBeFile} = FileUtil1.getFileFullPath("SampleParams_RotationalFriction.m")

  % Specify units used in the parameter file.
  % The selection list must match that used in AppMain.
  NameValuePair.TorquePlotUnit (1,1) string {mustBeMember(NameValuePair.TorquePlotUnit, ["N*m", "m*mN", "lbf*ft", "lbf*in"])} = "lbf*in"
  NameValuePair.VelocityPlotUnit (1,1) string {mustBeMember(NameValuePair.VelocityPlotUnit, ["rpm", "rad/s", "deg/s", "rev/s"])} = "rev/s"
end  % arguments

% Run the setup script to load parameters in the base workspace.
[~, script_name, ~] = fileparts(NameValuePair.ParameterScriptFullpath);
evalin("base", script_name)

app_main = RotationalFriction1.RotationalFrictionAppMain( ...
  TorquePlotUnit = NameValuePair.TorquePlotUnit, ...
  VelocityPlotUnit = NameValuePair.VelocityPlotUnit );

% Override the "Source" hyperlink in the app to the app source code so that the link opens this file.
app_main.Window.HeaderUI.AppSourceName = mfilename;

% -----------------------------------------------------------------------------
% Set up the model parameters in the app using the base workspace variables.

app_main.BreakawayTorqueUI.ValueText = "friction.BreakawayTorque";
updateInfoAndUnitUIs(app_main.BreakawayTorqueUI)

app_main.BreakawayVelocityUI.ValueText = "friction.BreakawayVelocity";
updateInfoAndUnitUIs(app_main.BreakawayVelocityUI)

app_main.CoulombTorqueUI.ValueText = "friction.CoulombTorque";
updateInfoAndUnitUIs(app_main.CoulombTorqueUI)

app_main.ViscousCoefficientUI.ValueText = "friction.ViscousCoefficient";
updateInfoAndUnitUIs(app_main.ViscousCoefficientUI)

% -----------------------------------------------------------------------------

if nargout > 0
  App = app_main;
end  % if
end  % function
