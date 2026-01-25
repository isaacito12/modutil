classdef uiTest_TextSearchAppMain < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in this "TestMethodSetup" section always run before
    % each test defined in the "Test" section runs.

    function test_method_setup(testcase)
      %%
      % Close all before test
      close all
      bdclose all

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAllAfterTest)
      function closeAllAfterTest
        % Close all figure windows. This closes not only the test targets but also other figure windows.
        figs = findall(0, Type="Figure");
        if not(any(isempty(figs)))
          disp("Deleting figures (" + numel(figs) + ")")
          delete(figs)
        end  % if
        bdclose all
      end  % nested function
    end  % function

  end  % methods

  methods (Test)
    % Functions in the Test section are the tests.
    % Before a function in this section runs, the functions defined in the TestMethodSetup section run.

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function app_launches_without_warnings_1(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        SearchUtil1.TextSearchAppMain  % !test-target
      end  % nested function
    end  % function

    %% Gesture test

    function Gesture_1(testcase)
      app = SearchUtil1.TextSearchAppMain;

      % Press the Search button. A new window for the search result must open.
      press(testcase, app.SearchButtonUI.MainButton)
    end  % function

    function Gesture_2(testcase)
      app = SearchUtil1.TextSearchAppMain;

      % Press the "Copy command" button.
      press(testcase, app.CopyCommandButtonUI.MainButton)

      % Get the data from the system clipboard.
      contents = clipboard("paste");

      verifyTrue(testcase, startsWith(contents, "SearchUtil1.searchText("))
    end  % function

  end  % methods
end  % classdef
