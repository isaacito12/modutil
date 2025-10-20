classdef PhysicalValueUIPrototype < AppUtil1.Component.ComponentBase
  % UI component for simscape.Value with name, value, info, and unit UIs
  %
  % This component supports using variables in the base workspace.
  %
  % Errors are reported inline in the UI component, rather than in a dialog window.
  % The inline error reporting allows the user to leave the error unaddressed and
  % do other operations in the app.

  % Always keep these properties up to date regardless of their visibility.
  %   component.UnitLabelUI.MainLabel.Text
  %   component.UnitDropDownUI.MainDropDown.Value

  % Copyright 2023-2025 The MathWorks, Inc.

  properties
    % To improve the searchability, use "*Text", such as "NameText".
    NameText (1,1) string = "Physical value"
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

    % UnitItems determines if the unit UI should be a label or a drop down.
    % If there is only one item, a label is used. Otherwise, a drop down is used.
    % It is determined in the first update, and then you can't change it.
    UnitItems (1,:) string

    UnitText (1,1) string
    UnitAlias (1,1) string
  end  % properties
  properties (Dependent)
    SimscapeValue (1,:) simscape.Value
  end  % properties
  properties
    ComponentHeight (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = AppUtil1.Constant.Height{"oneline++"}

    NameUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = AppUtil1.Constant.Width{"unitwidth"} * 14
    ValueUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = "1x"
    InfoUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = AppUtil1.Constant.Width{"unitwidth"} * 10
    UnitUIWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = AppUtil1.Constant.Width{"unitwidth"} * 10

    NameUI AppUtil1.Component.Label
    ValueTextUI AppUtil1.Component.EditField
    InfoUI AppUtil1.Component.EditField
    UnitLabelUI AppUtil1.Component.Label
    UnitDropDownUI AppUtil1.Component.EditableDropDown

    ValueChangedCallback {CodeUtil1.mustBeFunctionHandleOrEmpty} = []
    UnitChangedCallback {CodeUtil1.mustBeFunctionHandleOrEmpty} = []
  end  % properties

  properties
    has_error (1,1) logical = false
    error_message (1,1) string = ""
    Reporting (1,1) matlab.lang.OnOffSwitchState = "off"
    unit_ui_style (1,1) string {mustBeMember(unit_ui_style, ["label", "dropdown", "alias"])} = "label"

    main_grid matlab.ui.container.GridLayout
    name_column_grid matlab.ui.container.GridLayout
    value_column_grid matlab.ui.container.GridLayout
    info_column_grid matlab.ui.container.GridLayout
    unit_column_grid matlab.ui.container.GridLayout

    initialized (1,1) logical = false
    unit_specified (1,1) logical = false
    unit_alias_specified (1,1) logical = false

    physical_value (1,:) CodeUtil1.PhysicalValue

    % For error recovery in the Unit UI.
    current_unit_text (1,1) string = ""
  end  % properties

  events (HasCallbackProperty, NotifyAccess=protected)

    % PhysicalValueChanged event adds PhysicalValueChangedFcn property to this class.
    PhysicalValueChanged

    % PhysicalUnitChanged event adds PhysicalUnitChangedFcn property to this class.
    PhysicalUnitChanged

  end  % events

  methods (Access=protected)

    function setup(component)
      %%
      setup@AppUtil1.Component.ComponentBase(component)

      % Visibilities of UI subcomponents are controlled by main grid's ColumnWidth.
      % Each subcomponent's ComponentWidth does not affect the visibility.

      component.main_grid = uigridlayout(component.base_grid, [1 1]);
      component.main_grid.Layout.Row = 1;
      component.main_grid.Layout.Column = 1;
      component.main_grid.Padding = [0 0 0 0];  % left bottom right top
      component.main_grid.ColumnSpacing = 1;  % Give 1px space between the name, value, info, and unit columns.
      component.main_grid.RowSpacing = 0;

      component.main_grid.RowHeight = component.ComponentHeight;

      % Each column corresponds to Name, Value, Info, and Unit.
      component.main_grid.ColumnWidth = {component.NameUIWidth, '1x', 0, 0};

      % ------------------------------------------------------------------------
      %  Name

      component.name_column_grid = uigridlayout(component.main_grid, [1 1]);
      component.name_column_grid.Layout.Row = 1;
      component.name_column_grid.Layout.Column = 1;
      component.name_column_grid.Padding = [0 0 0 0];  % left bottom right top
      component.name_column_grid.RowHeight = {'1x', 'fit', '1x'};
      component.name_column_grid.RowSpacing = 0;
      % component.name_column_grid.ColumnWidth = component.NameUIWidth;
      component.name_column_grid.ColumnWidth = {'fit'};
      component.name_column_grid.ColumnSpacing = 0;

      component.NameUI = AppUtil1.Component.Label(component.name_column_grid);
      component.NameUI.Layout.Row = 2;  % middle cell
      component.NameUI.Layout.Column = 1;
      component.NameUI.ComponentHeight = component.ComponentHeight;
      component.NameUI.ComponentWidth = component.NameUIWidth;
      component.NameUI.Text = CodeUtil1.i18n("Physical value");

      % ------------------------------------------------------------------------
      % Value

      component.value_column_grid = uigridlayout(component.main_grid, [1 1]);
      component.value_column_grid.Layout.Row = 1;
      component.value_column_grid.Layout.Column = 2;
      component.value_column_grid.Padding = [0 0 0 0];  % left bottom right top
      component.value_column_grid.RowHeight = {'1x', 'fit', '1x'};
      component.value_column_grid.RowSpacing = 0;
      component.value_column_grid.ColumnWidth = {'1x'};  % Expand the Value UI horizontally
      component.value_column_grid.ColumnSpacing = 0;

      component.ValueTextUI = AppUtil1.Component.EditField(component.value_column_grid);
      component.ValueTextUI.Layout.Row = 2;
      component.ValueTextUI.Layout.Column = 1;
      component.ValueTextUI.ValueChangedCallback = @() react_ValueTextUI_ValueChanged(component);
      % To avoid triggering ValueUI's callback, use MainEditField's Value
      % rather than ValueUI's Value.
      component.ValueTextUI.MainEditField.Value = "0";

      % ------------------------------------------------------------------------
      % Info

      component.info_column_grid = uigridlayout(component.main_grid, [1 1]);
      component.info_column_grid.Layout.Row = 1;
      component.info_column_grid.Layout.Column = 3;
      component.info_column_grid.Padding = [0 0 0 0];  % left bottom right top
      component.info_column_grid.RowHeight = {'1x', 'fit', '1x'};
      component.info_column_grid.RowSpacing = 0;
      component.info_column_grid.ColumnWidth = {'fit'};
      component.info_column_grid.ColumnSpacing = 0;

      component.InfoUI = AppUtil1.Component.EditField(component.info_column_grid);
      component.InfoUI.Layout.Row = 2;
      component.InfoUI.Layout.Column = 1;
      component.InfoUI.ComponentWidth = component.InfoUIWidth;
      component.InfoUI.ReadOnly = "on";
      component.InfoUI.MainEditField.Value = "";

      % ------------------------------------------------------------------------
      % Unit

      component.unit_column_grid = uigridlayout(component.main_grid, [1 1]);
      component.unit_column_grid.Layout.Row = 1;
      component.unit_column_grid.Layout.Column = 4;
      component.unit_column_grid.Padding = [0 0 0 0];
      component.unit_column_grid.RowHeight = {'1x', 0, 0, 0};  % create 4 rows
      component.unit_column_grid.RowSpacing = 0;
      component.unit_column_grid.ColumnWidth = {'fit'};
      component.unit_column_grid.ColumnSpacing = 0;

      component.UnitLabelUI = AppUtil1.Component.Label(component.unit_column_grid);
      component.UnitLabelUI.Layout.Row = 2;  % 2nd row
      component.UnitLabelUI.Layout.Column = 1;
      component.UnitLabelUI.ComponentWidth = component.UnitUIWidth;
      component.UnitLabelUI.Text = "1";

      component.UnitDropDownUI = AppUtil1.Component.EditableDropDown(component.unit_column_grid);
      component.UnitDropDownUI.Layout.Row = 3;  % 3rd row
      component.UnitDropDownUI.Layout.Column = 1;
      component.UnitDropDownUI.ComponentWidth = component.UnitUIWidth;
      component.UnitDropDownUI.ValueChangedCallback = @() react_UnitUI_ValueChanged(component);
      % To avoid triggering UnitDropDownUI's callback, use MainDropDown's properties.
      % Specify one item in the setup.
      % If two or more items are specified before the first update,
      % the drop down UI is used. Otherwise, the label is used.
      component.UnitDropDownUI.MainDropDown.Items = "1";
      component.UnitDropDownUI.MainDropDown.Value = "1";

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

      component.main_grid.ColumnWidth = {component.NameUIWidth, '1x', 0, 0};

      if strlength(component.InfoText) > 0
        % Show the Info UI.
        component.main_grid.ColumnWidth{3} = component.InfoUIWidth;
        component.InfoUI.ComponentWidth = component.InfoUIWidth;
        component.InfoUI.MainEditField.Tooltip = component.InfoText;
      else
        % Hide the Info UI.
        component.main_grid.ColumnWidth{3} = 0;
        component.InfoUI.MainEditField.Tooltip = "";
      end  % if

      component.main_grid.ColumnWidth{4} = component.UnitUIWidth;
      if isscalar(component.UnitDropDownUI.MainDropDown.Items)
        % label
        component.unit_column_grid.RowHeight = {'1x', 'fit', 0, '1x'};
        component.UnitLabelUI.ComponentWidth = component.UnitUIWidth;
      else
        % dropdown
        component.unit_column_grid.RowHeight = {'1x', 0, 'fit', '1x'};
        component.UnitDropDownUI.ComponentWidth = component.UnitUIWidth;
      end  % if

      if component.HighlightBackground
        component.NameUI.HighlightBackground = "on";
        component.ValueTextUI.HighlightBackground = "on";
        component.InfoUI.HighlightBackground = "on";
        component.UnitLabelUI.HighlightBackground = "on";
        component.UnitDropDownUI.HighlightBackground = "on";
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

      component.ValueTextUI.ComponentHeight = component.ComponentHeight;
      if component.ReadOnlyValueText
        component.ValueTextUI.ReadOnly = "on";
      end  % if
      component.ValueTextUI.MainEditField.Value = component.ValueText;

      component.InfoUI.ComponentHeight = component.ComponentHeight;
      component.InfoUI.ComponentWidth = component.InfoUIWidth;

      component.UnitDropDownUI.ComponentWidth = component.UnitUIWidth;
      component.UnitLabelUI.ComponentWidth = component.UnitUIWidth;

      if isscalar(component.UnitDropDownUI.MainDropDown.Items)
        if component.unit_alias_specified
          component.unit_ui_style = "alias";
        else
          component.unit_ui_style = "label";
        end  % if
      else
        component.unit_ui_style = "dropdown";
      end  % if
      component.unit_specified = true;
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
    % Simscape value

    function x = get.SimscapeValue(component)
      arguments (Output)
        x simscape.Value
      end  % arguments
      x = component.physical_value.SimscapeValue;
    end  % function

    function set.SimscapeValue(component, x)
      arguments (Input)
        component
        x (1,:) simscape.Value
      end  % arguments
      try
        component.physical_value.SimscapeValue = x;
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
      % It is a string representing a number, a simscape.Value, or an expression.
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
        component.physical_value.ValueText = str;
      catch exception
        component.has_error = true;
        component.error_message = exception.message;

        return

      end  % try, catch
      % This assignment triggers the react_ValueTextUI_ValueChanged callback.
      component.ValueTextUI.Value = str;
    end  % function

  end  % methods
  methods (Access=private)

    function react_ValueTextUI_ValueChanged(component)
      %%
      current_value_text = component.ValueTextUI.MainEditField.Value;
      try
        component.physical_value.ValueText = current_value_text;
      catch exception
        component.has_error = true;
        component.error_message = exception.message;

        return

      end  % try, catch
      component.has_error = false;
      component.error_message = "";

      updateInfoAndUnitUIs(component)

      if not(isempty(component.ValueChangedCallback))
        % Call the user-specified callback.
        component.ValueChangedCallback()
      end

      notify(component, "PhysicalValueChanged")
      % Make sure to define PhysicalValueChanged event.

    end  % function

  end  % methods
  methods

    function updateInfoAndUnitUIs(component)
      % Update the InfoUI and the UnitUI using the current physical_value.SimscapeValue.
      sscval = component.physical_value.SimscapeValue;
      unit_text = string(unit(sscval));
      squashed_value_text = CodeUtil1.squashCodeText(CodeUtil1.stringify(value(sscval)));

      % InfoUI
      if component.physical_value.ValueTextIsSimscapeValue
        component.InfoText = squashed_value_text + " (" + unit_text + ")";
      else
        % The data in ValueTextUI is of type double.
        squashed_current_value_text = CodeUtil1.squashCodeText(component.ValueTextUI.MainEditField.Value);
        if squashed_value_text ~= squashed_current_value_text
          component.InfoText = squashed_value_text;
        else
          component.InfoText = "";
        end  % if
      end  % if

      % UnitUI

      if component.physical_value.ValueTextIsSimscapeValue
        component.UnitLabelUI.MainLabel.Enable = "off";
        component.UnitDropDownUI.MainDropDown.Enable = "off";
      else
        % The data in ValueTextUI is of type double.
        component.UnitDropDownUI.MainDropDown.Enable = "on";
        component.UnitLabelUI.MainLabel.Enable = "on";
      end  % if

      if component.unit_alias_specified
        component.UnitLabelUI.MainLabel.Text = string(component.physical_value.UnitAlias);
      else
        component.UnitLabelUI.MainLabel.Text = unit_text;
        component.UnitDropDownUI.MainDropDown.Value = unit_text;
      end  % if

      component.UnitText = unit_text;

      % Add the unit to the drop down items if it is not.
      if not(ismember(unit_text, component.UnitDropDownUI.MainDropDown.Items))
        component.UnitDropDownUI.MainDropDown.Items{end + 1} = char(unit_text);
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
      end  % if
    end  % function

    % --------------------------------------------------------------------------
    % UnitItems

    function items = get.UnitItems(component)
      %%
      % If unit alias is defined, the alias string is returned rather than "1".
      arguments (Output)
        items (1,:) string
      end  % arguments
      if component.unit_ui_style == "dropdown"
        items = component.UnitDropDownUI.MainDropDown.Items;
      else
        % Unit UI style is either "alias" or "label". Only one unit text is defined.
        if component.UnitAlias ~= ""
          items = component.UnitAlias;
        else
          items = component.UnitLabelUI.MainLabel.Text;
        end  % if
      end  % if
    end  % function

    function set.UnitItems(component, items)
      %%
      % If unit items are already defined, accept the new items only if
      % their units are commensurate with the defined ones.
      % A new simscape.Value object is created with the first unit item.
      % Unit alias is removed.
      arguments (Input)
        component
        items (1,:) string {CodeUtil1.mustBeAllCommensurateUnit}
      end  % arguments
      if component.unit_specified
        if not(simscape.isCommensurateUnit(items{:}, component.UnitDropDownUI.MainDropDown.Items{:}))
          component.has_error = true;
          component.error_message = CodeUtil1.i18n("New unit items must be commensurate with the current unit items.");

          return

        end  % if
      end  % if
      if isscalar(items)
        component.unit_ui_style = "label";
      else
        component.unit_ui_style = "dropdown";
      end  % if
      component.physical_value = CodeUtil1.PhysicalValue(UnitText=items(1));
      component.UnitLabelUI.MainLabel.Text = items(1);
      component.UnitDropDownUI.MainDropDown.Items = items;
      component.UnitDropDownUI.MainDropDown.Value = items(1);
      component.current_unit_text = items(1);
      component.unit_specified = true;
    end  % function

    % --------------------------------------------------------------------------
    % UnitText

    function unit_text = get.UnitText(component)
      %%
      arguments (Output)
        unit_text (1,1) string
      end  % arguments
      if component.unit_specified
        unit_text = component.physical_value.UnitText;
      else
        % This branch is reachable only before the first update because
        % the first update specifies the unit.
        unit_text = "1";
      end  % if
    end  % function

    function set.UnitText(component, NewUnitText)
      %%
      arguments (Input)
        component
        NewUnitText (1,1) string
      end  % arguments
      % This must continue to work after the first_update method because
      % this is used to select a unit from the drop down list.
      if component.unit_specified && (component.physical_value.UnitAlias ~= "")
        % Case 1: Unit alias is defined, which implies the unit must be "1".
        if NewUnitText ~= "1"
          component.has_error = true;
          component.error_message = CodeUtil1.i18n("Unit alias is defined. ""1"" is the only allowed unit: " + NewUnitText);

          return

        else
          % NewUnitText is "1". component.physical_value.UnitText is already "1".
          component.has_error = false;
          component.error_message = "";
          component.current_unit_text = "1";
          component.unit_ui_style = "label";

          return

        end  % if
      elseif component.unit_specified && isscalar(component.UnitItems)
        % Case 2: Single unit is defined. Allow changing the unit if it is commensurate.
        if component.unit_alias_specified
          assert(component.unit_ui_style == "alias")

          return

        end  % if
        if not(simscape.isCommensurateUnit(NewUnitText, component.physical_value.UnitText))
          component.has_error = true;
          component.error_message = CodeUtil1.i18n("New unit must be commensurate with the current unit.");
          if not(component.initialized)

            % The app is not visible yet. Show the error message in the Command Window.
            error(component.error_message)  % severe-error !todo: app must exit

          else

            return

          end  % if
        end  % if
        component.physical_value.UnitText = NewUnitText;
        component.UnitLabelUI.MainLabel.Text = NewUnitText;
        component.has_error = false;
        component.error_message = "";
        component.current_unit_text = NewUnitText;
        component.unit_ui_style = "label";

        return

      elseif component.unit_specified && (numel(component.UnitItems) > 1)
        % Case 3: Multiple units are defined. Allow selecting one from the defined units.
        unit_items = component.UnitDropDownUI.MainDropDown.Items;
        if not(simscape.isCommensurateUnit(NewUnitText, unit_items{1}))
          unit_items_joined = join(unit_items, ", ");
          component.has_error = true;
          component.error_message = CodeUtil1.i18n("New unit must be one of the defined units: ") + unit_items_joined;
          if not(component.initialized)

            % The app is not visible yet. Show the error message in the Command Window.
            error(component.error_message)  % severe-error !todo: app must exit

          else

            return

          end  % if
        end  % if
        component.UnitLabelUI.MainLabel.Text = NewUnitText;
        component.UnitDropDownUI.MainDropDown.Value = NewUnitText;
        component.has_error = false;
        component.error_message = "";
        component.current_unit_text = NewUnitText;
        component.unit_ui_style = "dropdown";

        return

      else
        % Case 4: Unit is not specified yet. Allow specifying one unit.
        % This branch is reachable only after the setup and before the first update.
        if component.unit_alias_specified
          assert(component.unit_ui_style == "alias")
        else
          try
            % Validate the provided string.
            simscape.Unit(NewUnitText);
          catch exception
            % In case of an error, it is a severe error and the app must exit because
            % the app is still not visible and there is no way to show
            % the error message in the app.
            component.has_error = true;
            component.error_message = exception.message;

            error(exception.message)

            return  % severe-error !todo: app must exit

          end  % try, catch
          if isempty(component.physical_value)
            component.physical_value = CodeUtil1.PhysicalValue(UnitText=NewUnitText);
          else
            component.physical_value.UnitText = NewUnitText;
          end  % if
          component.unit_ui_style = "label";
          component.UnitLabelUI.MainLabel.Text = NewUnitText;
          component.UnitDropDownUI.MainDropDown.Items = NewUnitText;
          component.UnitDropDownUI.MainDropDown.Value = NewUnitText;
          component.current_unit_text = NewUnitText;
        end  %if
        component.has_error = false;
        component.error_message = "";
        component.unit_specified = true;

        return

      end  % if
    end  % function

    % --------------------------------------------------------------------------
    % UnitAlias

    function str = get.UnitAlias(component)
      %%
      arguments (Output)
        str (1,1) string
      end  % arguments
      str = component.physical_value.UnitAlias;
    end  % function

    function set.UnitAlias(component, NewAliasString)
      %%
      arguments (Input)
        component
        NewAliasString (1,1) string
      end  % arguments
      % Allow changing the alias only if the unit is "1".
      if component.unit_specified && (component.physical_value.UnitText ~= "1")
        component.has_error = true;
        component.error_message = CodeUtil1.i18n("Unit alias is allowed only if the unit is ""1"".");

        return

      end  % if
      % Defining or modifying unit alias implies that the unit is "1".
      component.physical_value = CodeUtil1.PhysicalValue(UnitText="1", UnitAlias=NewAliasString);
      component.UnitLabelUI.MainLabel.Text = NewAliasString;
      component.unit_ui_style = "alias";
      component.unit_alias_specified = true;
      component.unit_specified = true;
    end  % function

  end  % methods

  methods (Access=private)

    function react_UnitUI_ValueChanged(component)
      %%
      % When this function starts, the items already has the new item.
      current_unit_items = component.UnitDropDownUI.MainDropDown.Items;
      new_unit_text = string(component.UnitDropDownUI.MainDropDown.Value);
      % The new unit must be commensurate with the existing units.
      if not(simscape.isCommensurateUnit(current_unit_items{:}))
        msg = CodeUtil1.i18n("New unit must be commensurate with existing units.");
        % Remove the new item.
        logical_index = (current_unit_items ~= new_unit_text);
        component.UnitDropDownUI.MainDropDown.Items = current_unit_items(logical_index);
        component.UnitDropDownUI.MainDropDown.Value = component.current_unit_text;

        if not(component.initialized)

          % The app is not visible yet. Show the error message in the Command Window.
          error(msg)  % severe-error !todo: app must exit

          return

        else
          % Inline error message hides the unit drop down UI, and the message can't be removed.
          % Thus, use a pop-up window.
          window_title = CodeUtil1.i18n("Error");
          uialert(component.MainFigure, msg, window_title)

          return

        end  % if
      end  % if
      component.has_error = false;
      component.error_message = "";
      component.physical_value.UnitText = new_unit_text;
      component.current_unit_text = new_unit_text;

      if not(isempty(component.UnitChangedCallback))
        component.UnitChangedCallback() 
      end  % if

      notify(component, "PhysicalUnitChanged")
      % Make sure to define PhysicalUnitChanged event.
    end  % function

  end  % methods
end  % classdef
