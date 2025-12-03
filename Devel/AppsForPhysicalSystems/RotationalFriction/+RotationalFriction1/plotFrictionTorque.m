function fig = plotFrictionTorque(NameValuePair)
% Make a plot of rotational friction torque model.
%
% To see what plot this function creates, run this function without any arguments.

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  NameValuePair.RotationalFrictionData RotationalFriction1.RotationalFrictionData {mustBeScalarOrEmpty}

  % Take axes so that the plot can be embedded in an app or created in a separate figure window.
  NameValuePair.ParentAxes matlab.graphics.axis.Axes {mustBeScalarOrEmpty}
end  % arguments

arguments (Output)
  % Return figure object so that functions like exportgraphics can work with the plot.
  fig (:,1) matlab.ui.Figure
end  % arguments

if isfield(NameValuePair, "RotationalFrictionData")
  core_data = NameValuePair.RotationalFrictionData;
else
  core_data = RotationalFriction1.RotationalFrictionData(Initialize=true);
end  % if

if isfield(NameValuePair, "ParentAxes")
  ax = NameValuePair.ParentAxes;
  fig_obj = ax.Parent;
else
  fig_obj = figure;
  ax = axes(fig_obj);
end  % if

make_plot(core_data, ax)

if nargout > 0
  fig = fig_obj;
end  % if
end  % main function

function make_plot(friction_data, ax)
%% Make a plot of the friction torque model.
% This function assumes that all data required for making a plot have been
% calculated elsewhere upfront.

arguments (Input)
  friction_data (1,1) RotationalFriction1.RotationalFrictionData
  ax (:,1) matlab.graphics.axis.Axes {mustBeScalarOrEmpty}
end  % arguments

vel_unit = friction_data.VelocityPlotUnit;
trq_unit = friction_data.TorquePlotUnit;

vel = value(friction_data.VelocityValues, vel_unit);
trq = value(friction_data.TorqueValues, trq_unit);

plot(ax, vel, trq, LineWidth=2.6, DisplayName="All")
hold(ax, "on")

show_legend = false;

if friction_data.ShowStribeckTorque
  y = value(friction_data.StribeckTorqueValues, trq_unit);
  plot(ax, vel, y, LineWidth=2.1, LineStyle="--", DisplayName="Stribeck")
  x = value(friction_data.ModelParams.StribeckThresholdVelocity, vel_unit);
  xregion(ax, -x, x, DisplayName="Stribeck threshold")
  show_legend = true;
end  % if

if friction_data.ShowCoulombTorque
  y = value(friction_data.CoulombTorqueValues, trq_unit);
  plot(ax, vel, y, LineWidth=1.6, LineStyle=":", DisplayName="Coulomb")
  x = value(friction_data.ModelParams.CoulombThresholdVelocity, vel_unit);
  xregion(ax, -x, x, DisplayName="Coulomb threshold")
  show_legend = true;
end  % if

if friction_data.ShowViscousTorque
  y = value(friction_data.ViscousTorqueValues, trq_unit);
  plot(ax, vel, y, LineWidth=1.1, LineStyle="-.", DisplayName="Viscous")
  show_legend = true;
end  % if

grid(ax, "on")

xlabel(ax, "Angular velocity, $\omega$ (" + string(vel_unit) + ")", Interpreter="latex")
ylabel(ax, "Friction torque, $T$ (" + string(trq_unit) + ")", Interpreter="latex")

axis(ax, "padded")

x_lo = value(friction_data.VelocityMin, vel_unit);
x_hi = value(friction_data.VelocityMax, vel_unit);
xlim(ax, [x_lo, x_hi])

if show_legend
  legend(ax, Location="best")
end  % if

hold(ax, "off")
end  % local function
