classdef DoubleValueUI < AppUtil1.Component.ComponentBase
  % UI component for a value of type double with name, value, info, and side note.
  %
  % This component supports base workspace variables.
  %
  % Errors are reported inline in the UI component, rather than in a dialog window.
  % The inline error reporting allows the user to  interact with other UI components
  % before addressing the reported issue.

  % Copyright 2025 The MathWorks, Inc.

  properties
    % To improve the searchability, use "*Text", such as "NameText".
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
    ValueUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = "1x"
    InfoUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = AppUtil1.Constant.Width{"unitwidth"} * 10
    SideNoteUIWidth (1,:) {CodeUtil1.mustBeTextOrNonnegativeNumber} = 0

    NameUI AppUtil1.Component.Label
    ValueUI AppUtil1.Component.EditField
    InfoUI AppUtil1.Component.EditField
    SideNoteUI AppUtil1.Component.Label

    ValueChangedCallback {CodeUtil1.mustBeFunctionHandleOrEmpty} = []
  end  % properties

  properties
    has_error (1,1) logical = false
    error_message (1,1) string = ""
    Reporting (1,1) matlab.lang.OnOffSwitchState = "off"

    main_grid matlab.ui.container.GridLayout
    name_column_grid matlab.ui.container.GridLayout
    value_column_grid matlab.ui.container.GridLayout
    info_column_grid matlab.ui.container.GridLayout
    sidenote_column_grid matlab.ui.container.GridLayout

    initialized (1,1) logical = false

    double_value (1,:) CodeUtil1.DoubleValue = CodeUtil1.DoubleValue
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

      component.main_grid = uigridlayout(component.base_grid, [1 1]);
      component.main_grid.Layout.Row = 1;
      component.main_grid.Layout.Column = 1;
      component.main_grid.Padding = [0 0 0 0];  % left bottom right top
      component.main_grid.ColumnSpacing = 1;  % Give 1px space between sub-components.
      component.main_grid.RowSpacing = 0;

      component.main_grid.RowHeight = component.ComponentHeight;

      % Each column corresponds to Name, Value, Info, and SideNote.
      component.main_grid.ColumnWidth = {component.NameUIWidth, '1x', 0, 0};

      % ------------------------------------------------------------------------
      %  Name

      component.name_column_grid = uigridlayout(component.main_grid, [1 1]);
      component.name_column_grid.Layout.Row = 1;
      component.name_column_grid.Layout.Column = 1;
      component.name_column_grid.Padding = [0 0 0 0];  % left bottom right top
      component.name_column_grid.RowHeight = {'1x', 'fit', '1x'};
      component.name_column_grid.RowSpacing = 0;
      component.name_column_grid.ColumnWidth = {'fit'};
      component.name_column_grid.ColumnSpacing = 0;

      component.NameUI = AppUtil1.Component.Label(component.name_column_grid);
      component.NameUI.Layout.Row = 2;  % middle cell
      component.NameUI.Layout.Column = 1;
      component.NameUI.ComponentHeight = component.ComponentHeight;
      component.NameUI.ComponentWidth = component.NameUIWidth;
      component.NameUI.Text = CodeUtil1.i18n("Double value");

      % ------------------------------------------------------------------------
      % Value

      component.value_column_grid = uigridlayout(component.main_grid, [1 1]);
      component.value_column_grid.Layout.Row = 1;
      component.value_column_grid.Layout.Column = 2;
      component.value_column_grid.Padding = [0 0 0 0];  % left bottom right top
      component.value_column_grid.RowHeight = {'1x', 'fit', '1x'};
      component.value_column_grid.RowSpacing = 0;
      component.value_column_grid.ColumnWidth = {'1x'};  % Expand horizontally
      component.value_column_grid.ColumnSpacing = 0;

      component.ValueUI = AppUtil1.Component.EditField(component.value_column_grid);
      component.ValueUI.Layout.Row = 2;
      component.ValueUI.Layout.Column = 1;
      component.ValueUI.ValueChangedCallback = @() react_ValueTextUI_ValueChanged(component);
      component.ValueUI.ComponentWidth = component.ValueUIWidth;
      % To avoid triggering ValueUI's callback, use MainEditField's Value
      % rather than ValueUI's Value.
      component.ValueUI.MainEditField.Value = "0";

      % ------------------------------------------------------------------------
      % Info

      component.info_column_grid = uigridlayout(component.main_grid, [1 1]);
      component.info_column_grid.Layout.Row = 1;
      component.info_column_grid.Layout.Column = 3;
      component.info_column_grid.Padding = [0 0 0 0];  % left bottom right top
      component.info_column_grid.RowHeight = {'1x', 'fit', '1x'};
      component.info_column_grid.RowSpacing = 0;
      component.info_column_grid.ColumnWidth = {'1x'};  % Expand horizontally
      component.info_column_grid.ColumnSpacing = 0;

      component.InfoUI = AppUtil1.Component.EditField(component.info_column_grid);
      component.InfoUI.Layout.Row = 2;
      component.InfoUI.Layout.Column = 1;
      component.InfoUI.ComponentWidth = component.InfoUIWidth;
      component.InfoUI.ReadOnly = "on";
      component.InfoUI.MainEditField.Value = "";

      % ------------------------------------------------------------------------
      % SideNote

      component.sidenote_column_grid = uigridlayout(component.main_grid, [1 1]);
      component.sidenote_column_grid.Layout.Row = 1;
      component.sidenote_column_grid.Layout.Column = 4;
      component.sidenote_column_grid.Padding = [0 0 0 0];
      component.sidenote_column_grid.RowHeight = {'1x', 'fit', '1x'};
      component.sidenote_column_grid.RowSpacing = 0;
      component.sidenote_column_grid.ColumnWidth = {'1x'};  % Expand horizontally
      component.sidenote_column_grid.ColumnSpacing = 0;

      component.SideNoteUI = AppUtil1.Component.Label(component.sidenote_column_grid);
      component.SideNoteUI.Layout.Row = 2;
      component.SideNoteUI.Layout.Column = 1;
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

      component.main_grid.ColumnWidth = {component.NameUIWidth, component.ValueUIWidth, component.InfoUIWidth, component.SideNoteUIWidth};

      % Value UI
      component.ValueUI.ComponentWidth = component.ValueUIWidth;

      % Info UI
      component.InfoUI.ComponentWidth = component.InfoUIWidth;
      if strlength(component.InfoText) > 0
        component.InfoUI.MainEditField.Tooltip = component.InfoText;
      else
        % Hide
        component.main_grid.ColumnWidth{3} = 0;
        component.InfoUI.MainEditField.Tooltip = "";
      end  % if

      % Side-note UI
      if component.SideNoteUIWidth > 0
        component.SideNoteUI.ComponentWidth = component.SideNoteUIWidth;
      else
        % Hide
        component.main_grid.ColumnWidth{4} = 0;
        % Set a positive value. (0 is not allowed.)
        component.SideNoteUI.ComponentWidth = 10;
      end  % if

      if component.HighlightBackground
        component.NameUI.HighlightBackground = "on";
        component.ValueUI.HighlightBackground = "on";
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

      component.main_grid.RowHeight = component.ComponentHeight;

      component.NameUI.ComponentHeight = component.ComponentHeight;
      component.NameUI.ComponentWidth = component.NameUIWidth;
      component.NameUI.MainLabel.Text = component.NameText;

      component.ValueUI.ComponentHeight = component.ComponentHeight;
      if component.ReadOnlyValueText
        component.ValueUI.ReadOnly = "on";
      end  % if

      component.InfoUI.ComponentHeight = component.ComponentHeight;

      react_ValueTextUI_ValueChanged(component)
    end  % function

  end  % methods

  methods

    function alertOnError(component)
      %%
      if not(component.has_error)

        return

      end  % if
      if not(startsWith(component.error_message, "Error:"))
        message = "Error: " + component.error_message;
      else
        message = component.error_message;
      end  % if
      component.main_grid.ColumnWidth = {component.NameUIWidth, '1x', '2x', 0};
      component.info_column_grid.ColumnWidth = {'1x'};
      component.InfoUI.ComponentWidth = "1x";
      component.InfoUI.Value = message;
      component.InfoUI.MainEditField.Tooltip = message;
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
    end  % function

    % --------------------------------------------------------------------------
    % ValueText

    function str = get.ValueText(component)
      % Value returns the content of the value UI.
      % It is a string representing a number or an expression.
      arguments (Output)
        str string
      end  % arguments
      str = component.ValueUI.MainEditField.Value;
    end  % function

    function set.ValueText(component, str)
      arguments (Input)
        component
        str string
      end  % arguments
      try
        component.double_value.ValueText = str;
      catch exception
        component.has_error = true;
        component.error_message = exception.message;

        return

      end  % try, catch
      % This assignment triggers the react_ValueTextUI_ValueChanged callback.
      component.ValueUI.Value = str;
    end  % function

  end  % methods
  methods (Access=private)

    function react_ValueTextUI_ValueChanged(component)
      %%
      current_value_text = component.ValueUI.MainEditField.Value;
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
      squashed_current_value_text = CodeUtil1.squashCodeText(component.ValueUI.MainEditField.Value);
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
        component.main_grid.ColumnWidth{3} = 0;
      else
        % Show the Info UI.
        component.main_grid.ColumnWidth{3} = component.InfoUIWidth;
        component.InfoUI.ComponentWidth = component.InfoUIWidth;
      end  % if
    end  % function

  end  % methods
end  % classdef
