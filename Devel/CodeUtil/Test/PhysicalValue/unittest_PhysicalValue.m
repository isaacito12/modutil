classdef unittest_PhysicalValue < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2025-2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in this section always run before each test defined in the Test section runs.

    function test_method_setup_1(testcase)
      function closeAll
        close all
        bdclose all
      end  % nested function
      closeAll
      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAll)
    end  % function

  end  % methods

  methods (Test)
    % Functions in this "Test" section are the tests.
    % Before each function in this section runs, functions defined in the TestMethodSetup section run.

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    function PassingTest_1(~)
      % Just create an object.
      CodeUtil1.PhysicalValue;
    end  % function

    function Test_Default_1(testcase)
      % Creating a default PhysicalValue object does not initialize the internal states.
      physval = CodeUtil1.PhysicalValue;
      verifyFalse(testcase, physval.initialized)
    end  % function

    % -------------------------------------------------------------------------
    % Test set.SimscapeValue.

    function set_SimscapeValue_Initialization_1(testcase)
      % Assigning a simscape.Value object to SimscapeValue must initialize the physval's states.
      physval = CodeUtil1.PhysicalValue;
      verifyFalse(testcase, physval.initialized)
      physval.SimscapeValue = simscape.Value(2);  % !test-target
      verifyTrue(testcase, physval.initialized)
    end  % function

    function set_SimscapeValue_PassingTest_1(~)
      physval = CodeUtil1.PhysicalValue;
      physval.SimscapeValue = simscape.Value([2 4 6]);
      physval.SimscapeValue = simscape.Value(ones(3,3));
    end  % function

    function set_SimscapeValue_PassingTest_2(~)
      physval = CodeUtil1.PhysicalValue;
      physval.SimscapeValue = simscape.Value(2, "m/s");
      physval.SimscapeValue = simscape.Value(-34, "mph");
    end  % function

    function set_SimscapeValue_Error_1(testcase)
      physval = CodeUtil1.PhysicalValue;
      physval.SimscapeValue = simscape.Value(2, "g");
      verifyError(testcase, @test_target, "PhysicalValue:set_SimscapeValue:UnitIsNotCommensurate")
      function test_target
        % Use unit which is not commensurate with the current unit.
        physval.SimscapeValue = simscape.Value(0.1, "m");
      end  % nested function
    end  % function

    function set_SimscapeValue_Error_2(testcase)
      physval = CodeUtil1.PhysicalValue(UnitAlias="\%");
      verifyError(testcase, @test_target, "PhysicalValue:set_SimscapeValue:UnitIsNotCompatibleWithAlias")
      function test_target
        % Use unit which is not "1".
        physval.SimscapeValue = simscape.Value(0.1, "m");
      end  % nested function
    end  % function

    % -------------------------------------------------------------------------
    % Test get.SimscapeValue.

    function get_SimscapeValue_Test_1(testcase)
      physval = CodeUtil1.PhysicalValue;
      physval.SimscapeValue = simscape.Value([2 4 6]);
      actual = physval.SimscapeValue;
      verifyEqual(testcase, actual, simscape.Value([2 4 6]))
    end  % function

    function get_SimscapeValue_Test_2(testcase)
      physval = CodeUtil1.PhysicalValue;
      % Get SimscapeValue when physval is not initialized.
      actual = physval.SimscapeValue;
      verifyEqual(testcase, actual, simscape.Value(nan))
    end  % function

    % -------------------------------------------------------------------------
    % Test set.ValueText.
    % set.ValueText calls processValueText, which does heavy lifting to handle
    % all possible texts.

    function set_ValueText_initialization_1(testcase)
      % Specifying ValueText must initialize the object.
      physval = CodeUtil1.PhysicalValue;
      verifyFalse(testcase, physval.initialized)
      physval.ValueText = "3.1";
      verifyTrue(testcase, physval.initialized)
    end  % function

    function set_ValueText_test_1(testcase)
      physval = CodeUtil1.PhysicalValue;

      physval.ValueText = "-sqrt(4)";
      % Directly get current_simscape_value to avoid any side effects.
      sscval = physval.current_simscape_value;
      verifyEqual(testcase, value(sscval), -2)
      verifyEqual(testcase, string(unit(sscval)), "1")

      physval.ValueText = "[2 3 4]";
      sscval = physval.current_simscape_value;
      verifyEqual(testcase, value(sscval), [2, 3, 4])
      verifyEqual(testcase, string(unit(sscval)), "1")

      % Reset using "". The value becomes nan. Unit remains unchanged.
      physval.ValueText = "";
      sscval = physval.current_simscape_value;
      verifyEqual(testcase, value(sscval), nan)
      verifyEqual(testcase, string(unit(sscval)), "1")
    end  % function

    function set_ValueText_test_2(testcase)
      physval = CodeUtil1.PhysicalValue;

      physval.ValueText = "simscape.Value(-0.1)";
      % Directly get current_simscape_value to avoid any side effects.
      sscval = physval.current_simscape_value;
      verifyEqual(testcase, value(sscval), -0.1)
      verifyEqual(testcase, string(unit(sscval)), "1")

      % Reset using "". The value becomes nan. Unit remains unchanged.
      physval.ValueText = "";
      sscval = physval.current_simscape_value;
      verifyEqual(testcase, value(sscval), nan)
      verifyEqual(testcase, string(unit(sscval)), "1")
    end  % function

    function set_ValueText_test_3(testcase)
      physval = CodeUtil1.PhysicalValue;

      physval.ValueText = "simscape.Value(4, ""N*m"")";
      % Directly get current_simscape_value to avoid any side effects.
      sscval = physval.current_simscape_value;
      verifyEqual(testcase, value(sscval), 4)
      verifyEqual(testcase, string(unit(sscval)), "N*m")

      % Reset using "". The value becomes nan. Unit remains unchanged.
      physval.ValueText = "";
      sscval = physval.current_simscape_value;
      verifyEqual(testcase, value(sscval), nan)
      verifyEqual(testcase, string(unit(sscval)), "N*m")
    end  % function

    function set_ValueText_constructor_1(testcase)
      % Use constructor options.
      physval = CodeUtil1.PhysicalValue(ValueText="simscape.Value(4, ""N*m"")");
      % Directly get current_simscape_value to avoid any side effects.
      sscval = physval.current_simscape_value;
      verifyEqual(testcase, value(sscval), 4)
      verifyEqual(testcase, string(unit(sscval)), "N*m")
    end  % function

    function set_ValueText_error_1(testcase)
      physval = CodeUtil1.PhysicalValue;
      physval.ValueText = "simscape.Value(2, ""g"")";
      verifyError(testcase, @test_target, "PhysicalValue:processValueText:UnitIsNotCommensurate")
      function test_target
        % Use unit which is not commensurate with the current unit.
        physval.ValueText = "simscape.Value(5, ""s"")";
      end  % nested function
    end  % function

    % -------------------------------------------------------------------------
    % Test set.UnitText.

    function set_UnitText_Initialization_1(testcase)
      % Specifying UnitText initializes the object.
      physval = CodeUtil1.PhysicalValue;
      verifyFalse(testcase, physval.initialized)
      physval.UnitText = "N";
      verifyTrue(testcase, physval.initialized)
    end  % function

    function set_UnitText_PassingTest_1(~)
      physval = CodeUtil1.PhysicalValue;
      physval.UnitText = "m";
      physval.UnitText = "in";
    end  % function

    function set_UnitText_ErrorTest_1(testcase)
      physval = CodeUtil1.PhysicalValue;
      verifyError(testcase, @test_target, "PhysicalValue:set_UnitText:InvalidUnit")
      function test_target
        % Specify a text which is invalid for simscape.Unit.
        physval.UnitText = "dummy";
      end  % nested function
    end  % function

    function set_UnitText_ErrorTest_2(testcase)
      physval = CodeUtil1.PhysicalValue;
      physval.UnitText = "g";
      verifyError(testcase, @test_target, "PhysicalValue:set_UnitText:UnitIsNotCommensurate")
      function test_target
        % Specify unit which is not commensurate with the current unit.
        physval.UnitText = "s";
      end  % nested function
    end  % function

    % -------------------------------------------------------------------------
    % Test constructor options.
    %
    % Function name contains the ID corresponding to the reporting in the code.
    % For example, the constructor_2_1_error test corresponds to the "2.1:error" report from the code.
    % The Reporting property in the PhysicalValue class must be set to "on" to see the reporting.

    function constructor_1_ok(testcase)
      physval = CodeUtil1.PhysicalValue(UnitText="", UnitAlias="", ValueText="");
      verifyFalse(testcase, physval.initialized)
    end  % function

    function constructor_2_1_error(testcase)
      verifyError(testcase, @test_target, "PhysicalValue:PhysicalValue:InvalidUnitTextForUnitAlias")
      function test_target
        CodeUtil1.PhysicalValue(UnitText="s", UnitAlias="\%", ValueText="3");
      end  % function
    end  % function

    function constructor_2_2_ok(testcase)
      physval = CodeUtil1.PhysicalValue(UnitText="1", UnitAlias="\%", ValueText="");
      verifyTrue(testcase, physval.initialized)
    end  % function

    function constructor_2_3_error(testcase)
      verifyError(testcase, @test_target, "PhysicalValue:processValueText:InvalidValueText")
      function test_target
        CodeUtil1.PhysicalValue(UnitText="1", UnitAlias="\%", ValueText="dummy");
      end  % function
    end  % function

    function constructor_2_4_ok(testcase)
      physval = CodeUtil1.PhysicalValue(UnitText="1", UnitAlias="\%", ValueText="5");
      verifyTrue(testcase, physval.initialized)
    end  % function

    function constructor_3_ok(testcase)
      physval = CodeUtil1.PhysicalValue(UnitText="s", UnitAlias="", ValueText="");
      verifyTrue(testcase, physval.initialized)
    end  % function

    function constructor_4_ok(testcase)
      physval = CodeUtil1.PhysicalValue(UnitText="", UnitAlias="\%", ValueText="");
      verifyTrue(testcase, physval.initialized)
    end  % function

    function constructor_5_ok(testcase)
      physval = CodeUtil1.PhysicalValue(UnitText="", UnitAlias="", ValueText="simscape.Value(-2.1, ""N"")");
      verifyTrue(testcase, physval.initialized)
    end  % function

    function constructor_6_1_error(testcase)
      verifyError(testcase, @test_target, "PhysicalValue:processValueText:InvalidValueText")
      function test_target
        CodeUtil1.PhysicalValue(UnitText="1", UnitAlias="", ValueText="dummy");
      end  % function
    end  % function

    function constructor_6_2_ok(testcase)
      physval = CodeUtil1.PhysicalValue(UnitText="1", UnitAlias="", ValueText="simscape.Value(-2.1, ""1"")");
      verifyTrue(testcase, physval.initialized)
    end  % function

    function constructor_7_1_error(testcase)
      verifyError(testcase, @test_target, "PhysicalValue:processValueText:InvalidValueText")
      function test_target
        CodeUtil1.PhysicalValue(UnitText="", UnitAlias="\%", ValueText="dummy");
      end  % function
    end  % function

    function constructor_7_2_ok(testcase)
      physval = CodeUtil1.PhysicalValue(UnitText="", UnitAlias="\%", ValueText="simscape.Value(-2.1, ""1"")");
      verifyTrue(testcase, physval.initialized)
    end  % function

    % -------------------------------------------------------------------------
    % Test get.ValueText
    % ValueText keeps the user-specified text.
    % The internal simscape.Value object may have a different representation of the value.
    % For example, ValueText="1 : 2 : 5" is evaluated to [1, 3, 5] internally.

    function get_ValueText_Test_1(testcase)
      physval = CodeUtil1.PhysicalValue;
      physval.ValueText = "[2, 3]";
      actual = physval.ValueText;
      verifyEqual(testcase, actual, "[2, 3]")
    end  % function

    function get_ValueText_Test_2(testcase)
      physval = CodeUtil1.PhysicalValue(ValueText="1 : 2 : 5");
      actual = physval.ValueText;
      verifyEqual(testcase, actual, "1 : 2 : 5")
    end  % function

    % -------------------------------------------------------------------------
    % Test get.UnitText

    function get_UnitText_Test_1(testcase)
      physval = CodeUtil1.PhysicalValue;
      physval.ValueText = "[3, 4, 5]";
      actual = physval.UnitText;
      verifyEqual(testcase, actual, "1")
    end  % function

    function get_UnitText_Test_2(testcase)
      physval = CodeUtil1.PhysicalValue(UnitText="N*m");
      physval.ValueText = "[3, 4, 5]";
      actual = physval.UnitText;
      verifyEqual(testcase, actual, "N*m")
    end  % function

    % -------------------------------------------------------------------------
    % Test set.UnitAlias

    function set_UnitAlias_Test_1(testcase)
      physval = CodeUtil1.PhysicalValue;
      physval.UnitAlias = "alias";
      % Access current_unit_alias to avoid triggering get.UnitAlias.
      actual = physval.current_unit_alias;
      verifyEqual(testcase, actual, "alias")
    end  % function

    function set_UnitAlias_Test_2(testcase)
      physval = CodeUtil1.PhysicalValue(UnitAlias="\%");
      % Access current_unit_alias to avoid triggering get.UnitAlias.
      actual = physval.current_unit_alias;
      verifyEqual(testcase, actual, "\%")
    end  % function

    function Test_UnitAlias_3(testcase)
      x = CodeUtil1.PhysicalValue(UnitText="m");
      verifyError(testcase, @test_target, "PhysicalValue:set_UnitAlias:UnitAliasIsNotAllowed")
      function test_target()
        % If unit is defined and is not "1", alias is not allowed.
        x.UnitAlias = "alias";
      end  % nested function
    end  % function

    % -------------------------------------------------------------------------
    % Test get.UnitAlias

    function get_UnitAlias_Test_1(testcase)
      physval = CodeUtil1.PhysicalValue(UnitAlias="\%");
      % This triggers get.UnitAlias.
      actual = physval.UnitAlias;  % !test-target
      verifyEqual(testcase, actual, "\%")
    end  % function

    % -------------------------------------------------------------------------
    % Test event listener.

    function EventListner_1(testcase)
      % Test ValueText with an event listener.
      x = CodeUtil1.PhysicalValue(UnitText="1");

      k = 1;

      addlistener(x, "ValueText", "PostSet", @(src,evnt) react());  % !test-target

      function react()
        k = k + 1;
      end  % nested function

      verifyEqual(testcase, k, 1)

      x.ValueText = "pi";  % !test-target
      verifyEqual(testcase, k, 2)

      x.ValueText = "-12";  % !test-target
      verifyEqual(testcase, k, 3)

      verifyEqual(testcase, x.ValueText, "-12")
      verifyEqual(testcase, x.SimscapeValue, simscape.Value(-12))
    end  % function

    % -------------------------------------------------------------------------
    % Test interaction with the base workspace.

    function BaseWorkspace_1(testcase)
      % The ValueText refers to a base workspace variable.
      % The variable is a simscape.Value object.
      % The unit is commensurate with the specified UnitText property.
      x = CodeUtil1.PhysicalValue(UnitText="m/s");
      assignin("base", "v", simscape.Value(5, "mph"))
      x.ValueText = "v";
      y = x.SimscapeValue;  % !test-target
      verifyEqual(testcase, y, simscape.Value(5, "mph"))
    end  % function

    function BaseWorkspace_2(testcase)
      % Specify a wrong unit.
      x = CodeUtil1.PhysicalValue(UnitText="m/s");
      assignin("base", "v", simscape.Value(5, "kg"))
      verifyError(testcase, @test_target, "PhysicalValue:processValueText:UnitIsNotCommensurate")
      function test_target
        x.ValueText = "v";  % !test-target
      end  % nested function
    end  % function

    function BaseWorkspace_3(testcase)
      % Test the "workspace variables and derived parameters" scenario.
      % c is derived from a and b.
      % a and b refer to variables in the base workspace.

      pv_a = CodeUtil1.PhysicalValue(ValueText="1", UnitText="mm");
      pv_b = CodeUtil1.PhysicalValue(ValueText="1", UnitText="cm");

      % Derived
      pv_c = CodeUtil1.PhysicalValue(UnitText="m^2");

      addlistener(pv_a, "ValueText", "PostSet", @(src,evt) update_c_value(pv_a,pv_b,pv_c));
      addlistener(pv_a, "UnitText", "PostSet", @(src,evt) update_c_value(pv_a,pv_b,pv_c));

      addlistener(pv_b, "ValueText", "PostSet", @(src,evt) update_c_value(pv_a,pv_b,pv_c));
      addlistener(pv_b, "UnitText", "PostSet", @(src,evt) update_c_value(pv_a,pv_b,pv_c));

      addlistener(pv_c, "SimscapeValue", "PreGet", @(src, evt) update_c_value(pv_a,pv_b,pv_c));

      function update_c_value(pv_a, pv_b, pv_c)
        a = pv_a.SimscapeValue;
        b = pv_b.SimscapeValue;
        % Derive c from a and b.
        c = a * b;
        pv_c.ValueText = value(c);
        pv_c.UnitText = unit(c);
      end  % nested function

      evalin("base", "param1 = struct;")
      evalin("base", "param1.L1 = simscape.Value(2, ""in"");")
      evalin("base", "param1.L2 = simscape.Value(3, ""in"");")

      pv_a.ValueText = "param1.L1";
      pv_b.ValueText = "param1.L2";

      verifyEqual(testcase, pv_c.SimscapeValue, simscape.Value(6, "in^2"))

      evalin("base", "param1.L2 = simscape.Value(4, ""in"");")

      verifyEqual(testcase, pv_c.SimscapeValue, simscape.Value(8, "in^2"))

    end  % function

    % -------------------------------------------------------------------------
    % Test demo scripts.

    function DemoScript_PassingTest_1(~)
      DemoScript_PhysicalValue_1_basics
    end  % function

    function DemoScript_PassingTest_2(~)
      evalin("base", "DemoScript_PhysicalValue_2_workspace")
    end  % function

    function DemoScript_PassingTest_3(~)
      evalin("base", "DemoScript_PhysicalValue_3_listener")
    end  % function

  end  % methods
end  % classdef
