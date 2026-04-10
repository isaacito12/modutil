classdef PhysicalUnitDropDown < AppUtil1.Component.ComponentBase
  % Editable drop-down UI component for Simscape physical unit

  % Copyright 2026 The MathWorks, Inc.

  properties (Constant)
    errorID (1,1) string = "PhysicalUnitDropDown:"
  end  % properties
  properties (Dependent)

    % UnitItems can be defined only once.
    % After it is defined, commensurate units can be added.
    UnitItems (1,:) string

    UnitText (1,1) string

  end  % properties
  properties

    EditableDropDownUI AppUtil1.Component.EditableDropDown

    ComponentHeight (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = AppUtil1.Constant.Height{"oneline++"}
    ComponentWidth (1,:) {CodeUtil1.mustBeTextOrPositiveNumber} = "1x"

    UnitChangedCallback {CodeUtil1.mustBeFunctionHandleOrEmpty} = []

  end  % properties
  properties
    has_error (1,1) logical = false
    error_message (1,1) string = ""
    Reporting (1,1) matlab.lang.OnOffSwitchState = "off"

    horizontal_container AppUtil1.HorizontalContainer

    initialized (1,1) logical = false
    unit_specified (1,1) logical = false

    % Valid unit text for error recovery
    current_unit_text (1,1) string = ""
  end  % properties

  events (HasCallbackProperty, NotifyAccess=protected)
    % PhysicalUnitChanged event adds PhysicalUnitChangedFcn property to this class.
    PhysicalUnitChanged
  end  % events

  methods (Access=protected)

    function setup(component)
      %%
      setup@AppUtil1.Component.ComponentBase(component)

      component.horizontal_container = AppUtil1.HorizontalContainer(component.base_grid);

      h_layout = addHorizontalGridLayout(component.horizontal_container);
      component.EditableDropDownUI = AppUtil1.Component.EditableDropDown(h_layout);
      component.EditableDropDownUI.MainFigure = component.MainFigure;
      component.EditableDropDownUI.ComponentWidth = component.ComponentWidth;
      component.EditableDropDownUI.ValueChangedCallback = @() react_DropDownUI_ValueChanged(component);
      % To avoid triggering UnitDropDownUI's callback, use MainDropDown's properties.
      component.EditableDropDownUI.MainDropDown.Items = "1";
      component.EditableDropDownUI.MainDropDown.Value = "1";
    end  % function

    function update(component)
      %%
      update@AppUtil1.Component.ComponentBase(component)

      if component.initialized
        regular_update(component)

        return

      end  % if

      first_update(component)

      component.initialized = true;
    end  % function

    function regular_update(component)
      %%
      component.horizontal_container.BaseGridLayout.RowHeight = component.ComponentHeight;

      component.EditableDropDownUI.ComponentWidth = component.ComponentWidth;
      component.EditableDropDownUI.ComponentHeight = component.ComponentHeight;

      if component.HighlightBackground
        component.EditableDropDownUI.HighlightBackground = "on";
        switch component.ThemeNameForBackGroundHighlight
          case "light"
            component.horizontal_container.BaseGridLayout.BackgroundColor = component.LightThemeBackGroundColor;
          case "dark"
            component.horizontal_container.BaseGridLayout.BackgroundColor = component.DarkThemeBackGroundColor;
        end  % switch
      end  % if
    end  % function

    function first_update(component)
      %%
      % This function is called only once after the setup finished and
      % public properties have been updated with the user-specified values.
      % Use this method to freeze property values based on the user-specified values.

      component.unit_specified = true;

    end  % function

  end  % methods

  methods

    % --------------------------------------------------------------------------
    % get and set for UnitItems

    function items = get.UnitItems(component)
      %%
      arguments (Output)
        items (1,:) string
      end  % arguments
      items = component.EditableDropDownUI.MainDropDown.Items;
    end  % function

    function set.UnitItems(component, items)
      %%
      % Unit items can be specified only once.
      arguments (Input)
        component
        items (1,:) string {CodeUtil1.mustBeAllCommensurateUnit}
      end  % arguments
      if component.initialized
        id = component.errorID + "UnitItemsAlreadyDefined";
        component.has_error = true;
        component.error_message = CodeUtil1.i18n("Unit items can be defined only once.");
        msg = component.error_message;

        throw(MException(id, msg))

      end  % if

      component.has_error = false;
      component.error_message = "";
      component.EditableDropDownUI.MainDropDown.Items = items;
      component.EditableDropDownUI.MainDropDown.Value = items(1);
      component.current_unit_text = items(1);
    end  % function

    % --------------------------------------------------------------------------
    % get and set for UnitText

    function unit_text = get.UnitText(component)
      %%
      arguments (Output)
        unit_text (1,1) string
      end  % arguments
      unit_text = component.EditableDropDownUI.MainDropDown.Value;
    end  % function

    function set.UnitText(component, NewUnitText)
      %%
      arguments (Input)
        component
        NewUnitText (1,1) string
      end  % arguments

      unit_items = component.UnitItems;

      % The new unit must be valid as simscape.Unit.
      try
        simscape.Unit(NewUnitText);
      catch exception
        msg = exception.message;

        if not(component.initialized)

          % The app is not visible yet. Show the error message in the Command Window.
          error(msg)  % severe-error !todo: app must exit

          return

        else
          component.has_error = true;
          window_title = CodeUtil1.i18n("Error");
          uialert(component.MainFigure, msg, window_title)

          % Remove the new item.
          logical_index = (unit_items ~= NewUnitText);
          component.EditableDropDownUI.MainDropDown.Items = unit_items(logical_index);
          component.EditableDropDownUI.MainDropDown.Value = component.current_unit_text;

          return

        end  % if
      end  % for

      if component.unit_specified
        if not(simscape.isCommensurateUnit(NewUnitText, unit_items{:}))
          component.has_error = true;
          component.error_message = CodeUtil1.i18n("New unit must be commensurate with the defined units.");

          if component.initialized
            component.has_error = true;
            window_title = CodeUtil1.i18n("Error");
            uialert(component.MainFigure, component.error_message, window_title)

            % Remove the new item.
            logical_index = (unit_items ~= NewUnitText);
            component.EditableDropDownUI.MainDropDown.Items = unit_items(logical_index);
            component.EditableDropDownUI.MainDropDown.Value = component.current_unit_text;

            return

          else
            % The app is not visible yet. Show the error message in the Command Window.
            error(component.error_message)  % severe-error !todo: app must exit

            return

          end  % if
        end  % if
        if not(ismember(NewUnitText, unit_items))
          component.EditableDropDownUI.MainDropDown.Items{end + 1} = char(NewUnitText);
        end  % if
        component.EditableDropDownUI.MainDropDown.Value = NewUnitText;

      else
        % Unit is not specified yet.
        % This branch is reachable only after the setup and before the first update.
        component.EditableDropDownUI.MainDropDown.Items = NewUnitText;
        component.EditableDropDownUI.MainDropDown.Value = NewUnitText;
      end  % if

      component.current_unit_text = NewUnitText;
      component.has_error = false;
      component.error_message = "";
      component.unit_specified = true;
    end  % function

  end  % methods

  methods (Access=private)

    function react_DropDownUI_ValueChanged(component)
      %%
      % When this function starts, the items in the drop down already contains the new item.
      new_unit_text = string(component.EditableDropDownUI.MainDropDown.Value);

      % This triggers set.UnitText where all the checks and updates are done.
      component.UnitText = new_unit_text;

      if not(isempty(component.UnitChangedCallback))
        component.UnitChangedCallback() 
      end  % if

      notify(component, "PhysicalUnitChanged")
      % Make sure to define PhysicalUnitChanged event.
    end  % function

  end  % methods
end  % classdef
