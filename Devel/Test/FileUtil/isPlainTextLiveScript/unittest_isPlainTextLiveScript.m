classdef unittest_isPlainTextLiveScript < matlab.unittest.TestCase
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

    function PassingTest_1(testcase)
      verifyError(testcase, @() test_target, "MATLAB:minrhs")
      function test_target
        mus1.FileUtil.isPlainTextLiveScript  % !test-target
      end  % nested function
    end  % function

    function PassingTest_2(testcase)
      verifyError(testcase, @() test_target, "isPlainTextLiveScript:FileNotSpecified")
      function test_target
        mus1.FileUtil.isPlainTextLiveScript("");  % !test-target
      end  % nested function
    end  % function

    %% Tests

    function Test_LiveScript_1_R2025a_or_newer(testcase)
      % Check that the isPlainTextLiveScript function uses the same vector shape (row or column)
      % for the output as the input.
      % This test checks the case for a row vector.

      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        mus1.FileUtil.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if

      % The "pwd" in a unit test is the folder where the unit test file exists.
      test_target_folder = fullfile(pwd, "sample folder");
      verifyTrue(testcase, isfolder(test_target_folder))

      collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(test_target_folder, "**", "*.m"));
      verifyTrue(testcase, not(isempty(collection)))

      % The paths method returns a row vector.
      mfiles = paths(collection);
      % Just in case.
      verifyTrue(testcase, isrow(mfiles))

      true_or_false = mus1.FileUtil.isPlainTextLiveScript(mfiles);  % !test-target
      verifyTrue(testcase, isrow(true_or_false))

    end  % function

    function Test_LiveScript_2_R2025a_or_newer(testcase)
      % Check that the isPlainTextLiveScript function uses the same vector shape (row or column)
      % for the output as the input.
      % This test checks the case for a column vector.

      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        mus1.FileUtil.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if

      % The "pwd" in a unit test is the folder where the unit test file exists.
      test_target_folder = fullfile(pwd, "sample folder");
      verifyTrue(testcase, isfolder(test_target_folder))

      collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(test_target_folder, "**", "*.m"));
      verifyTrue(testcase, not(isempty(collection)))

      % The paths method returns a row vector.
      mfiles = transpose(paths(collection));
      % Just in case.
      verifyTrue(testcase, iscolumn(mfiles))

      true_or_false = mus1.FileUtil.isPlainTextLiveScript(mfiles);  % !test-target
      verifyTrue(testcase, iscolumn(true_or_false))

    end  % function

    function Test_LiveScript_3_R2025a_or_newer(testcase)
      % Check that the isPlainTextLiveScript function is making correct judgment for the files passed.
      % This test assumes that the "samplefolder" has files whose names end with "3.m" that are
      % plain-text Live Scripts while all other files are not.

      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        mus1.FileUtil.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if

      % The "pwd" in a unit test is the folder where the unit test file exists.
      test_target_folder = fullfile(pwd, "sample folder");
      verifyTrue(testcase, isfolder(test_target_folder))

      collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(test_target_folder, "**", "*.m"));
      verifyTrue(testcase, not(isempty(collection)))

      mfiles = paths(collection);

      true_or_false = mus1.FileUtil.isPlainTextLiveScript(mfiles);  % !test-target

      expected = endsWith(mfiles, "3.m");
      verifyTrue(testcase, all(true_or_false == expected));

    end  % function

    function Test_LiveScript_4_R2025a_or_newer(testcase)
      % Use isPlainTextLiveScript for files in the "sample folder" folder tree.

      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        mus1.FileUtil.displayTimeAndFileLocation("Skipping this test.");

        return

      end  % if

      collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(pwd, "sample folder", "**", "*.m"));
      verifyTrue(testcase, not(isempty(collection)))

      mfiles = paths(collection)';
      result= mus1.FileUtil.isPlainTextLiveScript(mfiles);  % !test-target
      verifyEqual(testcase, result, logical([0 1 0 1 0 1 0 1]'))
    end  % function

  end  % methods
end  % classdef
