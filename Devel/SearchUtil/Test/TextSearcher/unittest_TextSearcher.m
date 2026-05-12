classdef unittest_TextSearcher < matlab.unittest.TestCase
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

    function PassingTest_1(~)
      searcher = SearchUtil1.TextSearcher;
      setDefaults(searcher)
      runSearch(searcher);
    end  % function

    function Error_1(testcase)
      verifyError(testcase, @test_target, "TextSearcher:NotReady")
      function test_target()
        searcher = SearchUtil1.TextSearcher;
        runSearch(searcher);
      end  % function
    end  % function

    %% Tests
    % Unit test runs in the folder where the test file exists.

    function Test_1(testcase)
      % Set up states in the TextSearcher object.
      % There are no matching files.
      searcher = SearchUtil1.TextSearcher;
      searcher.States.SearchTextPattern = "dummy";
      searcher.States.FileTypes = "*.test_extension";
      searcher.States.TargetFolder = pwd;
      result = runSearch(searcher);
      verifyTrue(testcase, isempty(result))
    end  % function

    function Test_2(testcase)
      % Set up states outside the TextSearcher, and then set them to the TextSearcher object.
      % There are no matching files.
      states = SearchUtil1.TextSearchStates;
      states.SearchTextPattern = "dummy";
      states.FileTypes = "*.test_extension";
      states.TargetFolder = pwd;

      searcher = SearchUtil1.TextSearcher;
      setStates(searcher, states)  % !test-target

      result = runSearch(searcher);
      verifyTrue(testcase, isempty(result))
    end  % function

    function Test_MatchWholeWord_1(testcase)
      % There should be only one match.

      text_searcher = SearchUtil1.TextSearcher;
      text_searcher.DisplayInfo = true;

      text_searcher.States.SearchTextPattern = "Copyri";  % !test-target
      text_searcher.States.IgnoreCase = false;
      text_searcher.States.MatchWholeWord = true;  % !test-target

      % Limit the search to the current folder only.
      text_searcher.States.TargetFolder = pwd;
      text_searcher.States.IncludeSubfolders = false;

      text_searcher.States.FileTypes = "*.m";

      text_searcher.States.SearchAll = false;
      text_searcher.States.SearchMATLAB = true;
      text_searcher.States.SearchMarkdown = false;
      text_searcher.States.SearchSimulink = false;
      text_searcher.States.SearchSimscape = false;
      text_searcher.States.SearchSVG = false;

      text_searcher.States.CustomFileTypes = "";

      text_searcher.States.ExcludeLiveScript = false;
      text_searcher.States.ExcludeMATLABCodeFile = false;

      text_searcher.States.Filter = [];

      buildFileTypes(text_searcher)
      result = runSearch(text_searcher);

      verifyTrue(testcase, height(result) == 1)
      verifyTrue(testcase, contains(result.LineText(1), "text_searcher.States.SearchTextPattern = "))
    end  % function

    function Test_MatchWholeWord_2_1(testcase)
      text_searcher = SearchUtil1.TextSearcher;
      text_searcher.DisplayInfo = true;

      text_searcher.States.SearchTextPattern = "myNamespace1";  % !test-target
      text_searcher.States.IgnoreCase = false;
      text_searcher.States.MatchWholeWord = true;  % !test-target

      % Search the whole current folder tree.
      text_searcher.States.TargetFolder = pwd;
      text_searcher.States.IncludeSubfolders = true;

      text_searcher.States.FileTypes = "*.m";

      text_searcher.States.SearchAll = false;
      text_searcher.States.SearchMATLAB = true;
      text_searcher.States.SearchMarkdown = false;
      text_searcher.States.SearchSimulink = false;
      text_searcher.States.SearchSimscape = false;
      text_searcher.States.SearchSVG = false;

      text_searcher.States.CustomFileTypes = "";

      text_searcher.States.ExcludeLiveScript = false;
      text_searcher.States.ExcludeMATLABCodeFile = false;

      text_searcher.States.Filter = [];

      buildFileTypes(text_searcher)
      result = runSearch(text_searcher);

      % There must be 2 files in the search result. One is this test file.
      % The other is samplefunction_111.m in the sample folder tree.
      verifyTrue(testcase, height(result) == 2)
      verifyTrue(testcase, any(contains(result.FilePath, "samplefunction_111.m")))
      verifyTrue(testcase, any(contains(result.FilePath, "unittest_TextSearcher.m")))
    end  % function

    function Test_DoNotIgnoreCase_1(testcase)
      text_searcher = SearchUtil1.TextSearcher;
      text_searcher.DisplayInfo = true;

      % Do not ignore case.
      text_searcher.States.SearchTextPattern = "cOPYRIGHT";  % !test-target
      text_searcher.States.IgnoreCase = false;  % !test-target
      text_searcher.States.MatchWholeWord = false;

      % Limit the search to the current folder only.
      text_searcher.States.TargetFolder = pwd;
      text_searcher.States.IncludeSubfolders = false;

      text_searcher.States.FileTypes = "*.m";

      text_searcher.States.SearchAll = false;
      text_searcher.States.SearchMATLAB = true;
      text_searcher.States.SearchMarkdown = false;
      text_searcher.States.SearchSimulink = false;
      text_searcher.States.SearchSimscape = false;
      text_searcher.States.SearchSVG = false;

      text_searcher.States.CustomFileTypes = "";

      text_searcher.States.ExcludeLiveScript = false;
      text_searcher.States.ExcludeMATLABCodeFile = false;

      text_searcher.States.Filter = [];

      buildFileTypes(text_searcher)
      result = runSearch(text_searcher);

      % This test file must be the only file in the search result.
      verifyTrue(testcase, height(result) == 1)
      verifyTrue(testcase, any(contains(result.FilePath, "unittest_TextSearcher.m")))
    end  % function

    function Test_SearchAll_1(testcase)
      text_searcher = SearchUtil1.TextSearcher;
      text_searcher.DisplayInfo = true;

      text_searcher.States.SearchTextPattern = "Copyright";
      text_searcher.States.IgnoreCase = true;
      text_searcher.States.MatchWholeWord = true;

      % Search the whole current folder tree.
      text_searcher.States.TargetFolder = pwd;
      text_searcher.States.IncludeSubfolders = true;

      text_searcher.States.FileTypes = ["*.m", "*.mdl"];

      text_searcher.States.SearchAll = true;
      text_searcher.States.SearchMATLAB = false;
      text_searcher.States.SearchMarkdown = false;
      text_searcher.States.SearchSimulink = false;
      text_searcher.States.SearchSimscape = false;
      text_searcher.States.SearchSVG = false;

      text_searcher.States.CustomFileTypes = "";

      text_searcher.States.ExcludeLiveScript = false;
      text_searcher.States.ExcludeMATLABCodeFile = false;

      text_searcher.States.Filter = [];

      buildFileTypes(text_searcher)
      result = runSearch(text_searcher);

      % There must be both "*.m" and "*.mdl" files in the search result.
      verifyTrue(testcase, height(result) > 1)
      verifyTrue(testcase, any(endsWith(result.FilePath, ".m")))
      verifyTrue(testcase, any(endsWith(result.FilePath, "_live.m")))
      verifyTrue(testcase, any(endsWith(result.FilePath, ".mdl")))
    end  % function

    function Test_SearchAll_ExcludeLiveScript_1(testcase)
      if isMATLABReleaseOlderThan("R2025a")
        % Skip this test if MATLAB is R2024b or older.
        % The "Live-M" file (plain-text Live Script) is supported in R2025a or newer.

        return

      end  % if

      text_searcher = SearchUtil1.TextSearcher;
      text_searcher.DisplayInfo = true;

      text_searcher.States.SearchTextPattern = "Copyright";
      text_searcher.States.IgnoreCase = true;
      text_searcher.States.MatchWholeWord = true;

      % Search the whole current folder tree.
      text_searcher.States.TargetFolder = pwd;
      text_searcher.States.IncludeSubfolders = true;

      text_searcher.States.FileTypes = ["*.m", "*.mdl"];

      text_searcher.States.SearchAll = true;
      text_searcher.States.SearchMATLAB = false;
      text_searcher.States.SearchMarkdown = false;
      text_searcher.States.SearchSimulink = false;
      text_searcher.States.SearchSimscape = false;
      text_searcher.States.SearchSVG = false;

      text_searcher.States.CustomFileTypes = "";

      text_searcher.States.ExcludeLiveScript = true;
      text_searcher.States.ExcludeMATLABCodeFile = false;

      text_searcher.States.Filter = [];

      buildFileTypes(text_searcher)
      result = runSearch(text_searcher);

      % There must be both "*.m" and "*.mdl" files in the search result.
      verifyTrue(testcase, height(result) > 1)
      verifyTrue(testcase, any(endsWith(result.FilePath, ".m")))
      verifyTrue(testcase, not(any(endsWith(result.FilePath, "_live.m"))))
      verifyTrue(testcase, any(endsWith(result.FilePath, ".mdl")))
    end  % function

  end  % methods
end  % classdef
