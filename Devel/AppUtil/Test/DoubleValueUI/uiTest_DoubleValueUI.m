classdef uiTest_DoubleValueUI < matlab.uitest.TestCase
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

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @DemoApp_DoubleValueUI_1_simplest)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @DemoApp_DoubleValueUI_2)
    end  % function

    %% Gesture test

    function Gesture_1(testcase)
      app = DemoApp_DoubleValueUI_1_simplest;
      type(testcase, app.DoubleValueUI_1.ValueTextUI.MainEditField, "pi")
      type(testcase, app.DoubleValueUI_1.ValueTextUI.MainEditField, "[0 2]")
      type(testcase, app.DoubleValueUI_1.ValueTextUI.MainEditField, "ones(2)")
    end  % function

    %% Base workspace

    function BaseWorkspace_1(testcase)

      evalin("base", "x = [-5, 3];")

      app = DemoApp_DoubleValueUI_1_simplest;
      type(testcase, app.DoubleValueUI_1.ValueTextUI.MainEditField, "2.*x")

      verifyEqual(testcase, app.DoubleValueUI_1.ValueText, "2.*x")
      verifyEqual(testcase, app.DoubleValueUI_1.MainDoubleValue, [-10, 6])

    end  % function

    function BaseWorkspace_2(testcase)

      evalin("base", "a = struct; a.b.c = [1 2; 3 4];")

      app = DemoApp_DoubleValueUI_2;
      type(testcase, app.DoubleValueUI_1.ValueTextUI.MainEditField, "2.*a.b.c")

      verifyEqual(testcase, app.DoubleValueUI_1.ValueText, "2.*a.b.c")
      verifyEqual(testcase, app.DoubleValueUI_1.MainDoubleValue, [2 4; 6 8])

    end  % function

  end  % methods
end  % classdef
