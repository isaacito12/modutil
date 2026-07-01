classdef uiTest_SignalDesignAppMain < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in the TestMethodSetup section always run before
    % each test defined in the Test section runs.

    function test_method_setup_1(testcase)
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
      verifyWarningFree(testcase, @() test_target)
      function test_target
        mus1.SignalUtil.SignalDesignAppMain  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_SignalDesignAppMain  % !test-target
      end  % nested function
    end  % function

    %% UI test

    function uitest_1(testcase)
      app = SignalDesignApp;
      % Plot must update when a new value is typed in.
      type(testcase, app.MatrixTextUI.MainTextArea, "[0 2 10; 4 6 2; 8 12 6]")
    end  % function

    function uitest_2(testcase)
      app = AppTest_SignalDesignAppMain;

      press(testcase, app.SelectorUI.HilitBlockUI.MainButton)

      type(testcase, app.MatrixTextUI.MainTextArea, "[0 2 0; 4 5 2; 6 8 1]")

      press(testcase, app.SelectorUI.SetParametersToBlockUI.MainButton)

      x_in_block = string(get_param(bdroot + "/PS Lookup Table (1D)", "x"));
      verifyEqual(testcase, x_in_block, "[0, 1, 2, 4, 4.5, 5, 6, 7, 8]")

      f_in_block = string(get_param(bdroot + "/PS Lookup Table (1D)", "f"));
      verifyEqual(testcase, f_in_block, "[0, 0, 0, 2, 2, 2, 1, 1, 1]")
    end  % function

  end  % methods
end  % classdef
