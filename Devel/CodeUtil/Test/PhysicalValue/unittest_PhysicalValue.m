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

  % Copyright 2025 The MathWorks, Inc.

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
      CodeUtil1.PhysicalValue;
    end  % function

    %% Tests

    function Test_Default_1(testcase)
      % Just create an object.
      x = CodeUtil1.PhysicalValue;
      verifyEqual(testcase, x.ValueText, "")
      verifyEqual(testcase, x.UnitText, "1")
      verifyEqual(testcase, x.SimscapeValue, simscape.Value(nan, "1"))
    end  % function

    % -------------------------------------------------------------------------

    function Test_UnitText_1(testcase)
      % Test UnitText.
      x = CodeUtil1.PhysicalValue(UnitText="s");
      verifyEqual(testcase, x.UnitText, "s")
      verifyEqual(testcase, x.SimscapeValue, simscape.Value(nan, "s"))
    end  % function

    % -------------------------------------------------------------------------

    function Test_UnitAlias_1(testcase)
      % Test UnitAlias.
      x = CodeUtil1.PhysicalValue(UnitAlias="%");
      verifyEqual(testcase, x.UnitAlias, "%")
    end  % function

    function Test_UnitAlias_2(testcase)
      % Test UnitAlias.
      x = CodeUtil1.PhysicalValue;
      x.UnitAlias = "alias";
      verifyEqual(testcase, x.UnitAlias, "alias")
    end  % function

    function Test_UnitAlias_3(testcase)
      % Test UnitAlias.
      x = CodeUtil1.PhysicalValue(UnitText="m");
      verifyError(testcase, @test_target, "PhysicalValue:setUnitAlias:UnitAliasIsNotAllowed")
      function test_target()
        x.UnitAlias = "alias";
      end  % nested function
    end  % function

    function Test_UnitAlias_4(testcase)
      % Test UnitAlias.
      x = CodeUtil1.PhysicalValue(UnitText="1");
      x.UnitAlias = "alias";
      verifyEqual(testcase, x.UnitAlias, "alias")
    end  % function

    % -------------------------------------------------------------------------

    function Test_ValueText_1_1(testcase)
      % Test ValueText.
      val = 2;
      x = CodeUtil1.PhysicalValue(ValueText=val);
      verifyEqual(testcase, x.SimscapeValue, simscape.Value(val))
    end  % function

    function Test_ValueText_1_2(testcase)
      % Test wrong ValueText.
      verifyError(testcase, @test_target, "PhysicalValue:processValueText:InvalidValueText")
      function test_target()
        x = CodeUtil1.PhysicalValue;
        % Illegal use of reserved keyword "try".
        x.ValueText = "try";  % !test-target
      end  % nested function
    end  % function

    function Test_ValueText_1_3(testcase)
      % Test wrong ValueText.
      verifyError(testcase, @test_target, "PhysicalValue:processValueText:InvalidValueText")
      function test_target()
        x = CodeUtil1.PhysicalValue;
        % Unrecognized function or variable 'dummy_variable_for_testing'.
        x.ValueText = "dummy_variable_for_testing";  % !test-target
      end  % nested function
    end  % function

    function Test_ValueText_1_4(testcase)
      % Test wrong ValueText.
      verifyError(testcase, @test_target, "PhysicalValue:processValueText:InvalidValueText")
      function test_target()
        x = CodeUtil1.PhysicalValue;
        % Error: This statement is incomplete.
        x.ValueText = "1-";  % !test-target
      end  % nested function
    end  % function

    function Test_ValueText_1_5(testcase)
      % Test ValueText.
      x = CodeUtil1.PhysicalValue;
      x.ValueText = "123";
      verifyEqual(testcase, x.ValueText, "123")
      verifyEqual(testcase, x.SimscapeValue, simscape.Value(123))
    end  % function

    function Test_ValueText_1_6(testcase)
      % Test ValueText.
      x = CodeUtil1.PhysicalValue;
      x.ValueText = "-12";  % !test-target
      verifyEqual(testcase, x.ValueText, "-12")
      verifyEqual(testcase, x.SimscapeValue, simscape.Value(-12))
    end  % function

    function Test_ValueText_2(testcase)
      % Test ValueText with an event listener.
      x = CodeUtil1.PhysicalValue;

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

    function Test_ValueText_3_1(testcase)
      % Test ValueText with simscape.Value.
      x = CodeUtil1.PhysicalValue(UnitText="m");
      x.ValueText = "simscape.Value(2, ""m"")";  % !test-target
      verifyEqual(testcase, x.ValueText, "simscape.Value(2, ""m"")")
      verifyEqual(testcase, x.SimscapeValue, simscape.Value(2, "m"))
    end  % function

    % -------------------------------------------------------------------------
    % Interaction with the base workspace.

    function Test_workspace_1(testcase)
      % The ValueText refers to a base workspace variable.
      % The variable is a simscape.Value object.
      % The unit is commensurate with the specified UnitText property.
      x = CodeUtil1.PhysicalValue(UnitText="m/s");
      assignin("base", "v", simscape.Value(5, "mph"))
      x.ValueText = "v";
      y = x.SimscapeValue;  % !test-target
      verifyEqual(testcase, y, simscape.Value(5, "mph"))
    end  % function

    function Test_workspace_2(testcase)
      % Specify a wrong unit.
      x = CodeUtil1.PhysicalValue(UnitText="m/s");
      assignin("base", "v", simscape.Value(5, "kg"))
      verifyError(testcase, @test_target, "PhysicalValue:processValueText:UnitIsNotCommensurate")
      function test_target
        x.ValueText = "v";  % !test-target
      end  % nested function
    end  % function

    function Test_workspace_3(testcase)
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

  end  % methods
end  % classdef
