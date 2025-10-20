classdef unittest_DoubleValue < matlab.unittest.TestCase
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
      CodeUtil1.DoubleValue;
    end  % function

    function PassingTest_2(~)
      demo_DoubleValue_1_basics
    end  % function

    function PassingTest_3(~)
      evalin("base", "demo_DoubleValue_2_workspace")
    end  % function

    function PassingTest_4(~)
      evalin("base", "demo_DoubleValue_3_watch")
    end  % function

    %% Tests

    function Test_Default_1(testcase)
      % Just create an object.
      x = CodeUtil1.DoubleValue;
      verifyEqual(testcase, x.ValueText, "")
      verifyEqual(testcase, x.MainDoubleValue, nan)
    end  % function

    % -------------------------------------------------------------------------

    function Test_ValueText_1_1(testcase)
      % Test ValueText.
      val = 2;
      x = CodeUtil1.DoubleValue(ValueText=val);
      verifyEqual(testcase, x.MainDoubleValue, val)
    end  % function

    function Test_ValueText_1_2(testcase)
      % Test wrong ValueText.
      verifyError(testcase, @test_target, "DoubleValue:processValueText:InvalidValueText")
      function test_target()
        x = CodeUtil1.DoubleValue;
        % Illegal use of reserved keyword "try".
        x.ValueText = "try";  % !test-target
      end  % nested function
    end  % function

    function Test_ValueText_1_3(testcase)
      % Test wrong ValueText.
      verifyError(testcase, @test_target, "DoubleValue:processValueText:InvalidValueText")
      function test_target()
        x = CodeUtil1.DoubleValue;
        % Unrecognized function or variable 'dummy_variable_for_testing'.
        x.ValueText = "dummy_variable_for_testing";  % !test-target
      end  % nested function
    end  % function

    function Test_ValueText_1_4(testcase)
      % Test wrong ValueText.
      verifyError(testcase, @test_target, "DoubleValue:processValueText:InvalidValueText")
      function test_target()
        x = CodeUtil1.DoubleValue;
        % Error: This statement is incomplete.
        x.ValueText = "1-";  % !test-target
      end  % nested function
    end  % function

    function Test_ValueText_1_5(testcase)
      % Test ValueText.
      x = CodeUtil1.DoubleValue;
      x.ValueText = "123";
      verifyEqual(testcase, x.ValueText, "123")
      verifyEqual(testcase, x.MainDoubleValue, 123)
    end  % function

    function Test_ValueText_1_6(testcase)
      % Test ValueText.
      x = CodeUtil1.DoubleValue;
      x.ValueText = "-12";  % !test-target
      verifyEqual(testcase, x.ValueText, "-12")
      verifyEqual(testcase, x.MainDoubleValue, -12)
    end  % function

    function Test_ValueText_2(testcase)
      % Test ValueText with an event listener.
      x = CodeUtil1.DoubleValue;

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
      verifyEqual(testcase, x.MainDoubleValue, -12)
    end  % function

    function Test_ValueText_3_1(testcase)
      % Test ValueText with a double value.
      x = CodeUtil1.DoubleValue;
      x.ValueText = "2";  % !test-target
      verifyEqual(testcase, x.ValueText, "2")
      verifyEqual(testcase, x.MainDoubleValue, 2)
    end  % function

    % -------------------------------------------------------------------------
    % Interaction with the base workspace.

    function Test_workspace_1(testcase)
      % The ValueText refers to a base workspace variable.
      % The workspace variable is a double value.
      x = CodeUtil1.DoubleValue;
      assignin("base", "v", 5)
      x.ValueText = "v";
      y = x.MainDoubleValue;  % !test-target
      verifyEqual(testcase, y, 5)
    end  % function

    function Test_workspace_2(testcase)
      % Test the "workspace variables and derived parameters" scenario.
      % c is derived from a and b.
      % a and b refer to variables in the base workspace.

      dv_a = CodeUtil1.DoubleValue;
      dv_b = CodeUtil1.DoubleValue;
      dv_c = CodeUtil1.DoubleValue;

      addlistener(dv_a, "ValueText", "PostSet", @(src,evt) update_c_value(dv_a,dv_b,dv_c));
      addlistener(dv_b, "ValueText", "PostSet", @(src,evt) update_c_value(dv_a,dv_b,dv_c));

      addlistener(dv_c, "MainDoubleValue", "PreGet", @(src, evt) update_c_value(dv_a,dv_b,dv_c));

      function update_c_value(dv_a, dv_b, dv_c)
        a = dv_a.MainDoubleValue;
        b = dv_b.MainDoubleValue;
        % Derive c from a and b.
        c = a * b;
        dv_c.MainDoubleValue = c;
      end  % nested function

      evalin("base", "param1 = struct;")
      evalin("base", "param1.L1 = 2;")
      evalin("base", "param1.L2 = 3;")

      dv_a.ValueText = "param1.L1";
      dv_b.ValueText = "param1.L2";

      verifyEqual(testcase, dv_c.MainDoubleValue, 6)

      evalin("base", "param1.L2 = 4;")

      verifyEqual(testcase, dv_c.MainDoubleValue, 8)

    end  % function

  end  % methods
end  % classdef
