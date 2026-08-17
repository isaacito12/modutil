classdef unittest_getLinkedCommandFromPlainTextLiveScript < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2024-2026 The MathWorks, Inc.

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
      %%
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        mus1.FileUtil.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if
      DemoScript_getLinkedCommandFromPlainTextLiveScript_1
    end  % function

    function PassingTest_2(~)
      %%
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        mus1.FileUtil.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if
      DemoScript_getLinkedCommandFromPlainTextLiveScript_2
    end  % function

    %% Tests

    function error_case_1(testcase)
      verifyError(testcase, @mus1.FileUtil.getLinkedCommandFromPlainTextLiveScript, "MATLAB:minrhs")
    end  % function

    function test_1(testcase)
      %%
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        mus1.FileUtil.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if
      fullpath = string( which("SampleScript_getLinkedCommandFromPlainTextLiveScript_1"));
      result = mus1.FileUtil.getLinkedCommandFromPlainTextLiveScript(fullpath);
      verifyEqual(testcase, result.Line, [2 2 3 3]')
      verifyEqual(testcase, result.LinkText, ["linked text" "another link" "Yet another linked text" "This"]')
      verifyEqual(testcase, result.Command, ["disp(""test 1"")" "disp(""test 2"")" "datetime" "logo"]')
    end  % function

    function test_2(testcase)
      %%
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        mus1.FileUtil.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if
      fullpath = string( which("SampleScript_getLinkedCommandFromPlainTextLiveScript_2"));
      result = mus1.FileUtil.getLinkedCommandFromPlainTextLiveScript(fullpath);
      verifyEqual(testcase, result.Line, [3, 6, 12, 19, 23]')
      verifyEqual(testcase, result.LinkText, [
        "BEV Project Navigation App"
        "BEV system model"
        "Vehicle 1D harness model"
        "Motor drive unit harness model"
        "High voltage battery harness model"
        ])
      verifyEqual(testcase, result.Command, [
        "BEVProjectNavigationApp"
        "bevutil1.ProjectUtil.openInProject('BEV_system_model')"
        "bevutil1.ProjectUtil.openInProject('HarnessModel_Vehicle1D')"
        "bevutil1.ProjectUtil.openInProject('HarnessModel_MotorDriveUnit')"
        "bevutil1.ProjectUtil.openInProject('HarnessModel_BatteryHV')"
        ])
    end  % function

  end  % methods
end  % classdef
