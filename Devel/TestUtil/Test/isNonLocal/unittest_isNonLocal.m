classdef unittest_isNonLocal < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2026 The MathWorks, Inc.

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

    % Error cases

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "MATLAB:minrhs")
      function test_target
        TestUtil1.isNonLocal
      end  % nested function
    end  % function

    % Tests

    function Test_1(testcase)
      actual = TestUtil1.isNonLocal("");
      verifyFalse(testcase, actual)
    end  % function

    function Test_2(testcase)
      LocalTopFolder = "C:\local";
      actual = TestUtil1.isNonLocal(LocalTopFolder);
      if startsWith(pwd, "C:\local")
        verifyFalse(testcase, actual)
      else
        verifyTrue(testcase, actual)
      end  % if
    end  % function

    function Test_3(testcase)
      % Test a pattern.
      LocalTopFolder = ("dummy1:\dummy2" | "dummy3:\dummy4");
      actual = TestUtil1.isNonLocal(LocalTopFolder);
      verifyTrue(testcase, actual)
    end  % function

  end  % methods
end  % classdef
