function App = AbstractMotorEfficiencyApp(NameValuePair)
<<<<<<< HEAD
% App for visualizing the power conversion efficiency of the abstract motor model.
=======
% App for visualizing the power conversion efficiency of the abstract motor model
%
% For the information about the app and the abstract motor model, see
% the description file "AbstractMotor_Description".
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
%
% This is a wrapper function of the main app implementation.
% To change the default options and settings of the app,
% make a copy of this file and modify it.

% Copyright 2026 The MathWorks, Inc.

arguments (Input)
<<<<<<< HEAD
  NameValuePair.AppParameterFileName (1,1) string = ""
  NameValuePair.AppParameterStructName (1,1) string = ""

  NameValuePair.BlockPath (1,1) string = ""
  NameValuePair.ModelName (1,1) string = ""
end  % arguments

app_main = AbstractMotorEfficiency1.AbstractMotorEfficiencyAppMain( ...
  AppParameterFileName = NameValuePair.AppParameterFileName, ...
  AppParameterStructName = NameValuePair.AppParameterStructName, ...
  BlockPath = NameValuePair.BlockPath, ...
  ModelName = NameValuePair.ModelName );

% Set up the "Source" hyperlink in the app to open this file.
=======
  NameValuePair.BlockPath (1,1) string = ""
  NameValuePair.ModelName (1,1) string = ""

  % The selection list must match that used in AppMain.
  NameValuePair.PlotTorqueUnit (1,1) string {mustBeMember(NameValuePair.PlotTorqueUnit, ["N*m", "lbf*ft"])} = "N*m"
  NameValuePair.PlotAngularSpeedUnit (1,1) string {mustBeMember(NameValuePair.PlotAngularSpeedUnit, ["rpm", "rad/s", "rev/s"])} = "rpm"
end  % arguments

app_main = AbstractMotor1.AbstractMotorEfficiencyAppMain( ...
  BlockPath = NameValuePair.BlockPath, ...
  ModelName = NameValuePair.ModelName, ...
  PlotTorqueUnit = NameValuePair.PlotTorqueUnit, ...
  PlotAngularSpeedUnit = NameValuePair.PlotAngularSpeedUnit );

% Override the "Source" hyperlink in the app to the app source code so that the link opens this file.
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
app_main.Window.HeaderUI.AppSourceName = mfilename;

if nargout > 0
  App = app_main;
end  % if
end  % function
