function fig = plotEfficiency(NameValuePair)
% Make a plot of efficiency contours for the simplified motor and drive model.
%
% To see what plot this function creates, run this function without any arguments.
%
% The simplified motor and drive model is used by the Motor & Drive block in Simscape Driveline.
% https://uk.mathworks.com/help/sdl/ref/motordrive.html

% Copyright 2023-2026 The MathWorks, Inc.

arguments (Input)
  NameValuePair.SimpleMotorAndDriveDataSet SimpleMotorAndDrive1.SimpleMotorAndDriveDataSet {mustBeScalarOrEmpty}

  % Take axes so that the plot can be embedded in an app or created in a separate figure window.
  NameValuePair.ParentAxes matlab.graphics.axis.Axes {mustBeScalarOrEmpty}

  % These are valid only when ParentAxes is NOT specified.
  % These work in R2025a and newer and are ignored in R2024b and older.
  NameValuePair.Theme {mustBeMember(NameValuePair.Theme, ["light", "dark"])} = "light"
  NameValuePair.ThemeMode {mustBeMember(NameValuePair.ThemeMode, ["auto", "manual"])} = "auto"
end  % arguments

arguments (Output)
  % Return a figure object so that functions such as exportgraphics can work with the plot.
  fig matlab.ui.Figure {mustBeScalarOrEmpty}
end  % arguments

if isfield(NameValuePair, "SimpleMotorAndDriveDataSet")
  dataset = NameValuePair.SimpleMotorAndDriveDataSet;
else
  dataset = SimpleMotorAndDrive1.SimpleMotorAndDriveDataSet(Initialization=true);
end  % if

if isfield(NameValuePair, "ParentAxes")
  ax = NameValuePair.ParentAxes;
  main_fig = ax.Parent;
else
  main_fig = figure;
  if not(isMATLABReleaseOlderThan("R2025a"))
    main_fig.Theme = NameValuePair.Theme;
    main_fig.ThemeMode = NameValuePair.ThemeMode;
  end  % if

  ax = axes(main_fig);
end  % if

make_plot(dataset, ax);

if nargout > 0
  fig = main_fig;
end  % if
end  % function

function make_plot(dataset, parent_axes)
%% Makes a plot of power conversion efficiency/losses for motor drive unit
% To see what plot this function creates, run this function without any arguments.
%
% This function takes arguments corresponding to the block parameters of
% the following blocks:
%
%   - Motor & Drive block, from Simscape Driveline
%   - Motor & Drive (System Level) block, from Simscape Electrical
%
% and makes a plot of electric-to-mechanical power conversion efficiency map
% as a function of motor speed and torque.
%
% You can run this function without arguments,
% and it will create a plot using default argument values.
%
% Note that Motor & Drive (System Level) block supports
% various ways to accept block parameters, but
% this function makes a plot for it assuming the following case:
%
%   Electrical Torque
%     - Parameterized by: Maximum torque and power
%   Electrical Losses
%     - Parameterize losses by: Single efficiency measurement
%
% To make an efficiency plot for other cases
% in Motor & Drive (System Level) block,
% use the "Plot efficiency map" link in the block Description.

arguments (Input)
  dataset (1,1) SimpleMotorAndDrive1.SimpleMotorAndDriveDataSet
  parent_axes matlab.graphics.axis.Axes {mustBeScalarOrEmpty}
end  % arguments

ax = parent_axes;

speed_rpm_vec = value(dataset.SpeedValues, "rpm");
torque_Nm_vec = value(dataset.TorqueValues, "N*m");
efficiency_percent_meshdata = dataset.EfficiencyPercentMeshData;
contour_levels = dataset.ContourLevelsPercent;
measured_speed_rpm = value(dataset.ModelParams.MeasuredSpeed, "rpm");
measured_torque_Nm = value(dataset.ModelParams.MeasuredTorque, "N*m");
plot_speed_max_rpm = value(dataset.PlotSpeedMax, "rpm");
plot_torque_max_Nm = value(dataset.PlotTorqueMax, "N*m");

contourf(ax, speed_rpm_vec, torque_Nm_vec, efficiency_percent_meshdata, contour_levels, ShowText="on")

hold(ax, "on")

sct = scatter(ax, measured_speed_rpm, measured_torque_Nm);
sct.Marker = "x";
sct.LineWidth = 1;
sct.SizeData = 100;
sct.MarkerEdgeColor = "black";

xlim(ax, [0 plot_speed_max_rpm])
ylim(ax, [0 plot_torque_max_Nm])
xlabel(ax, CodeUtil1.i18n("Speed, $\omega$ (rpm)"), Interpreter="latex")
ylabel(ax, CodeUtil1.i18n("Torque, $\tau$ (Nm)"), Interpreter="latex")
title(ax, CodeUtil1.i18n("Overall efficiency of simple motor and drive model (%)"))

end  % function
