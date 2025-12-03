classdef RotationalFrictionAppMain < handle
  % Rotational friction app
  %
  % This is an app for exploring the model parameters of the rotational friction torque model,
  % which is used by the Rotational Friction block in Simscape.
  % The app is a standalone MATLAB program, i.e., it is independent of the block.
  %
  % Launching the app without options opens the app in stand alone mode, where
  % the app does not load a model and link to Rotational Friction blocks.
  %
  % To open the app with a Rotational Friction block in a model, use the BlockPath option.
  % To open the app with a model, use the Modelname option.
  % BlockPath is used if both BlockPath and ModelName options are specified.

  % Copyright 2024-2025 The MathWorks, Inc.

  properties (Access=private, Constant)
    errorID (1,1) string = "RotationalFrictionAppMain:"
  end  % properties

  properties

    RotationalFrictionData (1,1) RotationalFriction1.RotationalFrictionData = RotationalFriction1.RotationalFrictionData

    BlockPath (1,1) string = ""
    ModelName (1,1) string = ""
    ModelFileFullPath (1,1) string = ""

    % -------------------------------------------------------------------------
    % GUI parts

    MainFigure matlab.ui.Figure
    Window AppUtil1.AppWindow

    DocLinkUI AppUtil1.Component.Hyperlink

    BreakawayTorqueUI AppUtil1.Component.PhysicalValueUI
    BreakawayVelocityUI AppUtil1.Component.PhysicalValueUI
    CoulombTorqueUI AppUtil1.Component.PhysicalValueUI
    ViscousCoefficientUI AppUtil1.Component.PhysicalValueUI

    StribeckScaledTorqueUI AppUtil1.Component.PhysicalValueUI
    StribeckThresholdVelocityUI AppUtil1.Component.PhysicalValueUI
    CoulombThresholdVelocityUI AppUtil1.Component.PhysicalValueUI

    PlotButtonUI AppUtil1.Component.EnabledButton
    OpenInFigureWindowUI AppUtil1.Component.Hyperlink
    AxesUI AppUtil1.Graphics.Axes

    ShowStribeckTorqueUI AppUtil1.Component.CheckBox
    ShowCoulombTorqueUI AppUtil1.Component.CheckBox
    ShowViscousTorqueUI AppUtil1.Component.CheckBox

    TorquePlotUnitUI AppUtil1.Component.DropDown
    VelocityPlotUnitUI AppUtil1.Component.DropDown

    AppBlockSelectorUI AppUtil1.Component.BlockSelectorUI
  end  % properties

  properties (Constant, Access=private)

    TargetSimscapeBlockName = "Rotational Friction"

    angular_speed_unit_items = ["rpm", "rad/s", "deg/s", "rev/s"]
    torque_unit_items = ["N*m", "m*mN", "lbf*ft", "lbf*in"]
    fric_coeff_unit_items = ["N*m/(rad/s)", "ft*lbf*s/rad", "N*m/rpm", "lbf*m/rpm", "lbf*in/rpm"]

    width_unit = AppUtil1.Constant.Width{"unitwidth"}
    name_ui_width = AppUtil1.Constant.Width{"unitwidth"} * 28
    unit_ui_width = AppUtil1.Constant.Width{"unitwidth"} * 12
    button_width = AppUtil1.Constant.Width{"unitwidth"} * 12
  end  % properties

  methods

    function App = RotationalFrictionAppMain(NameValuePair)
      %%
      arguments (Input)
        NameValuePair.BlockPath (1,1) string = ""
        NameValuePair.ModelName (1,1) string = ""

        % The list of mustBeMember cannot be a class property even if it is constant.
        NameValuePair.TorquePlotUnit (1,1) string {mustBeMember(NameValuePair.TorquePlotUnit, ["N*m", "m*mN", "lbf*ft", "lbf*in"])} = "N*m"
        NameValuePair.VelocityPlotUnit (1,1) string {mustBeMember(NameValuePair.VelocityPlotUnit, ["rpm", "rad/s", "deg/s", "rev/s"])} = "rad/s"
      end  % arguments

      % -----------------------------------------------------------------------
      % Before building app GUI

      if (NameValuePair.ModelName ~= "") && (NameValuePair.BlockPath ~= "")
        id = App.errorID + "InvalidOption";
        msg = CodeUtil1.i18n("Only one of ModelName or BlockPath can be specified.");

        throw(MException(id, msg))

      end  % if

      % BlockPath takes precedence over ModelName.
      if NameValuePair.BlockPath ~= ""
        App.BlockPath = NameValuePair.BlockPath;
        App.ModelName = extractBefore(App.BlockPath, "/");
        if App.ModelName == ""
          id = App.errorID + "InvalidModelName";
          msg = CodeUtil1.i18n("Empty model name is not allowed.");

          throw(MException(id, msg))

        end  % if
      elseif NameValuePair.ModelName ~= ""
        App.BlockPath = "";
        App.ModelName = NameValuePair.ModelName;

      else
        App.BlockPath = "";
        App.ModelName = "";
        App.ModelFileFullPath = "";
      end  % if

      if App.ModelName ~= ""
        try
          App.ModelFileFullPath = ModelUtil1.getModelFileFullPath(App.ModelName);
        catch exception
          id = App.errorID + "InvalidModelName";
          msg = exception.message;

          throw(MException(id, msg))

        end  % try, catch

        % The Rotational Friction block must exist in the specified model.
        try
          result = ModelUtil1.findSimscapeBlock(App.ModelName, App.TargetSimscapeBlockName);
        catch exception
          id = App.errorID + "SimscapeBlockWasNotFound";
          msg = exception.message;

          throw(MException(id, msg))

        end  % try, catch

        if App.BlockPath == ""
          % Use the first match.
          App.BlockPath = result.BlockPath(1);
        else
          if not(ismember(App.BlockPath, result.BlockPath))
            id = App.errorID + "InvalidBlockPath";
            msg = CodeUtil1.i18n("The specified block was not found in the specified model.");

            throw(MException(id, msg))

          end  % if
        end  % if
      end  % if
      % At this point, BlockPath and ModelName are either both "" or both properly defined.

      App.MainFigure = uifigure(Visible="off");

      meta_data = metaclass(App);
      App.Window = AppUtil1.AppWindow(App.MainFigure, SourceFile=which(meta_data.Name));
      App.Window.Name = CodeUtil1.i18n("Rotational Friction");
      App.Window.Width = 1100;
      App.Window.Height = 560;

      % -----------------------------------------------------------------------

      build_app_gui(App)

      % -----------------------------------------------------------------------
      % After building app GUI

      if App.BlockPath ~= ""
        App.AppBlockSelectorUI.ModelFileDropDownUI.Items(end + 1) = replace(App.ModelFileFullPath, ("/"|"\"), " > ");
        try
          % Changing an item in the model drop down list starts searching the target block, which
          % may produce an error if the target block is not found.
          App.AppBlockSelectorUI.ModelFileDropDownUI.Value = App.AppBlockSelectorUI.ModelFileDropDownUI.Items(end);
        catch exception

          rethrow(exception)

        end  % try, catch
        App.AppBlockSelectorUI.BlockPathDropDownUI.Value = replace(App.BlockPath, "/", " / ");
        callback_get_parameters(App)

      else
        % Default settings
        App.RotationalFrictionData = RotationalFriction1.RotationalFrictionData(Initialize=true);
        App.BreakawayTorqueUI.SimscapeValue = App.RotationalFrictionData.ModelParams.BreakawayTorque;
        App.BreakawayVelocityUI.SimscapeValue = App.RotationalFrictionData.ModelParams.BreakawayVelocity;
        App.CoulombTorqueUI.SimscapeValue = App.RotationalFrictionData.ModelParams.CoulombTorque;
        App.ViscousCoefficientUI.SimscapeValue = App.RotationalFrictionData.ModelParams.ViscousCoefficient;
      end  % if

      % For the derived parameters, use the same unit as the plot unit.
      App.StribeckScaledTorqueUI.UnitText = NameValuePair.TorquePlotUnit;
      App.StribeckThresholdVelocityUI.UnitText = NameValuePair.VelocityPlotUnit;
      App.CoulombThresholdVelocityUI.UnitText = NameValuePair.VelocityPlotUnit;

      % Show torque components in the plot by default.
      App.ShowStribeckTorqueUI.Value = true;
      App.ShowCoulombTorqueUI.Value = true;
      App.ShowViscousTorqueUI.Value = true;

      App.TorquePlotUnitUI.Value = NameValuePair.TorquePlotUnit;
      App.VelocityPlotUnitUI.Value = NameValuePair.VelocityPlotUnit;

      % Enable plot auto-update.
      App.PlotButtonUI.ButtonDisable = "on";

      react_UIChanged(App)

      movegui(App.Window.MainFigure, "center")
      App.Window.MainFigure.Visible = "on";
      drawnow
      if nargout == 0
        clear App
      end  % if
    end  % function

    function build_app_gui(App)
      %%
      main_column_layout = App.Window.MainLayout;
      main_column_grid = NewColumnGrid(main_column_layout);
      main_row_layout = AppUtil1.RowLayout(main_column_grid);

      % =======================================================================
      % Left area
      % =======================================================================
      left_row_grid = NewRowGrid(main_row_layout);
      left_column_layout = AppUtil1.ColumnLayout(left_row_grid);

      % -----------------------------------------------------------------------
      left_column_grid = NewColumnGrid(left_column_layout);

      label_ui = AppUtil1.Component.Label(left_column_grid);
      label_ui.MainFigure = App.MainFigure;
      label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"} * 4;
      label_ui.Text = join([
        "The Rotational Friction block in Simscape represents friction in contact between rotating bodies."
        "The friction torque $T$ is simulated as a function of relative velocity $\omega$ and"
        "is assumed to be the sum of Stribeck, Coulomb, and viscous components."
        ], " ");
      label_ui.WordWrap = "on";

      % -----------------------------------------------------------------------
      left_column_grid = NewColumnGrid(left_column_layout);

      label_ui = AppUtil1.Component.Label(left_column_grid);
      label_ui.MainFigure = App.MainFigure;
      label_ui.ComponentHeight = AppUtil1.Constant.Height{"oneline"} * 2 + 10;
      label_ui.Text = join( [
        "$"
        "T(\omega) = T_{S} \cdot \frac{\omega}{\omega_{S}}"
        "\cdot \exp \left( - \left( \frac{\omega}{\omega_{S}} \right)^2 \right)"
        "+ T_C \cdot \tanh \left( \frac{\omega}{\omega_{C}} \right) + f \cdot \omega"
        "$"
        ], " ");
      label_ui.HorizontalAlignment = "center";
      label_ui.WordWrap = "off";

      % -----------------------------------------------------------------------
      left_column_grid = NewColumnGrid(left_column_layout);
      row_layout = AppUtil1.RowLayout(left_column_grid);

      row_grid = NewRowGrid(row_layout, Width="fit");
      label_ui = AppUtil1.Component.Label(row_grid);
      label_ui.MainFigure = App.MainFigure;
      label_ui.Text = CodeUtil1.i18n("Rotational Friction block:");
      label_ui.ComponentWidth = App.width_unit * 19;

      row_grid = NewRowGrid(row_layout, Width="fit");
      App.DocLinkUI = AppUtil1.Component.Hyperlink(row_grid);
      App.DocLinkUI.MainFigure = App.MainFigure;
      App.DocLinkUI.Text = CodeUtil1.i18n("Documentation");
      App.DocLinkUI.HyperlinkClickedCallback = @() web("https://www.mathworks.com/help/simscape/ref/rotationalfriction.html");

      row_grid = NewRowGrid(row_layout);
      ssc_link_ui = AppUtil1.Component.Hyperlink(row_grid);
      ssc_link_ui.MainFigure = App.MainFigure;
      ssc_link_ui.Text = CodeUtil1.i18n("Simscape source");
      ssc_link_ui.HyperlinkClickedCallback = @() ...
        open(string(matlabroot) + filesep + ...
        fullfile("toolbox", "physmod", "simscape", "library", "m") + filesep + ...
        fullfile("+foundation", "+mechanical", "+rotational", "friction.ssc"));

      %% ======================================================================
      % Parameters

      left_column_grid = NewColumnGrid(left_column_layout);
      label_ui = AppUtil1.Component.Label(left_column_grid);
      label_ui.Text = "\bf{" + CodeUtil1.i18n("Parameters") + "}";

      left_column_grid = NewColumnGrid(left_column_layout);
      App.BreakawayTorqueUI = AppUtil1.Component.PhysicalValueUI(left_column_grid);
      App.BreakawayTorqueUI.NameText = CodeUtil1.i18n("Breakaway friction torque, $T_{B}$");
      App.BreakawayTorqueUI.NameUIWidth = App.name_ui_width;
      App.BreakawayTorqueUI.UnitUIWidth = App.unit_ui_width;
      App.BreakawayTorqueUI.UnitItems = App.torque_unit_items;
      App.BreakawayTorqueUI.ValueChangedCallback = @() update_BreakawayTorque();
      App.BreakawayTorqueUI.UnitChangedCallback = @() update_BreakawayTorque();
      function update_BreakawayTorque
        try
          % Parameters in the ModelParams can produce a run-time error as defined in *ModelParameters.m
          % The error message is shown in the uialert pop-up window, instead of inlining in the UI component.
          % This is because the inline error reporting in PhysicalValueUI hides the unit UI, which
          % could block the user to correct the issue. (!todo: The inline error reporting needs improvement.)
          App.RotationalFrictionData.ModelParams.BreakawayTorque = App.BreakawayTorqueUI.SimscapeValue;
        catch exception
          if App.Window.MainFigure.Visible
            window_title = CodeUtil1.i18n("Error");
            msg = exception.message;

            uialert(App.Window.MainFigure, msg, window_title)

          else

            rethrow(exception)

          end  % if
        end  % try, catch
        react_UIChanged(App)
      end  % nested function

      left_column_grid = NewColumnGrid(left_column_layout);
      App.BreakawayVelocityUI = AppUtil1.Component.PhysicalValueUI(left_column_grid);
      App.BreakawayVelocityUI.NameText = CodeUtil1.i18n("Breakaway friction velocity, $\omega_{B}$");
      App.BreakawayVelocityUI.NameUIWidth = App.name_ui_width;
      App.BreakawayVelocityUI.UnitUIWidth = App.unit_ui_width;
      App.BreakawayVelocityUI.UnitItems = App.angular_speed_unit_items;
      App.BreakawayVelocityUI.ValueChangedCallback = @() update_BreakawayVelocity();
      App.BreakawayVelocityUI.UnitChangedCallback = @() update_BreakawayVelocity();
      function update_BreakawayVelocity
        try
          % Parameters in the ModelParams can produce a run-time error as defined in *ModelParameters.m
          % The error message is shown in the uialert pop-up window, instead of inlining in the UI component.
          % This is because the inline error reporting in PhysicalValueUI hides the unit UI, which
          % could block the user to correct the issue. (!todo: The inline error reporting needs improvement.)
          App.RotationalFrictionData.ModelParams.BreakawayVelocity = App.BreakawayVelocityUI.SimscapeValue;
        catch exception
          if App.Window.MainFigure.Visible
            window_title = CodeUtil1.i18n("Error");
            msg = exception.message;

            uialert(App.Window.MainFigure, msg, window_title)

          else

            rethrow(exception)

          end  % if
        end  % try, catch
        react_UIChanged(App)
      end  % nested function

      left_column_grid = NewColumnGrid(left_column_layout);
      App.CoulombTorqueUI = AppUtil1.Component.PhysicalValueUI(left_column_grid);
      App.CoulombTorqueUI.NameText = CodeUtil1.i18n("Coulomb friction torque, $T_{C}$");
      App.CoulombTorqueUI.NameUIWidth = App.name_ui_width;
      App.CoulombTorqueUI.UnitUIWidth = App.unit_ui_width;
      App.CoulombTorqueUI.UnitItems = App.torque_unit_items;
      App.CoulombTorqueUI.ValueChangedCallback = @() update_CoulombTorque();
      App.CoulombTorqueUI.UnitChangedCallback = @() update_CoulombTorque();
      function update_CoulombTorque
        try
          % Parameters in the ModelParams can produce a run-time error as defined in *ModelParameters.m
          % The error message is shown in the uialert pop-up window, instead of inlining in the UI component.
          % This is because the inline error reporting in PhysicalValueUI hides the unit UI, which
          % could block the user to correct the issue. (!todo: The inline error reporting needs improvement.)
          App.RotationalFrictionData.ModelParams.CoulombTorque = App.CoulombTorqueUI.SimscapeValue;
        catch exception
          if App.Window.MainFigure.Visible
            window_title = CodeUtil1.i18n("Error");
            msg = exception.message;

            uialert(App.Window.MainFigure, msg, window_title)

          else

            rethrow(exception)

          end  % if
        end  % try, catch
        react_UIChanged(App)
      end  % nested function

      left_column_grid = NewColumnGrid(left_column_layout);
      App.ViscousCoefficientUI = AppUtil1.Component.PhysicalValueUI(left_column_grid);
      App.ViscousCoefficientUI.NameText = CodeUtil1.i18n("Viscous friction coefficient, $f$");
      App.ViscousCoefficientUI.NameUIWidth = App.name_ui_width;
      App.ViscousCoefficientUI.UnitUIWidth = App.unit_ui_width;
      App.ViscousCoefficientUI.UnitItems = App.fric_coeff_unit_items;
      App.ViscousCoefficientUI.ValueChangedCallback = @() update_ViscousCoefficient();
      App.ViscousCoefficientUI.UnitChangedCallback = @() update_ViscousCoefficient();
      function update_ViscousCoefficient
        try
          % Parameters in the ModelParams can produce a run-time error as defined in *ModelParameters.m
          % The error message is shown in the uialert pop-up window, instead of inlining in the UI component.
          % This is because the inline error reporting in PhysicalValueUI hides the unit UI, which
          % could block the user to correct the issue. (!todo: The inline error reporting needs improvement.)
          App.RotationalFrictionData.ModelParams.ViscousCoefficient = App.ViscousCoefficientUI.SimscapeValue;
        catch exception
          if App.Window.MainFigure.Visible
            window_title = CodeUtil1.i18n("Error");
            msg = exception.message;

            uialert(App.Window.MainFigure, msg, window_title)

          else

            rethrow(exception)

          end  % if
        end  % try, catch
        react_UIChanged(App)
      end  % nested function

      %% ======================================================================
      % Derived parameters

      % -----------------------------------------------------------------------
      left_column_grid = NewColumnGrid(left_column_layout);
      label_ui = AppUtil1.Component.Label(left_column_grid);
      label_ui.ComponentWidth = App.name_ui_width;
      label_ui.Text = "\textbf{" + CodeUtil1.i18n("Derived parameters") + "}";

      component_height = AppUtil1.Constant.Height{"oneline++"} * 2;

      left_column_grid = NewColumnGrid(left_column_layout);
      App.StribeckScaledTorqueUI = AppUtil1.Component.PhysicalValueUI(left_column_grid);
      App.StribeckScaledTorqueUI.ComponentHeight = component_height;
      App.StribeckScaledTorqueUI.NameText = CodeUtil1.i18n("Scale factor for Stribeck torque") + newline + "$T_{S} = \sqrt{2e} (T_{B} - T_{C})$";
      App.StribeckScaledTorqueUI.NameUIWidth = App.name_ui_width;
      App.StribeckScaledTorqueUI.UnitUIWidth = App.unit_ui_width;
      App.StribeckScaledTorqueUI.UnitItems = App.torque_unit_items;
      App.StribeckScaledTorqueUI.ReadOnlyValueText = true;
      App.StribeckScaledTorqueUI.UnitChangedCallback = @() update_DerivedParameterUI(App, "StribeckScaledTorque");

      left_column_grid = NewColumnGrid(left_column_layout);
      App.StribeckThresholdVelocityUI = AppUtil1.Component.PhysicalValueUI(left_column_grid);
      App.StribeckThresholdVelocityUI.ComponentHeight = component_height;
      App.StribeckThresholdVelocityUI.NameText = CodeUtil1.i18n("Velocity threshold for Stribeck torque") + newline + "$\omega_{S} = \omega_{B} \sqrt{2}$";
      App.StribeckThresholdVelocityUI.NameUIWidth = App.name_ui_width;
      App.StribeckThresholdVelocityUI.UnitUIWidth = App.unit_ui_width;
      App.StribeckThresholdVelocityUI.UnitItems = App.angular_speed_unit_items;
      App.StribeckThresholdVelocityUI.ReadOnlyValueText = true;
      App.StribeckThresholdVelocityUI.UnitChangedCallback = @() update_DerivedParameterUI(App, "StribeckThresholdVelocity");

      left_column_grid = NewColumnGrid(left_column_layout);
      App.CoulombThresholdVelocityUI = AppUtil1.Component.PhysicalValueUI(left_column_grid);
      App.CoulombThresholdVelocityUI.ComponentHeight = component_height;
      App.CoulombThresholdVelocityUI.NameText = CodeUtil1.i18n("Velocity threshold for Coulomb torque") + newline + "$\omega_{C} = \omega_{B} / 10$";
      App.CoulombThresholdVelocityUI.NameUIWidth = App.name_ui_width;
      App.CoulombThresholdVelocityUI.UnitUIWidth = App.unit_ui_width;
      App.CoulombThresholdVelocityUI.UnitItems = App.angular_speed_unit_items;
      App.CoulombThresholdVelocityUI.ReadOnlyValueText = true;
      App.CoulombThresholdVelocityUI.UnitChangedCallback = @() update_DerivedParameterUI(App, "CoulombThresholdVelocity");

      % =======================================================================
      % Right area
      % =======================================================================

      right_row_grid = NewRowGrid(main_row_layout);
      right_column_layout = AppUtil1.ColumnLayout(right_row_grid);

      % -----------------------------------------------------------------------
      right_column_grid = NewColumnGrid(right_column_layout);
      row_layout = AppUtil1.RowLayout(right_column_grid);

      row_grid = NewRowGrid(row_layout, Width="fit");
      App.PlotButtonUI = AppUtil1.Component.EnabledButton(row_grid);
      App.PlotButtonUI.HorizontalAlignment = "left";
      App.PlotButtonUI.ButtonUIWidth = App.button_width + App.width_unit;
      App.PlotButtonUI.ButtonWidth = App.button_width;
      App.PlotButtonUI.CheckBoxUIWidth = "fit";
      App.PlotButtonUI.CheckBoxWidth = "fit";
      App.PlotButtonUI.ButtonText = CodeUtil1.i18n("Update");
      App.PlotButtonUI.ButtonUI.MainButton.Icon = fullfile(matlabroot, "toolbox", "matlab", "icons", "tool_rotate_3d.png");
      App.PlotButtonUI.CheckBoxText = CodeUtil1.i18n("Auto-update");
      App.PlotButtonUI.ButtonPushedCallback = @() update_plot(App);
      % Set false to auto-update and keep it until the entire app is ready.
      App.PlotButtonUI.ButtonDisable = "on";

      row_grid = NewRowGrid(row_layout);
      App.OpenInFigureWindowUI = AppUtil1.Component.Hyperlink(row_grid);
      App.OpenInFigureWindowUI.Text = CodeUtil1.i18n("Open in figure window");
      App.OpenInFigureWindowUI.HorizontalAlignment = "right";
      App.OpenInFigureWindowUI.HyperlinkClickedCallback = @() update_plot(App, StandAloneFigure=true);

      % -----------------------------------------------------------------------
      right_column_grid = NewColumnGrid(right_column_layout, Height="fit");

      App.AxesUI = AppUtil1.Graphics.Axes(right_column_grid);
      App.AxesUI.ComponentHeight = 380;

      % -----------------------------------------------------------------------
      right_column_grid = NewColumnGrid(right_column_layout);
      row_layout = AppUtil1.RowLayout(right_column_grid);

      row_grid = NewRowGrid(row_layout, Width="3x");
      label_ui = AppUtil1.Component.Label(row_grid);
      label_ui.Text = "\textbf{" + CodeUtil1.i18n("Torque components") + "}";
      label_ui.HorizontalAlignment = "center";

      row_grid = NewRowGrid(row_layout, Width="2x");
      App.ShowStribeckTorqueUI = AppUtil1.Component.CheckBox(row_grid);
      App.ShowStribeckTorqueUI.Text = CodeUtil1.i18n("Stribeck");
      App.ShowStribeckTorqueUI.ValueChangedCallback = @() react_ShowStribeckTorqueChanged();
      function react_ShowStribeckTorqueChanged
        App.RotationalFrictionData.ShowStribeckTorque = App.ShowStribeckTorqueUI.Value;
        auto_update_plot(App, SkipDataUpdate=true);
      end  % nested function

      row_grid = NewRowGrid(row_layout, Width="2x");
      App.ShowCoulombTorqueUI = AppUtil1.Component.CheckBox(row_grid);
      App.ShowCoulombTorqueUI.Text = CodeUtil1.i18n("Coulomb");
      App.ShowCoulombTorqueUI.ValueChangedCallback = @() react_ShowCoulombTorqueChanged();
      function react_ShowCoulombTorqueChanged
        App.RotationalFrictionData.ShowCoulombTorque = App.ShowCoulombTorqueUI.Value;
        auto_update_plot(App, SkipDataUpdate=true);
      end  % nested function

      row_grid = NewRowGrid(row_layout, Width="2x");
      App.ShowViscousTorqueUI = AppUtil1.Component.CheckBox(row_grid);
      App.ShowViscousTorqueUI.Text = CodeUtil1.i18n("Viscous");
      App.ShowViscousTorqueUI.ValueChangedCallback = @() react_ShowViscousTorqueChanged();
      function react_ShowViscousTorqueChanged
        App.RotationalFrictionData.ShowViscousTorque = App.ShowViscousTorqueUI.Value;
        auto_update_plot(App, SkipDataUpdate=true);
      end  % nested function

      % -----------------------------------------------------------------------
      right_column_grid = NewColumnGrid(right_column_layout);
      row_layout = AppUtil1.RowLayout(right_column_grid);

      % Plot unit .............................................................
      row_grid = NewRowGrid(row_layout, Width="1x");

      label_ui = AppUtil1.Component.Label(row_grid);
      label_ui.Text = "\textbf{" + CodeUtil1.i18n("Plot unit") + "}";
      label_ui.HorizontalAlignment = "center";

      name_width = AppUtil1.Constant.Width{"unitwidth"} * 7;

      % Torque drop down ......................................................
      row_grid = NewRowGrid(row_layout, Width="2x");

      subrow_layout = AppUtil1.RowLayout(row_grid);
      subrow_grid = NewRowGrid(subrow_layout, Width="fit");

      label_ui = AppUtil1.Component.Label(subrow_grid);
      label_ui.Text = "Torque";
      label_ui.ComponentWidth = name_width;
      label_ui.HorizontalAlignment = "right";

      subrow_grid = NewRowGrid(subrow_layout);
      App.TorquePlotUnitUI = AppUtil1.Component.DropDown(subrow_grid);
      App.TorquePlotUnitUI.Items = App.torque_unit_items;
      App.TorquePlotUnitUI.ComponentWidth = App.unit_ui_width;
      App.TorquePlotUnitUI.HorizontalAlignment = "left";
      App.TorquePlotUnitUI.ValueChangedCallback = @() react_TorquePlotUnitChanged(App);

      % Velocity drop down ....................................................
      row_grid = NewRowGrid(row_layout, Width="2x");

      subrow_layout = AppUtil1.RowLayout(row_grid);
      subrow_grid = NewRowGrid(subrow_layout, Width="fit");

      label_ui = AppUtil1.Component.Label(subrow_grid);
      label_ui.Text = "Velocity";
      label_ui.ComponentWidth = name_width;
      label_ui.HorizontalAlignment = "right";

      subrow_grid = NewRowGrid(subrow_layout);
      App.VelocityPlotUnitUI = AppUtil1.Component.DropDown(subrow_grid);
      App.VelocityPlotUnitUI.Items = App.angular_speed_unit_items;
      App.VelocityPlotUnitUI.ComponentWidth = App.unit_ui_width;
      App.VelocityPlotUnitUI.HorizontalAlignment = "left";
      App.VelocityPlotUnitUI.ValueChangedCallback = @() react_VelocityPlotUnitChanged(App);

      %% ======================================================================
      main_column_grid = NewColumnGrid(main_column_layout);
      AppUtil1.Component.HorizontalLine(main_column_grid);

      %% ======================================================================
      % Bottom area
      main_column_grid = NewColumnGrid(main_column_layout);

      App.AppBlockSelectorUI = AppUtil1.Component.BlockSelectorUI(main_column_grid);
      App.AppBlockSelectorUI.MainFigure = App.Window.MainFigure;
      App.AppBlockSelectorUI.TargetSimscapeBlockNames = App.TargetSimscapeBlockName;
      App.AppBlockSelectorUI.GetParametersFromBlockCallback = @() callback_get_parameters(App);
      App.AppBlockSelectorUI.SetParametersToBlockCallback = @() callback_set_parameters(App);

    end  % function

    function react_TorquePlotUnitChanged(App)
      App.RotationalFrictionData.TorquePlotUnit = App.TorquePlotUnitUI.Value;
      auto_update_plot(App, SkipDataUpdate=true);
    end  % function

    function react_VelocityPlotUnitChanged(App)
      App.RotationalFrictionData.VelocityPlotUnit = App.VelocityPlotUnitUI.Value;
      auto_update_plot(App, SkipDataUpdate=true);
    end  % function

    function callback_set_parameters(App)
      %%
      % This function reads parameters from the UI components and set them to the selected block.

      % This callback can run only when a valid block path is selected in the block path drop down UI.
      % Thus, accessing App.BlockPathDropDownUI.Value here is safe, i.e., no error check is necessary.
      block_path = replace(App.AppBlockSelectorUI.BlockPathDropDownUI.Value, " / ", "/");
      App.BlockPath = block_path;

      load_system(block_path)

      set_param(block_path, "brkwy_trq", App.BreakawayTorqueUI.Value);
      set_param(block_path, "brkwy_trq_unit", App.BreakawayTorqueUI.Unit);

      set_param(block_path, "brkwy_vel", App.BreakawayVelocityUI.Value);
      set_param(block_path, "brkwy_vel_unit", App.BreakawayVelocityUI.Unit);

      set_param(block_path, "Col_trq", App.CoulombTorqueUI.Value);
      set_param(block_path, "Col_trq_unit", App.CoulombTorqueUI.Unit);

      set_param(block_path, "visc_coef", App.ViscousCoefficientUI.Value);
      set_param(block_path, "visc_coef_unit", App.ViscousCoefficientUI.Unit);

    end  % function

    function callback_get_parameters(App)
      %%
      % This function gets parameters from the selected block and loads them to the app.

      App.BlockPath = replace(App.AppBlockSelectorUI.BlockPathDropDownUI.Value, " / ", "/");

      load_system(App.BlockPath)

      % Create a data object from the specified block path.
      % If block parameters refer to workspace variables,
      % the workspace variables must be loaded upfront.
      % This updates the derived parameters too.
      try
        App.RotationalFrictionData = RotationalFriction1.RotationalFrictionData(Initialize=true, BlockPath=App.BlockPath);
      catch exception
        if App.MainFigure.Visible
          msg = exception.message;
          title_word = CodeUtil1.i18n("Error");
          uialert(App.MainFigure, msg, title_word)

          return

        else

          rethrow(exception)

        end  % if
      end  % try, catch

      % -----------------------------------------------------------------------
      % Prevent the plot auto update while updating UI components.
      prev_value = App.PlotButtonUI.CheckBoxUI.Value;
      App.PlotButtonUI.CheckBoxUI.Value = false;

      block_path = App.BlockPath;

      value_text = get_param(block_path, "brkwy_trq");
      unit_text = get_param(block_path, "brkwy_trq_unit");
      App.BreakawayTorqueUI.ValueText = value_text;
      App.BreakawayTorqueUI.UnitText = unit_text;
      App.RotationalFrictionData.ModelParams.BreakawayTorque = App.BreakawayTorqueUI.SimscapeValue;

      value_text = get_param(block_path, "brkwy_vel");
      unit_text = get_param(block_path, "brkwy_vel_unit");
      App.BreakawayVelocityUI.ValueText = value_text;
      App.BreakawayVelocityUI.UnitText = unit_text;
      App.RotationalFrictionData.ModelParams.BreakawayVelocity = App.BreakawayVelocityUI.SimscapeValue;

      value_text = get_param(block_path, "Col_trq");
      unit_text = get_param(block_path, "Col_trq_unit");
      App.CoulombTorqueUI.ValueText = value_text;
      App.CoulombTorqueUI.UnitText = unit_text;
      App.RotationalFrictionData.ModelParams.CoulombTorque = App.CoulombTorqueUI.SimscapeValue;

      value_text = get_param(block_path, "visc_coef");
      unit_text = get_param(block_path, "visc_coef_unit");
      App.ViscousCoefficientUI.ValueText = value_text;
      App.ViscousCoefficientUI.UnitText = unit_text;
      App.RotationalFrictionData.ModelParams.ViscousCoefficient = App.ViscousCoefficientUI.SimscapeValue;

      % Recover the plot auto update setting.
      App.PlotButtonUI.CheckBoxUI.Value = prev_value;
      % -----------------------------------------------------------------------

      react_UIChanged(App)
    end  % function

    function react_UIChanged(App)
      %%
      arguments (Input)
        App (1,1)
      end  % if

      App.RotationalFrictionData.ShowStribeckTorque = App.ShowStribeckTorqueUI.Value;
      App.RotationalFrictionData.ShowCoulombTorque = App.ShowCoulombTorqueUI.Value;
      App.RotationalFrictionData.ShowViscousTorque = App.ShowViscousTorqueUI.Value;

      updateDerivedParameters(App.RotationalFrictionData.ModelParams)
      updateFrictionTorqueValues(App.RotationalFrictionData)

      update_DerivedParameterUI(App, "StribeckScaledTorque")
      update_DerivedParameterUI(App, "StribeckThresholdVelocity")
      update_DerivedParameterUI(App, "CoulombThresholdVelocity")

      auto_update_plot(App)
    end  % function

    function update_DerivedParameterUI(App, ParamName)
      %%
      % For derived parameters, edit field is read-only while unit is selectable if it is drop-down UI.
      % When this function runs, there is no need to update the plot because
      % this function updates the display value of a derived parameter which
      % does not affect the plot.
      arguments (Input)
        App (1,1)
        ParamName (1,1) string
      end  % if
      current_unit = App.(ParamName + "UI").UnitDropDownUI.Value;
      current_simscape_value = App.RotationalFrictionData.ModelParams.(ParamName);
      App.(ParamName + "UI").ValueTextUI.MainEditField.Value = string(value(current_simscape_value, current_unit));
    end  % function

    function auto_update_plot(App, NameValuePair)
      %%
      arguments (Input)
        App
        NameValuePair.SkipDataUpdate (1,1) logical = false
      end  % arguments
      if App.PlotButtonUI.CheckBoxUI.Value

        update_plot(App, SkipDataUpdate=NameValuePair.SkipDataUpdate)

      end  % if
    end  % function

    function update_plot(App, NameValuePair)
      %%
      arguments (Input)
        App
        NameValuePair.StandAloneFigure (1,1) logical = false
        NameValuePair.SkipDataUpdate (1,1) logical = false
      end  % arguments

      if NameValuePair.StandAloneFigure
        ax = axes(figure);
      else
        ax = App.AxesUI.MainAxes;
      end  % if

      if not(NameValuePair.SkipDataUpdate)
        updateFrictionTorqueValues(App.RotationalFrictionData)
      end  % if

      RotationalFriction1.plotFrictionTorque(RotationalFrictionData=App.RotationalFrictionData, ParentAxes=ax)

    end  % function

  end  % methods
end  % classdef
