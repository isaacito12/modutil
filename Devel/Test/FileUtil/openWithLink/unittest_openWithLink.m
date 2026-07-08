classdef unittest_openWithLink < matlab.unittest.TestCase
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

  properties
    % Some of the tests in this class run only if test is running locally under the LocalTopFolder.
    LocalTopFolder (1,1) pattern = "C:\local"
  end  % properties

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
        mus1.FileUtil.openWithLink
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping (the test is not running within the specified local path.)")

        return

      end  %if

      verifyError(testcase, @() test_target, "MATLAB:open:fileNotFound")
      function test_target
        mus1.FileUtil.openWithLink("dummy_dummy")
      end  % nested function
    end  % function

    function PassingTest_1(testcase)
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping (the test is not running within the specified local path.)")

        return

      end  %if

      target_file_name = "SampleScript_openWithLink_1";

      targetfile_fullpath = matlab.buildtool.io.FileCollection.fromPaths(fullfile(pwd, "**", target_file_name+".m")).paths;
      if isempty(targetfile_fullpath)
        targetfile_fullpath = matlab.buildtool.io.FileCollection.fromPaths(fullfile(pwd, "**", target_file_name+".mlx")).paths;
      end  % if
      if isempty(targetfile_fullpath)

        verifyFail(testcase, "Target Live Script was not found in either .m and .mlx: " + target_file_name)

      end  % if

      % Make sure that the target is not open. Close it if it is.
      docs_in_editor = matlab.desktop.editor.getAll;
      logical_index = string({docs_in_editor.Filename}') == targetfile_fullpath;
      if nnz(logical_index) == 1
        close(docs_in_editor(logical_index))
      end  % if

      % This must open the intended Live Script in the Editor.
      mus1.FileUtil.openWithLink(targetfile_fullpath);  % !test-target !attention: locally works, but can fail in CI.

      % Find the target Live Script in the Editor and close it.
      docs_in_editor = matlab.desktop.editor.getAll;
      logical_index = string({docs_in_editor.Filename}') == targetfile_fullpath;
      verifyEqual(testcase, nnz(logical_index), 1)
      close(docs_in_editor(logical_index))
    end  % function

    function PassingTest_2(testcase)
      target_model = "openWithLink_SampleModel_1";
      % All models must have been closed by the test method set up.
      verifyTrue(testcase, not(bdIsLoaded(target_model)))
      mus1.FileUtil.openWithLink(target_model)  % !test-target
      verifyTrue(testcase, bdIsLoaded(target_model))
    end  % function

  end  % methods
end  % classdef
