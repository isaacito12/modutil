classdef unittest_checkLiveScriptsAndMarkdowns < matlab.unittest.TestCase
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
      verifyError(testcase, @() test_target, "MATLAB:validators:mustBeNonzeroLengthText")
      function test_target
        mus1.TestUtil.checkLiveScriptsAndMarkdowns("")
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target, "MATLAB:validators:mustBeNonzeroLengthText")
      function test_target
        mus1.TestUtil.checkLiveScriptsAndMarkdowns(MarkdownFolder="")
      end  % nested function
    end  % function

    % Passing tests

    function PassingTest_1(~)
      mus1.TestUtil.checkLiveScriptsAndMarkdowns();
    end  % function

    function PassingTest_2(testcase)
      result = mus1.TestUtil.checkLiveScriptsAndMarkdowns(pwd);
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older do not support Live M files.
        verifyEqual(testcase, result.HasMarkdown, [false; true])
      else
        % R2025a or newer support Live M files.
        verifyEqual(testcase, result.HasMarkdown, [false; true; false; true])
      end  % if
    end  % function

    function PassingTest_3(testcase)
      result = mus1.TestUtil.checkLiveScriptsAndMarkdowns(MarkdownFolder="markdown");
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older do not support Live M files.
        verifyEqual(testcase, result.HasMarkdown, [false; true])
      else
        % R2025a or newer support Live M files.
        verifyEqual(testcase, result.HasMarkdown, [false; true; false; true])
      end  % if
    end  % function

  end  % methods
end  % classdef
