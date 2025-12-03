classdef unittest_sourceFileIsNewer < matlab.unittest.TestCase
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

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "MATLAB:minrhs")
      function test_target
        FileUtil1.getFileFullPath
      end  % nested function
    end  % function

    function Test_1(testcase)
      filename0 = "temporary_sample_file_for_test.m";
      verifyTrue(testcase, not(isfile(filename0)))
      writelines("Safe to delete this file.", filename0)

      src = FileUtil1.getFileFullPath("unittest_sourceFileIsNewer");
      dst = filename0;

      is_newer = FileUtil1.sourceFileIsNewer(Source=src, Destination=dst);  %!test-target

      verifyFalse(testcase, is_newer)

      delete(filename0)
    end  % function

    function Test_2(testcase)
      filename0 = "temporary_sample_file_for_test.m";
      verifyTrue(testcase, not(isfile(filename0)))
      writelines("Safe to delete this file.", filename0)

      src = filename0;
      dst = FileUtil1.getFileFullPath("unittest_sourceFileIsNewer");

      is_newer = FileUtil1.sourceFileIsNewer(Source=src, Destination=dst, DisplayInfo=true);  %!test-target

      verifyTrue(testcase, is_newer)

      delete(filename0)
    end  % function

  end  % methods
end  % classdef
