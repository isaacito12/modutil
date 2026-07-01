classdef unittest_mustBeSimscapeValueNonnegativeOrNan < matlab.unittest.TestCase
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

    function PassingTest_1(~)
      mus1.CodeUtil.mustBeSimscapeValueNonnegativeOrNan(simscape.Value(0))  % !test-target
    end  % function

    function PassingTest_2(~)
      mus1.CodeUtil.mustBeSimscapeValueNonnegativeOrNan(simscape.Value(0.1))  % !test-target
    end  % function

    function PassingTest_3(~)
      mus1.CodeUtil.mustBeSimscapeValueNonnegativeOrNan(simscape.Value(nan))  % !test-target
    end  % function

    function Test_1(testcase)
      verifyError(testcase, @() test_target, "mustBeSimscapeValueNonnegativeOrNan:InvalidType")
      function test_target
        mus1.CodeUtil.mustBeSimscapeValueNonnegativeOrNan(0.1)  % !test-target
      end  % nested function
    end  % function

    function Test_2(testcase)
      verifyError(testcase, @() test_target, "mustBeSimscapeValueNonnegativeOrNan:InvalidValue")
      function test_target
        mus1.CodeUtil.mustBeSimscapeValueNonnegativeOrNan(simscape.Value(-0.1))  % !test-target
      end  % nested function
    end  % function

  end  % methods

end  % classdef
