classdef unittest_getFolderFullPath < matlab.unittest.TestCase
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
        FileUtil1.getFolderFullPath
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target, "getFolderFullPath:InvalidFolderName")
      function test_target
        FileUtil1.getFolderFullPath("")
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @() test_target, "getFolderFullPath:FolderNotFound")
      function test_target
        FileUtil1.getFolderFullPath("test-test-test")
      end  % nested function
    end  % function

    function Test_warning_1(testcase)
      verifyWarning(testcase, @test_target, "getFolderFullPath:TwoOrMoreMatches")
      function test_target
        % Many individual components have their own "sample folder" for tesrting.
        FileUtil1.getFolderFullPath("sample folder", WarningOnMultipleMatch=true)
      end  % nested function
    end  % function

    function PassingTest_1(~)
      FileUtil1.getFolderFullPath("sample folder getFolderFullPath");
    end  % function

    function PassingTest_namespace_1(~)
      FileUtil1.getFolderFullPath("+SampleFolder_getFolderFullPath");
    end  % function

  end  % methods
end  % classdef
