classdef uiTest_AppUtil < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2026 The MathWorks, Inc.

  properties
    % Do not specify the class name for a property to hold a handle to an app.
    % For class-based test apps, the class name is the app name, making
    % it difficult to use a common teardown if the class name is specified here.
    App (1,1)
  end  % properties

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
      % ColormapApp requires MATLAB R2025a or newer.
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        ColormapApp  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        MonitorInfoApp  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        CodeCoverageApp_AppUtil  % !test-target
      end  % nested function
    end  % function

  end  % methods
end  % classdef
