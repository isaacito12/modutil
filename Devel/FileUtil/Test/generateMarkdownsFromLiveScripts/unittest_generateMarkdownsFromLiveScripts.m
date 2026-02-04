classdef unittest_generateMarkdownsFromLiveScripts < matlab.unittest.TestCase
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

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "MATLAB:minrhs")
      function test_target
        FileUtil1.generateMarkdownsFromLiveScripts
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target, "isLiveScript:NotFile")
      function test_target
        FileUtil1.generateMarkdownsFromLiveScripts("")
      end  % nested function
    end  % function

    function PassingTest_1(testcase)
      % Create 2 new markdown files from live scripts.

      if matlabRelease.Release == "R2026a"
        FileUtil1.displayTimeAndFileLocation("R2026a");
        verifyFail(testcase, "Not performing this test for now.")

        return

      end  % if

      if isfolder("markdown")
        rmdir("markdown", "s")
      end  % if

      target_file_1 = "sampleScript_generateMarkdownsFromLiveScripts_1";
      target_fullpath_1 = string(which(target_file_1));
      verifyTrue(testcase, not(isempty(target_fullpath_1)))

      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        target_file_2 = "sampleScript_generateMarkdownsFromLiveScripts_3";
      else
        % R2025a or newer
        target_file_2 = "sampleScript_generateMarkdownsFromLiveScripts_2";
      end  % if
      target_fullpath_2 = string(which(target_file_2));
      verifyTrue(testcase, not(isempty(target_fullpath_2)))

      % This creates "markdown" folder and move generated files in there.
      % The newly created folder is not deleted after this test
      % so that it can be inspected later.
      tf = FileUtil1.generateMarkdownsFromLiveScripts([target_fullpath_1, target_fullpath_2]);

      verifyTrue(testcase, numel(tf) == 2)
      verifyTrue(testcase, all(tf))
    end  % function

  end  % methods
end  % classdef
