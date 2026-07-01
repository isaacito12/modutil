classdef unittest_updateMarkdownForMathRendering < matlab.unittest.TestCase
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

    function error_1(testcase)
      verifyError(testcase, @test_target, "MATLAB:minrhs")
      function test_target
        mus1.FileUtil.updateMarkdownForMathRendering()
      end  % nested function
    end  % function

    function test_1(testcase)
      original_file = mus1.FileUtil.getFileFullPath("updateMarkdownForMathRendering_SampleFile1.md");

      target_file = fullfile(pwd, "tmpfile1.md");
      copyfile(original_file, target_file)
      disp("Target file: " + target_file)

      num_lines = mus1.FileUtil.updateMarkdownForMathRendering(target_file);  % !test-target
      verifyEqual(testcase, num_lines, 12)

      delete(target_file)
      disp("Deleted target file.")
    end  % function

  end  % methods
end  % classdef
