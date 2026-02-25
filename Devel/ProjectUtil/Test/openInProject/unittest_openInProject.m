classdef unittest_openInProject < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2023-2026 The MathWorks, Inc.

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

    %% Tests

    function Error_1(testcase)
      verifyError(testcase, @test_target, "MATLAB:minrhs")
      function test_target
        ProjectUtil1.openInProject  % !test_target
      end  % nested function
    end  % function

    function Error_2(testcase)
      target_script = "SampleScript_openInProject";
      targetfile_fullpath = string( which(target_script));
      % Make sure that the target is not open. Close it if it is open.
      docs_in_editor = matlab.desktop.editor.getAll;
      logical_index = string({docs_in_editor.Filename}') == targetfile_fullpath;
      if nnz(logical_index) == 1
        close(docs_in_editor(logical_index))
      end  % if

      verifyError(testcase, @test_target, "openInProject:NoProjectIsOpen")

      function test_target
        ProjectUtil1.openInProject(target_script)  % !test-target
      end  % nested function
    end  % function

  end  % methods
end  % classdef
