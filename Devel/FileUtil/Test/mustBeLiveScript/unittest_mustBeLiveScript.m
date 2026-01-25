classdef unittest_mustBeLiveScript < matlab.unittest.TestCase
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
        FileUtil1.mustBeLiveScript  % !test-target
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target, "isLiveScript:NotFile")
      function test_target
        FileUtil1.mustBeLiveScript("")  % !test-target
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @() test_target, "isLiveScript:NotFile")
      function test_target
        FileUtil1.mustBeLiveScript("unittest_mustBeLiveScript")  % !test-target
      end  % nested function
    end  % function

    function PassingTest_1(~)
      file_1 = FileUtil1.getFileFullPath("sampleScript_mustBeLiveScript_1");
      FileUtil1.mustBeLiveScript(file_1)  % !test-target
    end  % function

    function PassingTest_2_R2024b(testcase)
      if not(isMATLABReleaseOlderThan("R2025a"))
        % R2025a or newer
        FileUtil1.displayTimeAndFileLocation("Skipping this test.")

        return

      end  % if
      % R2024b or older
      file_1 = FileUtil1.getFileFullPath("sampleScript_mustBeLiveScript_2");
      verifyError(testcase, @() test_target, "mustBeLiveScript:NotLiveScript")
      function test_target
        FileUtil1.mustBeLiveScript(file_1)  % !test-target
      end  % nested function
    end  % function

    function PassingTest_3_R2025a_or_newer(~)
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        FileUtil1.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if
      % R2025a or newer
      file_1 = FileUtil1.getFileFullPath("sampleScript_mustBeLiveScript_2");
      FileUtil1.mustBeLiveScript(file_1)  % !test-target
    end  % function

    function PassingTest_4_R2024b(testcase)
      if not(isMATLABReleaseOlderThan("R2025a"))
        % R2025a or newer
        FileUtil1.displayTimeAndFileLocation("Skipping this test.")

        return

      end  % if
      % R2024b or older
      file_1 = FileUtil1.getFileFullPath("sampleScript_mustBeLiveScript_1");
      file_2 = FileUtil1.getFileFullPath("sampleScript_mustBeLiveScript_2");
      verifyError(testcase, @() test_target, "mustBeLiveScript:NotLiveScript")
      function test_target
        FileUtil1.mustBeLiveScript([file_1, file_2])  % !test-target
      end  % nested function
    end  % function

    function PassingTest_5_R2025a_or_newer(~)
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        FileUtil1.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if
      % R2025a or newer
      file_1 = FileUtil1.getFileFullPath("sampleScript_mustBeLiveScript_1");
      file_2 = FileUtil1.getFileFullPath("sampleScript_mustBeLiveScript_2");
      FileUtil1.mustBeLiveScript([file_1, file_2])  % !test-target
    end  % function

  end  % methods
end  % classdef
