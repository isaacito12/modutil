classdef PhysicalValue < handle
  % A class for a simscape.Value object linked with a MATLAB expression and the base workspace.
  %
  % This class provides two major features.
  %
  % 1. Link between a PhysicalValue object and a base workspace variable
  % 2. Automatic interaction among multiple PhysicalValue objects
  %
  % See the demo_PhysicalValue*.m files for working code examples.
  %
  % This class is designed for use with uieditfield.
  % See the demoapp_PhysicalValue*.m for working app examples.

  % Copyright 2025 The MathWorks, Inc.

  properties (Constant, Access=private)
    classID (1,1) string = "PhysicalValue:"
  end  % properties

  % Make properties "set"-observable with event listeners.
  % See the documentation for the details.
  % Set Property Attributes to Enable Property Events
  % https://www.mathworks.com/help/matlab/matlab_oop/listening-for-changes-to-property-values.html#brkimdj-1
  properties (Dependent, SetObservable)

    % A textual representation of numeric data such as a scalar, a vector, a matrix,
    % or any MATLAB expression. The data type must be either double or simscape.Value.
    % If the data type is simscape.Value, the unit must be commensurate with the current unit.
    ValueText (1,1) string
  end  % properties

  properties

    % The type of ValueText is either double or simscape.Value.
    % ValueTextIsSimscapeValue is false if ValueText is of type double.
    ValueTextIsSimscapeValue (1,1) logical

  end  % properties

  properties (Dependent, SetObservable)

    % A textual representation of the unit of the data.
    % The unit must conform to the simscape.Unit.
    UnitText (1,1) string

  end  % properties

  properties (Dependent)

    % An alternative textual representation of the unit of the data.
    % This works only if the unit is "1".
    UnitAlias (1,1) string

  end  % properties

  % Make properties "get"-observable with event listeners.
  properties (Dependent, GetObservable)

    SimscapeValue simscape.Value

  end  % properties

  % States
  properties (Access=private)
    current_value_text (1,1) string = ""
    current_unit_text (1,1) string = "1"
    current_unit_alias (1,1) string = ""
    current_simscape_value simscape.Value = simscape.Value(nan, "1")
  end  % properties

  methods

    function pvalue = PhysicalValue(NameValuePair)
      %%
      arguments (Input)
        NameValuePair.UnitText string {mustBeScalarOrEmpty}
        NameValuePair.UnitAlias string {mustBeScalarOrEmpty}

        NameValuePair.ValueText (1,1) string = ""
      end  % arguments

      functionID = "PhysicalValue:";

      if not(isfield(NameValuePair, "UnitText"))
        % UnitText was not specified.
        pvalue.current_unit_text = "1";
      else
        % UnitText was specified.
        try
          % Check the validity of the unit.
          simscape.Unit(NameValuePair.UnitText);
        catch exception
          id = pvalue.classID + functionID + "InvalidUnitText";
          msg = CodeUtil1.i18n("Invalid UnitText: ") + exception.message;

          throw(MException(id, msg))

        end  % try, catch
        pvalue.current_unit_text = NameValuePair.UnitText;
      end  % if

      if isfield(NameValuePair, "UnitAlias")
        % This assignment triggers set.UnitAlias.
        pvalue.UnitAlias = NameValuePair.UnitAlias;
      end  % if

      pvalue.ValueText = NameValuePair.ValueText;
    end  % function

    function processValueText(pvalue, value_text)
      %%
      functionID = pvalue.classID + "processValueText:";
      if value_text == ""
        pvalue.current_simscape_value = simscape.Value(nan, pvalue.current_unit_text);

        return

      end  % if
      x = double(value_text);
      if not(isnan(x))
        % Value text was properly converted to a numeric value.
        pvalue.ValueTextIsSimscapeValue = false;
        pvalue.current_simscape_value = simscape.Value(x, pvalue.current_unit_text);
      else
        % Value text is not a numeric value.
        try
          result = CodeUtil1.getDoubleOrSimscapeValueFromText(value_text);
        catch exception
          id = functionID + "InvalidValueText";
          msg = CodeUtil1.i18n("Invalid ValueText: ") + exception.message;

          throw(MException(id, msg))

        end  % try, catch
        if isa(result, "double")
          pvalue.ValueTextIsSimscapeValue = false;
          % Do not modify pvalue.current_unit_text.
          pvalue.current_simscape_value = simscape.Value(result, pvalue.current_unit_text);
        else
          % The result is a simscape.Value object.
          % getDoubleOrSimscapeValueFromText returns either a double or a simscape.Value.
          % Other types are not returned.
          pvalue.ValueTextIsSimscapeValue = true;
          new_unit = unit(result);
          if not(simscape.isCommensurateUnit(new_unit, pvalue.current_unit_text))
            id = functionID + "UnitIsNotCommensurate";
            msg = CodeUtil1.i18n("Unit must be commensurate with the currently defined unit.");

            throw(MException(id, msg))

          end  % if
          pvalue.current_unit_text = new_unit;
          pvalue.current_simscape_value = result;
        end  % if
      end  % if
    end  % function

    function x = get.ValueText(pvalue)
      %%
      arguments (Output)
        x (1,1) string
      end  % arguments
      x = pvalue.current_value_text;
    end  % function

    function set.ValueText(pvalue, value_text)
      %%
      arguments (Input)
        pvalue
        value_text (1,1) string
      end  % arguments
      processValueText(pvalue, value_text)
      pvalue.current_value_text = value_text;
    end  % function

    function x = get.UnitText(pvalue)
      %%
      arguments (Output)
        x (1,1) string
      end  % arguments
      processValueText(pvalue, pvalue.current_value_text)
      x = pvalue.current_unit_text;
    end  % function

    function set.UnitText(pvalue, NewUnitText)
      %%
      arguments (Input)
        pvalue
        NewUnitText (1,1) string
      end  % arguments
      functionID = pvalue.classID + "setUnitText:";
      try
        % Check that the new unit text is valid as simscape.Unit.
        simscape.Unit(NewUnitText);
      catch exception
        id = functionID + "InvalidUnit";
        msg = CodeUtil1.i18n("Invalid unit: ") + exception.message;

        throw(MException(id, msg))

      end  % try, catch
      if not(simscape.isCommensurateUnit(NewUnitText, pvalue.current_unit_text))
        id = functionID + "UnitIsNotCommensurate";
        msg = CodeUtil1.i18n("New unit must be commensurate with the currently defined unit.");

        throw(MException(id, msg))

      end  % if
      pvalue.current_unit_text = NewUnitText;
      if pvalue.current_unit_text ~= "1"
        pvalue.current_unit_alias = "";
      end  % if
      pvalue.current_simscape_value = convert(pvalue.current_simscape_value, NewUnitText);
    end  % function

    function x = get.UnitAlias(pvalue)
      %%
      arguments (Output)
        x (1,1) string
      end  % arguments
      x = pvalue.current_unit_alias;
    end  % function

    function set.UnitAlias(pvalue, NewUnitAlias)
      %%
      arguments (Input)
        pvalue
        NewUnitAlias (1,1) string
      end  % arguments

      functionID = pvalue.classID + "setUnitAlias:";

      if pvalue.current_unit_text ~= "1"
        id = functionID + "UnitAliasIsNotAllowed";
        msg = CodeUtil1.i18n("Unit alias is allowed only if UnitText is ""1"".");

        throw(MException(id, msg))

      end  % if
      pvalue.current_unit_alias = NewUnitAlias;
    end  % function

    function x = get.SimscapeValue(pvalue)
      %%
      arguments (Output)
        x simscape.Value
      end  % arguments
      processValueText(pvalue, pvalue.current_value_text)
      x = pvalue.current_simscape_value;
    end  % function

    function set.SimscapeValue(pvalue, x)
      %%
      arguments (Input)
        pvalue
        x simscape.Value
      end  % arguments
      pvalue.ValueText = CodeUtil1.stringify(value(x));
      pvalue.UnitText = unit(x);
    end  % function

  end  % methods
end  % classdef
