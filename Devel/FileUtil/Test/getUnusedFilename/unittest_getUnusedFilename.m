classdef unittest_getUnusedFilename < matlab.unittest.TestCase
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

    % function Test_error_1(testcase)
    %   verifyError(testcase, @() test_target, "MATLAB:minrhs")
    %   function test_target
    %     FileUtil1.getFolderFullPath
    %   end  % nested function
    % end  % function

    function PassingTest_1(~)
      FileUtil1.getUnusedFilename;
    end  % function

    function Test_1(testcase)
      filename = FileUtil1.getUnusedFilename;
      verifyEqual(testcase, filename, "untitled.m")
    end  % function

    function Test_2(testcase)
      filename = FileUtil1.getUnusedFilename("untitled.json");
      verifyEqual(testcase, filename, "untitled.json")
    end  % function

    function Test_3(testcase)
      % Get an unused filename.

      filename = "temporary_sample_file_for_test.m";
      verifyTrue(testcase, not(isfile(filename)))
      writelines("Safe to delete this file.", filename)

      new_filename = FileUtil1.getUnusedFilename(filename);  % !test-target

      delete(filename)
      verifyTrue(testcase, new_filename == "temporary_sample_file_for_test1.m")
    end  % function

    function Test_4(testcase)
      % Hit the maximum count.

      filename0 = "temporary_sample_file_for_test.m";
      verifyTrue(testcase, not(isfile(filename0)))
      writelines("Safe to delete this file.", filename0)

      filename1 = "temporary_sample_file_for_test1.m";
      verifyTrue(testcase, not(isfile(filename1)))
      writelines("Safe to delete this file.", filename1)

      filename2 = "temporary_sample_file_for_test2.m";
      verifyTrue(testcase, not(isfile(filename2)))
      writelines("Safe to delete this file.", filename2)

      new_filename = FileUtil1.getUnusedFilename(filename0, MaxCount=2);  % !test-target

      delete(filename0)
      delete(filename1)
      delete(filename2)

      % A pattern should be returned when MaxCount is hit.
      verifyTrue(testcase, new_filename == "*.m")
    end  % function

  end  % methods
end  % classdef
