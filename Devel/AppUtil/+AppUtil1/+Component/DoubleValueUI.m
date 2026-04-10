classdef DoubleValueUI < AppUtil1.Component.ComponentBase
  % UI component for a value of type double with name, value, info, and side note.
  %
  % This component supports using a variable in the base workspace.

  % Errors are reported inline in the UI component, rather than in a dialog window.
  % The inline error reporting allows the user to  interact with other UI components
  % before addressing the reported issue.

  % Copyright 2025-2026 The MathWorks, Inc.

  properties

    double_value (1,:) CodeUtil1.DoubleValue = CodeUtil1.DoubleValue

    NameText (1,1) string = "Double value"
    NameInInfo (1,1) string = ""
  end  % properties
  properties (Dependent)
    ValueText (1,1) string = ""
  end  % properties
  properties
    ReadOnlyValueText (1,1) logical = false
  end  % properties
  properties (Dependent)
    InfoText (1,1) string
  end  % properties
  properties
    SideNote (1,1) string
  end  % properties
  properties (Dependent)
    MainDoubleValue (1,:) double
  end  % properties
  properties
    ComponentHeight (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = AppUtil1.Constant.Height{"oneline++"}

    NameUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = AppUtil1.Constant.Width{"unitwidth"} * 14
    AlertUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = 30
    ValueUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = "1x"
    InfoUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = AppUtil1.Constant.Width{"unitwidth"} * 10
    SideNoteUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = 1

    NameUI AppUtil1.Component.Label
    AlertUI AppUtil1.Graphics.Image
    ValueTextUI AppUtil1.Component.EditField
    InfoUI AppUtil1.Component.EditField
    SideNoteUI AppUtil1.Component.Label

    ValueChangedCallback {CodeUtil1.mustBeFunctionHandleOrEmpty} = []
  end  % properties

  properties
    has_error (1,1) logical = false
    error_message (1,1) string = ""
    Reporting (1,1) matlab.lang.OnOffSwitchState = "off"

    main_horizontal_container AppUtil1.HorizontalContainer

    name_grid matlab.ui.container.GridLayout
    alert_grid matlab.ui.container.GridLayout
    value_grid matlab.ui.container.GridLayout
    info_grid matlab.ui.container.GridLayout
    sidenote_grid matlab.ui.container.GridLayout

    initialized (1,1) logical = false
  end  % properties

  events (HasCallbackProperty, NotifyAccess=protected)
    % DoubleValueChanged event adds DoubleValueChangedFcn property to this class.
    DoubleValueChanged
  end  % events

  methods (Access=protected)

    function setup(component)
      %%
      setup@AppUtil1.Component.ComponentBase(component)

      % Visibility of UI sub-components is controlled by main grid's ColumnWidth.
      % Each sub-component's ComponentWidth does not affect the visibility.

      component.main_horizontal_container = AppUtil1.HorizontalContainer(component.base_grid);

      % ------------------------------------------------------------------------
      %  Name

      component.name_grid = addHorizontalGridLayout(component.main_horizontal_container, Width="fit");

      component.NameUI = AppUtil1.Component.Label(component.name_grid);
      component.NameUI.MainFigure = component.MainFigure;
      component.NameUI.ComponentHeight = component.ComponentHeight;
      component.NameUI.ComponentWidth = component.NameUIWidth;
      component.NameUI.Text = CodeUtil1.i18n("Double value");

      % ------------------------------------------------------------------------
      %  Alert

      component.alert_grid = addHorizontalGridLayout(component.main_horizontal_container, Width="fit");

      component.AlertUI = AppUtil1.Graphics.Image(component.alert_grid);
      component.AlertUI.MainFigure = component.MainFigure;
      component.AlertUI.ComponentHeight = component.ComponentHeight;
      component.AlertUI.ComponentWidth = component.AlertUIWidth;

      % ------------------------------------------------------------------------
      % Value

      component.value_grid = addHorizontalGridLayout(component.main_horizontal_container);

      component.ValueTextUI = AppUtil1.Component.EditField(component.value_grid);
      component.ValueTextUI.MainFigure = component.MainFigure;
      component.ValueTextUI.ValueChangedCallback = @() react_ValueTextUI_ValueChanged(component);
      % To avoid triggering ValueUI's callback, use MainEditField's Value
      % rather than ValueUI's Value.
      component.ValueTextUI.MainEditField.Value = "0";

      % ------------------------------------------------------------------------
      % Info

      component.info_grid = addHorizontalGridLayout(component.main_horizontal_container, Width="fit");

      component.InfoUI = AppUtil1.Component.EditField(component.info_grid);
      component.InfoUI.MainFigure = component.MainFigure;
      component.InfoUI.ComponentWidth = component.InfoUIWidth;
      component.InfoUI.ReadOnly = "on";
      component.InfoUI.MainEditField.Value = "";

      % ------------------------------------------------------------------------
      % SideNote

      component.sidenote_grid = addHorizontalGridLayout(component.main_horizontal_container, Width="fit");

      component.SideNoteUI = AppUtil1.Component.Label(component.sidenote_grid);
      component.SideNoteUI.MainFigure = component.MainFigure;
      component.SideNoteUI.ComponentWidth = 10;  % Width gets updated later.
      component.SideNoteUI.Text = "";

    end  % function

    function update(component)
      %%
      update@AppUtil1.Component.ComponentBase(component)

      if component.initialized
        regular_update(component)
        alertOnError(component)

        return

      end  % if

      first_update(component)
      alertOnError(component)

      component.initialized = true;
    end  % function

    function regular_update(component)
      %%
      if component.NameInInfo == ""
        component.NameInInfo = component.NameText;
      end  % if

      if strlength(component.InfoText) > 0
        % Show the Info UI.
        component.info_grid.ColumnWidth{1} = component.InfoUIWidth;
        component.InfoUI.ComponentWidth = component.InfoUIWidth;
        component.InfoUI.MainEditField.Tooltip = component.InfoText;
      else
        % Hide the Info UI.
        component.info_grid.ColumnWidth{1} = 0;
        component.InfoUI.MainEditField.Tooltip = "";
      end  % if

      % Side-note UI
      if component.SideNoteUIWidth > 0
        % Show the side-note UI.
        component.sidenote_grid.ColumnWidth{1} = component.SideNoteUIWidth;
        component.SideNoteUI.ComponentWidth = component.SideNoteUIWidth;
      else
        % Hide the side-note UI.
        component.sidenote_grid.ColumnWidth{1} = 0;
        % Set a positive value. (0 is not allowed.)
        % component.SideNoteUI.ComponentWidth = 10;
      end  % if

      if component.HighlightBackground
        component.NameUI.HighlightBackground = "on";
        component.AlertUI.HighlightBackground = "on";
        component.ValueTextUI.HighlightBackground = "on";
        component.InfoUI.HighlightBackground = "on";
        component.SideNoteUI.HighlightBackground = "on";
        switch component.ThemeNameForBackGroundHighlight
          case "light"
            component.main_grid.BackgroundColor = component.LightThemeBackGroundColor;
          case "dark"
            component.main_grid.BackgroundColor = component.DarkThemeBackGroundColor;
        end  % switch
      end  % if
    end  % function

    function first_update(component)
      %%
      % This function is called only once after the setup finished and
      % public properties have been updated with the user-specified values.
      % Use this method to freeze property values based on the user-specified values.

      if component.has_error

        error(component.error_message)  % !todo: app must stop running

      end  % if

      component.main_horizontal_container.BaseGridLayout.RowHeight = component.ComponentHeight;

      component.NameUI.ComponentHeight = component.ComponentHeight;
      component.NameUI.ComponentWidth = component.NameUIWidth;
      component.NameUI.MainLabel.Text = component.NameText;

      component.AlertUI.ComponentHeight = component.ComponentHeight;

      component.ValueTextUI.ComponentHeight = component.ComponentHeight;
      if component.ReadOnlyValueText
        component.ValueTextUI.ReadOnly = "on";
      end  % if
      component.ValueTextUI.MainEditField.Value = component.ValueText;  % !attn: probably unnecessary

      component.InfoUI.ComponentHeight = component.ComponentHeight;
      component.InfoUI.ComponentWidth = component.InfoUIWidth;

      component.SideNoteUI.ComponentHeight = component.ComponentHeight;
      component.SideNoteUI.ComponentWidth = component.SideNoteUIWidth;
    end  % function

  end  % methods

  methods

    function alertOnError(component)
      %%
      if not(component.has_error)
        component.AlertUI.MainImage.Visible = "off";
        component.AlertUI.MainImage.Tooltip = "";
        component.AlertUI.ImageClickedCallback = @() true;

        return

      end  % if
      if startsWith(component.error_message, "Error:")
        message = component.error_message;
      else
        message = "Error: " + component.error_message;
      end  % if

      component.AlertUI.MainImage.Visible = "on";
      component.AlertUI.MainImage.Tooltip = message + CodeUtil1.i18n(" (Click the icon to copy the message to clipboard.)");
      component.AlertUI.ImageClickedCallback = @() clipboard("copy", message);
    end  % function

    % --------------------------------------------------------------------------
    % MainDoubleValue

    function x = get.MainDoubleValue(component)
      arguments (Output)
        x double
      end  % arguments
      x = component.double_value.MainDoubleValue;
    end  % function

    function set.MainDoubleValue(component, x)
      arguments (Input)
        component
        x (1,:) double
      end  % arguments
      try
        component.double_value.MainDoubleValue = x;
      catch exception
        component.has_error = true;
        component.error_message = exception.message;

        return

      end  % try, catch
      component.has_error = false;
      component.error_message = "";

      component.ValueText = x;
    end  % function

    % --------------------------------------------------------------------------
    % ValueText

    function str = get.ValueText(component)
      % Value returns the content of the value UI.
      % It is a string representing a number or an expression.
      arguments (Output)
        str string
      end  % arguments
      str = component.ValueTextUI.MainEditField.Value;
    end  % function

    function set.ValueText(component, str)
      arguments (Input)
        component
        str string
      end  % arguments
      try
        component.double_value.ValueText = str;
 
        % Show the tooltip because the width of the ValueTextUI may be shorter than its content.
        component.ValueTextUI.MainEditField.Tooltip = str;

     catch exception
        component.has_error = true;
        component.error_message = exception.message;

        return

      end  % try, catch

      % This assignment triggers the react_ValueTextUI_ValueChanged callback.
      component.ValueTextUI.Value = str;

      updateInfoUI(component)

    end  % function

  end  % methods
  methods (Access=private)

    function react_ValueTextUI_ValueChanged(component)
      %%
      current_value_text = component.ValueTextUI.MainEditField.Value;
      try
        component.double_value.ValueText = current_value_text;
      catch exception
        component.has_error = true;
        component.error_message = exception.message;

        return

      end  % try, catch
      component.has_error = false;
      component.error_message = "";

      updateInfoUI(component)

      if not(isempty(component.ValueChangedCallback))
        % Call the user-specified callback.
        component.ValueChangedCallback()
      end

      notify(component, "DoubleValueChanged")
      % Make sure to define DoubleValueChanged event.

    end  % function

  end  % methods
  methods

    function updateInfoUI(component)
      % Update the InfoUI using the current double_value.DoubleValue.
      dbl_val = component.double_value.MainDoubleValue;
      squashed_value_text = CodeUtil1.squashCodeText(CodeUtil1.stringify(dbl_val));

      % The data in ValueUI is of type double.
      squashed_current_value_text = CodeUtil1.squashCodeText(component.ValueTextUI.MainEditField.Value);
      if squashed_value_text ~= squashed_current_value_text
        component.InfoText = squashed_value_text;
      else
        component.InfoText = "";
      end  % if
    end  % function

    % --------------------------------------------------------------------------
    % InfoText

    function str = get.InfoText(component)
      arguments (Output)
        str string
      end  % arguments
      str = component.InfoUI.MainEditField.Value;
    end  % function

    function set.InfoText(component, str)
      arguments (Input)
        component
        str string
      end  % arguments
      component.InfoUI.MainEditField.Value = str;
      if str == ""
        % Hide the Info UI.
        component.info_grid.ColumnWidth{1} = 0;
      else
        % Show the Info UI.
        component.info_grid.ColumnWidth{1} = component.InfoUIWidth;
      end  % if
    end  % function

  end  % methods
end  % classdef
