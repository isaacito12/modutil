classdef DoubleValue < handle
  % A class for a variable of type double linked with an expression and the base workspace.
  %
  % This class provides two major features.
  %
  % 1. Link a DoubleValue object with a base workspace variable
  % 2. Automatic interaction among multiple DoubleValue objects
  %
  % See the demo_DoubleValue*.m files for working code examples.
  %
  % This class is designed for use with uieditfield.
  % See the demoapp_DoubleValue*.m for working app examples.

  % Copyright 2025 The MathWorks, Inc.

  properties (Constant, Access=private)
    classID (1,1) string = "DoubleValue:"
  end  % properties

  % Make properties "set"-observable with event listeners.
  % See the documentation for the details.
  % Set Property Attributes to Enable Property Events
  % https://www.mathworks.com/help/matlab/matlab_oop/listening-for-changes-to-property-values.html#brkimdj-1
  properties (Dependent, SetObservable)

    % A textual representation of numeric data such as a scalar, a vector, a matrix,
    % or any MATLAB expression. The data type must be double.
    ValueText (1,1) string

  end  % properties

  % Make properties "get"-observable with event listeners.
  properties (Dependent, GetObservable)

    MainDoubleValue {mustBeA(MainDoubleValue, "double")}

  end  % properties

  % States
  properties (Access=private)
    current_value_text (1,1) string = ""
    current_data_value {mustBeA(current_data_value, "double")} = nan
  end  % properties

  methods

    function doubleValueObject = DoubleValue(NameValuePair)
      %%
      arguments (Input)
        NameValuePair.ValueText (1,1) string = ""
      end  % arguments
      doubleValueObject.ValueText = NameValuePair.ValueText;
    end  % function

    function processValueText(doubleValueObject, value_text)
      %%
      functionID = doubleValueObject.classID + "processValueText:";
      if value_text == ""
        doubleValueObject.current_data_value = nan;

        return

      end  % if
      x = double(value_text);
      if not(isnan(x))
        % Value text was properly converted to a numeric value.
        doubleValueObject.current_data_value = x;
      else
        % Value text is not a scalar double value.
        try
          result = evalin("base", value_text);
        catch exception
          id = functionID + "InvalidValueText";
          msg = CodeUtil1.i18n("Invalid ValueText: ") + exception.message;

          throw(MException(id, msg))

        end  % try, catch
        if not(isa(result, "double"))
          % The result data type is not double.
          id = functionID + "InvalidDataType";
          msg = CodeUtil1.i18n("ValueText must evaluate to double.");

          throw(MException(id, msg))

        end  % if
        doubleValueObject.current_data_value = result;
      end  % if
    end  % function

    function x = get.ValueText(doubleValueObject)
      %%
      arguments (Output)
        x (1,1) string
      end  % arguments
      x = doubleValueObject.current_value_text;
    end  % function

    function set.ValueText(doubleValueObject, value_text)
      %%
      arguments (Input)
        doubleValueObject
        value_text (1,1) string
      end  % arguments
      processValueText(doubleValueObject, value_text)
      doubleValueObject.current_value_text = value_text;
    end  % function

    function x = get.MainDoubleValue(doubleValueObject)
      %%
      arguments (Output)
        x double
      end  % arguments
      processValueText(doubleValueObject, doubleValueObject.current_value_text)
      x = doubleValueObject.current_data_value;
    end  % function

    function set.MainDoubleValue(doubleValueObject, x)
      %%
      arguments (Input)
        doubleValueObject
        x double
      end  % arguments
      doubleValueObject.current_data_value = x;
      doubleValueObject.current_value_text = CodeUtil1.stringify(x);
    end  % function

  end  % methods
end  % classdef
