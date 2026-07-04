classdef unittest_getModelFileFullPath < matlab.unittest.TestCase
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

    % Error cases

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "MATLAB:minrhs")
      function test_target
        mus1.ModelUtil.getModelFileFullPath
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target, "getModelFileFullPath:InvalidModelName")
      function test_target
        mus1.ModelUtil.getModelFileFullPath("")
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @() test_target, "getModelFileFullPath:ModelFileNotFound")
      function test_target
        mus1.ModelUtil.getModelFileFullPath("test-test-test")
      end  % nested function
    end  % function

    function Test_error_4(testcase)
      % This error is issued by getFileFullPath, not getModelFileFullPath.
      verifyError(testcase, @() test_target, "getFileFullPath:TwoOrMoreMatches")
      function test_target
        mus1.ModelUtil.getModelFileFullPath("SampleModel_getModelFileFullPath_3")
      end  % nested function
    end  % function

    % Regular cases

    function PassingTest_1(~)
      mus1.ModelUtil.getModelFileFullPath("SampleModel_getModelFileFullPath_1");
    end  % function

    function PassingTest_2(~)
      mus1.ModelUtil.getModelFileFullPath("SampleModel_getModelFileFullPath_1.mdl");
    end  % function

    function PassingTest_3(~)
      mus1.ModelUtil.getModelFileFullPath("SampleModel_getModelFileFullPath_2");
    end  % function

    function PassingTest_4(~)
      mus1.ModelUtil.getModelFileFullPath("SampleModel_getModelFileFullPath_2.slx");
    end  % function

  end  % methods
end  % classdef
