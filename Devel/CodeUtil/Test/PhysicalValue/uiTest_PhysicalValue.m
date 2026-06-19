classdef uiTest_PhysicalValue < matlab.uitest.TestCase
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
      verifyWarningFree(testcase, @test_target)
      function test_target
        DemoApp_PhysicalValue_1_workspace  % !test-target
      end  % nested function
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @tets_target)
      function tets_target
        DemoApp_PhysicalValue_2_listener  % !test-target
      end  % nested function
    end  % function

    %% Gesture test

    function Geasture_1_1(testcase)
      app = DemoApp_PhysicalValue_1_workspace;
      type(testcase, app.EditFieldUI.MainEditField, "[1,2,3]")

      type(testcase, app.EditFieldUI.MainEditField, "simscape.Value([4 5; 6 7], ""m"")")

      actual_value_text = string(app.ValueUI.MainEditField.Value);
      verifyEqual(testcase, actual_value_text, "[4, 5; 6, 7]")

      actual_unit_text = string(app.UnitUI.MainEditField.Value);
      verifyEqual(testcase, actual_unit_text, "m")
    end  % function

    function Geasture_1_2(testcase)
      evalin("base", "x = 1.2;")
      app = DemoApp_PhysicalValue_1_workspace;
      type(testcase, app.EditFieldUI.MainEditField, "x")

      evalin("base", "x = simscape.Value([-1, 0, 1], ""m/s"");")
      press(testcase, app.RefreshButtonUI.MainButton)
    end  % function

    function Geasture_2_1(testcase)
      app = DemoApp_PhysicalValue_2_listener;

      type(testcase, app.LengthUI.MainEditField, "simscape.Value([4 5], ""in"")")

      actual_value_text = app.AreaUI.Value;
      verifyEqual(testcase, actual_value_text, "[16, 25] (in^2)")
    end  % function

    function Geasture_2_2(testcase)
      app = DemoApp_PhysicalValue_2_listener;

      evalin("base", "param1 = struct; param1.L = simscape.Value(2, ""cm"");")
      type(testcase, app.LengthUI.MainEditField, "param1.L")
      actual_value_text = app.AreaUI.Value;
      verifyEqual(testcase, actual_value_text, "4 (cm^2)")

      evalin("base", "param1.L = simscape.Value(3, ""in"");")
      press(testcase, app.RefreshButtonUI.MainButton)
      actual_value_text = app.AreaUI.Value;
      verifyEqual(testcase, actual_value_text, "9 (in^2)")
    end  % function

  end  % methods
end  % classdef
