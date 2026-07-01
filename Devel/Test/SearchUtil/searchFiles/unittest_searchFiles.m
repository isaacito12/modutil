classdef unittest_searchFiles < matlab.unittest.TestCase
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

    % Error cases

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "MATLAB:minrhs")
      function test_target
        mus1.SearchUtil.searchFiles
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target, "searchFiles:EmptyFilenameNotAllowed")
      function test_target
        mus1.SearchUtil.searchFiles("")
      end  % nested function
    end  % function

    % Regular tests

    function PassingTest_1(testcase)
      % Find this test file itself.
      target_file = "unittest_searchFiles.m";
      actual = mus1.SearchUtil.searchFiles(target_file);
      verifyTrue(testcase, isscalar(actual))
    end  % function

    function PassingTest_2(testcase)
      % The returned value must be empty if the specified file was not found.
      target_file = "test_test_test";
      result = mus1.SearchUtil.searchFiles(target_file);
      verifyTrue(testcase, isempty(result))
    end  % function

    function PassingTest_3(testcase)
      % Find using a pattern. Depending on the top folder (current folder),
      % "unittest_*" can result in one or more files.
      target_file = "unittest_*";
      actual = mus1.SearchUtil.searchFiles(target_file);
      verifyTrue(testcase, not(isempty(actual)))
    end  % function

    function PassingTest_4(testcase)
      % Test the TopFolder option.
      target_file = "*.m";
      top_folder = fullfile(matlabroot, "toolbox", "matlab", "buildtool", "core", "+matlab", "+buildtool", "+io");
      actual = mus1.SearchUtil.searchFiles(target_file, TopFolder=top_folder);
      verifyTrue(testcase, not(isempty(actual)))
    end  % function

  end  % methods
end  % classdef
