# <span style="color:rgb(213,80,0)">Rotational Friction Torque App</span>

The rotational friction torque app visualizes the rotational friction torque model. The model is used by the [Rotational Friction block](https://www.mathworks.com/help/simscape/ref/rotationalfriction.html) (Simscape).

<p style="text-align:left">
   <img src="media/RotationalFrictionTorqueApp_Description_mus1_media/image_0.png" width="953" alt="image_0.png">
</p>

# Open the app

**`RotationalFrictionTorqueApp`** opens the app.

<pre>
% Open the app with all defaults.
RotationalFrictionTorqueApp
</pre>

**`RotationalFrictionTorqueApp(AppParameterFileName=<file_name>, AppParameterStructName=<struct_name>)`** opens the app by first evaluating the specified parameter file and then loading the specified struct from the base workspace to the app. These options correspond to the **Parameter file** and the **Variable name** in the app. The field names of the struct must match the app's parameter names as shown in the table.

| **App parameter** <br>  | **Struct field name** <br>  | **Value type** <br>   |
| :-- | :-- | :-- |
| Breakaway friction torque, $T_B$ <br>  | BreakawayTorque <br>  | double or simscape.Value <br>   |
| Breakaway friction velocity, $\omega_B$ <br>  | BreakawayVelocity <br>  | double or simscape.Value <br>   |
| Coulomb friction torque, $T_C$ <br>  | CoulombTorque <br>  | double or simscape.Value <br>   |
| Viscous friction coefficient, $f$ <br>  | ViscousCoefficient <br>  | double or simscape.Value <br>   |
| Torque components > Stribeck <br>  | ShowStribeckTorque <br>  | "on" or "off" <br>   |
| Torque components > Coulomb <br>  | ShowCoulombTorque <br>  | "on" or "off" <br>   |
| Torque components > Viscous <br>  | ShowViscousTorque <br>  | "on" or "off" <br>   |
| Plot unit > Angular velocity <br>  | PlotAngularVelocityUnit <br>  | simscape.Unit <br>   |
| Plot unit > Torque <br>  | PlotTorqueUnit <br>  | simscape.Unit <br>   |

For convenience, use RotationalFrictionTorqueAppParameters to get predefined struct fields for a struct. For example, create a script as follows and save it as `friction_parameters.m`.

<pre>
% Use RotationalFrictionTorqueAppParameters to define fields for the app parameters.
% This provides tab-completion for edit too.
FrictionParams = RotationalFrictionTorque1.RotationalFrictionTorqueAppParameters;

FrictionParams.BreakawayTorque = simscape.Value(30, "N*m");
FrictionParams.BreakawayVelocity = simscape.Value(1, "rad/s");
FrictionParams.CoulombTorque = simscape.Value(18, "N*m");
FrictionParams.ViscousCoefficient = simscape.Value(0.5, "N*m/(rad/s)");

% Check box parameters take "on" or "off".
FrictionParams.ShowStribeckTorque = "off";
FrictionParams.ShowCoulombTorque = "off";
FrictionParams.ShowViscousTorque = "off";

% Parameters for physical unit drop down take a commensurate unit text.
FrictionParams.PlotAngularVelocityUnit = "rad/s";
FrictionParams.PlotTorqueUnit = "N*m";
</pre>

Then open the app with the parameter file and the struct.

<pre>
% Specified script file (*.m) must be on the MATLAB path.
RotationalFrictionTorqueApp( ...
  AppParameterFileName = which("friction_parameters.m"), ...
  AppParameterStructName = "FrictionParams" )
</pre>

**`RotationalFrictionTorqueApp(AppParameterStructName=<struct_name>)`** opens the app by reading the specified **`<struct_name>`** struct from the base workspace. The struct must exist in the base workspace.

<pre>
% The FrictionParams struct must exist in the base workspace.
RotationalFrictionTorqueApp(AppParameterStructName="FrictionParams")
</pre>

**`RotationalFrictionTorqueApp(BlockPath=<block_path>)`** opens the app with the specified block being linked to the app. The app identifies the model name from the block path and loads the model first and then loads the block parameters of the specified block to the app.

<pre>
% The app opens the specified model and then loads block parameters from the specified block.
RotationalFrictionTorqueApp(BlockPath="my_model/Rotational Friction")
</pre>

**`RotationalFrictionTorqueApp(ModelName=<model_name>)`** opens the app by opening the specified model and loading block parameters from a block in the model. If there are more than two vehicle blocks, the first one is used.

<pre>
% Supported blocks must exist in the specified model.
RotationalFrictionTorqueApp(ModelName="my_model")
</pre>

*Copyright 2025\-2026 The MathWorks, Inc.*