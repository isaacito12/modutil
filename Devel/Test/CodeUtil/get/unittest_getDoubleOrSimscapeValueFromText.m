classdef unittest_getDoubleOrSimscapeValueFromText < matlab.unittest.TestCase
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
      mus1.CodeUtil.getDoubleOrSimscapeValueFromText;
    end  % function

    %% Tests

    function Test_default_1(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText;
      verifyEqual(testcase, x, nan)
    end  % function

    function Test_empty_text_1(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("");
      verifyEqual(testcase, x, nan)
    end  % function

    function Test_empty_text_2(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText(" ");
      verifyEqual(testcase, x, nan)
    end  % function

    % -------------------------------------------------------------------------

    function Test_MaxTextLength_1(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("1", MaxTextLength=1);
      verifyEqual(testcase, x, 1)
    end  % function

    function Test_MaxTextLength_2(testcase)
      verifyError(testcase, @test_target, "getDoubleOrSimscapeValueFromText:TextIsTooLong")
      function test_target()
        mus1.CodeUtil.getDoubleOrSimscapeValueFromText("12", MaxTextLength=1);  % !test-target
      end  % nested function
    end  % function

    function Test_MaxTextLength_3(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("12345", MaxTextLength=5);
      verifyEqual(testcase, x, 12345)
    end  % function

    function Test_MaxTextLength_4(testcase)
      verifyError(testcase, @test_target, "getDoubleOrSimscapeValueFromText:TextIsTooLong")
      function test_target()
        mus1.CodeUtil.getDoubleOrSimscapeValueFromText("123456", MaxTextLength=5);  % !test-target
      end  % nested function
    end  % function

    % -------------------------------------------------------------------------

    function Test_simscapeValue_1(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("simscape.Value");
      verifyEqual(testcase, x, simscape.Value)
    end  % function

    function Test_simscapeValue_2(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("simscape.Value(2, ""s"")");
      verifyEqual(testcase, x, simscape.Value(2, "s"))
    end  % function

    function Test_simscapeValue_3(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("simscape.Value([2 4 6], ""m/s"")");
      verifyEqual(testcase, x, simscape.Value([2 4 6], "m/s"))
    end  % function

    % -------------------------------------------------------------------------

    function Test_double_1(testcase)
      verifyEqual(testcase, double("1.2"), 1.2)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("1.2");
      verifyEqual(testcase, x, 1.2)
    end  % function

    % -------------------------------------------------------------------------

    function Test_evaluated_1(testcase)
      % Calling double("pi") returns nan, but getDoubleOrSimscapeValueFromText evaluates
      % if the double function returns nan.
      verifyEqual(testcase, double("pi"), nan)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("pi");
      verifyEqual(testcase, x, pi)
    end  % function

    function Test_evaluated_2(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("1 + 1");
      verifyEqual(testcase, x, 2)
    end  % function

    function Test_evaluated_3(testcase)
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("[1, sqrt(4)].^2");
      verifyEqual(testcase, x, [1, 4])
    end  % function

    % -------------------------------------------------------------------------

    function Test_workspace_1(testcase)
      evalin("base", "test_base_workspace = struct;")
      evalin("base", "test_base_workspace.a = 1;")
      x = mus1.CodeUtil.getDoubleOrSimscapeValueFromText("test_base_workspace.a");
      verifyEqual(testcase, x, 1)
      evalin("base", "clear test_base_workspace")
    end  % function

  end  % methods
end  % classdef
