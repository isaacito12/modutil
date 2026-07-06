classdef uiTest_FolderSearchApp < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in this "TestMethodSetup" section always run before
    % each test defined in the "Test" section runs.

    function test_method_setup_1(testcase)
      %%
      % Close all before test
      close all
      bdclose all
      evalin("base", "clearvars")

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAllAfterTest)
      function closeAllAfterTest
        % Close/delete all figure windows. This closes/deletes not only the test targets but also
        % all the other figure windows too to provide clean state for the next test.
        figs = findall(0, Type="Figure");
        if not(any(isempty(figs)))
          disp("Deleting figures (" + numel(figs) + ")")
          delete(figs)
        end  % if

        bdclose all

        % Do not clear variables in the base workspace at the end of a test
        % to make it easy to debug after test if necessary.

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

    function clean_launch_1_1(testcase)
      verifyWarningFree(testcase, @mus1.SearchUtil.FolderSearchAppMain)
    end  % function

    function clean_launch_1_2(testcase)
      verifyWarningFree(testcase, @mus1_FolderSearchApp)
    end  % function

    function clean_launch_2_1(testcase)
      verifyWarningFree(testcase, @mus1.SearchUtil.FolderSearchResultAppMain)
    end  % function

    %% UI test
%{
    function uitest_1(testcase)
      app = mus1_SignalDesignApp;
      % Plot must update when a new value is typed in.
      type(testcase, app.MatrixTextUI.MainTextArea, "[0 2 10; 4 6 2; 8 12 6]")
    end  % function
%}
%{
    function uitest_2(testcase)
      app = AppForTesting_SignalDesignAppMain;

      press(testcase, app.SelectorUI.HilitBlockUI.MainButton)

      type(testcase, app.MatrixTextUI.MainTextArea, "[0 2 0; 4 5 2; 6 8 1]")

      press(testcase, app.SelectorUI.SetParametersToBlockUI.MainButton)

      x_in_block = string(get_param(bdroot + "/PS Lookup Table (1D)", "x"));
      verifyEqual(testcase, x_in_block, "[0, 1, 2, 4, 4.5, 5, 6, 7, 8]")

      f_in_block = string(get_param(bdroot + "/PS Lookup Table (1D)", "f"));
      verifyEqual(testcase, f_in_block, "[0, 0, 0, 2, 2, 2, 1, 1, 1]")
    end  % function
%}
  end  % methods
end  % classdef
