classdef unittest_isPlainTextLiveScript < matlab.unittest.TestCase
  %% Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2024-2025 The MathWorks, Inc.

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

    function PassingTest_LiveScript_1(testcase)
      verifyError(testcase, @() test_target, "MATLAB:minrhs")
      function test_target
        FileUtil1.isPlainTextLiveScript()
      end  % nested function
    end  % function

    %% Tests

    function Test_LiveScript_1(testcase)
      % Check that the isPlainTextLiveScript function uses the same vector shape (row or column)
      % for the output as the input.
      % This test checks the case for a row vector.

      % "pwd" in a unit test is the folder where the unit test file exists.
      test_target_folder = fullfile(pwd, "sample folder");
      verifyTrue(testcase, isfolder(test_target_folder))

      collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(test_target_folder, "**", "*.m"));
      verifyTrue(testcase, not(isempty(collection)))

      % The paths method returns a row vector.
      mfiles = paths(collection);
      % Just in case.
      verifyTrue(testcase, isrow(mfiles))

      tf = FileUtil1.isPlainTextLiveScript(mfiles);  % !test-target
      verifyTrue(testcase, isrow(tf))

    end  % function

    function Test_LiveScript_2(testcase)
      % Check that the isPlainTextLiveScript function uses the same vector shape (row or column)
      % for the output as the input.
      % This test checks the case for a column vector.

      % "pwd" in a unit test is the folder where the unit test file exists.
      test_target_folder = fullfile(pwd, "sample folder");
      verifyTrue(testcase, isfolder(test_target_folder))

      collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(test_target_folder, "**", "*.m"));
      verifyTrue(testcase, not(isempty(collection)))

      % The paths method returns a row vector.
      mfiles = transpose(paths(collection));
      % Just in case.
      verifyTrue(testcase, iscolumn(mfiles))

      tf = FileUtil1.isPlainTextLiveScript(mfiles);  % !test-target
      verifyTrue(testcase, iscolumn(tf))

    end  % function

    function Test_LiveScript_3(testcase)
      % Check that the isPlainTextLiveScript function is making correct judgement for the files passed.
      % This test assumes that the "samplefolder" has files whose names end with "3.m" that are
      % plain-text Live Scripts while all other files are not.

      % "pwd" in a unit test is the folder where the unit test file exists.
      test_target_folder = fullfile(pwd, "sample folder");
      verifyTrue(testcase, isfolder(test_target_folder))

      collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(test_target_folder, "**", "*.m"));
      verifyTrue(testcase, not(isempty(collection)))

      mfiles = paths(collection);

      tf = FileUtil1.isPlainTextLiveScript(mfiles);  % !test-target

      x = endsWith(mfiles, "3.m");
      verifyTrue(testcase, all(tf == x));

    end  % function

    function Test_LiveScript_4(testcase)
      % Use isPlainTextLiveScript for files in the "sample folder" folder tree.
      collection = matlab.buildtool.io.FileCollection.fromPaths(fullfile(pwd, "sample folder", "**", "*.m"));
      verifyTrue(testcase, not(isempty(collection)))
      mfiles = paths(collection)';
      IsPlainTextLiveScript = FileUtil1.isPlainTextLiveScript(mfiles);
      verifyEqual(testcase, IsPlainTextLiveScript, logical([0 1 0 1 0 1 0 1]'))
    end  % function

  end  % methods

end  % classdef
