classdef unittest_batchGenerateMarkdowns < matlab.unittest.TestCase
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
      FileUtil1.batchGenerateMarkdowns
    end  % function

    %% Tests

    function Test_1(testcase)
      % Visually inspect the list the function displays.
      f = FileUtil1.getFolderFullPath("batchGenerateMarkdowns");
      verifyTrue(testcase, contains(f, "FileUtil" + ("/"|"\") + "Test" + ("/"|"\") + "batchGenerateMarkdowns"))

      target1 = fullfile(f, "sample folder", "subfolder 1");
      target2 = fullfile(f, "sample folder", "subfolder 2");

      num_conv = FileUtil1.batchGenerateMarkdowns(DryRun=true, LiveScriptFolderNames=[target1, target2]);  % !test-target

      verifyTrue(testcase, num_conv == 0)
    end  % function

  end  % methods
end  % classdef
