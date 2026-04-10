classdef uiTest_PhysicalValueUI < matlab.uitest.TestCase
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

    function app_launches_without_warnings_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_PhysicalValueUI_1_simplest  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_PhysicalValueUI_2  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_PhysicalValueUI_Refresh_1  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_4(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_PhysicalValueUI_Refresh_2  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_5(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_PhysicalValueUI_SimscapeValue  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_6(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_PhysicalValueUI_UnitAlias_1_empty  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_7(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_PhysicalValueUI_UnitAlias_2_percent  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_8(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_PhysicalValueUI_UnitItems_1  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_9(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_PhysicalValueUI_UnitText_1  % !test-target
      end  % nested function
    end  % function

    %% Alert tests for the value UI

    function AlertTest_1(~)
      app = AppTest_PhysicalValueUI_1_simplest;
      app.PhysicalValueUI.AlertUI.MainImage.Visible = "on";
    end  % function

    function AlertTest_2(testcase)
      app = AppTest_PhysicalValueUI_1_simplest;

      % At first, error icon must be hidden.
      verifyEqual(testcase, logical(app.PhysicalValueUI.AlertUI.MainImage.Visible), false)

      % Enter a wrong text, and error icon must appear.
      type(testcase, app.PhysicalValueUI.ValueTextUI.MainEditField, "0-")
      actual = logical(app.PhysicalValueUI.AlertUI.MainImage.Visible);
      verifyEqual(testcase, actual, true)

      % Enter a valid text. Error icon must disappear.
      type(testcase, app.PhysicalValueUI.ValueTextUI.MainEditField, "pi")
      actual = logical(app.PhysicalValueUI.AlertUI.MainImage.Visible);
      verifyEqual(testcase, actual, false)
    end  % function

    %% Tests for physical unit

    function PhysicalUnit_1(testcase)
      app = AppTest_PhysicalValueUI_UnitItems_1;
      items_before = app.PhysicalValueUI_1.UnitDropDownUI.MainDropDown.Items;

      % Enter an invalid unit text.
      type(testcase, app.PhysicalValueUI_1.UnitDropDownUI.MainDropDown, "abc")

      % The unit items must remain the same as before.
      items_after = app.PhysicalValueUI_1.UnitDropDownUI.MainDropDown.Items;
      verifyEqual(testcase, items_after, items_before)
    end  % function

    %% Test

    function Test_1(testcase)
      app = AppTest_PhysicalValueUI_SimscapeValue;

      verifyEqual(testcase, app.PhysValUI_1.ValueText, "2.3")
      verifyEqual(testcase, simscape.Unit(app.PhysValUI_1.UnitText), simscape.Unit("ms"))

      verifyEqual(testcase, app.PhysValUI_2.ValueText, "-4")
      verifyEqual(testcase, simscape.Unit(app.PhysValUI_2.UnitText), simscape.Unit("lbf*in"))
    end  % function

    %% Gesture test

    function Gesture_UnitAlias_1(testcase)
      app = AppTest_PhysicalValueUI_UnitAlias_1_empty;

      verifyEqual(testcase, app.PhysicalValueUI.UnitLabelUI.MainLabel.Text, '')
      verifyEqual(testcase, app.PhysicalValueUI.UnitAlias, "")
      verifyEqual(testcase, app.PhysicalValueUI.UnitText, "1")
      verifyEqual(testcase, app.PhysicalValueUI.UnitItems, "")

      press(testcase, app.RefreshButtonUI.MainButton)

      verifyEqual(testcase, app.PhysicalValueUI.UnitLabelUI.MainLabel.Text, '')
      verifyEqual(testcase, app.PhysicalValueUI.UnitAlias, "")
      verifyEqual(testcase, app.PhysicalValueUI.UnitText, "1")
      verifyEqual(testcase, app.PhysicalValueUI.UnitItems, "")
    end  % function

    function Gesture_UnitAlias_2(testcase)
      app = AppTest_PhysicalValueUI_UnitAlias_2_percent;

      verifyEqual(testcase, app.PhysicalValueUI.UnitLabelUI.MainLabel.Text, '\%')
      verifyEqual(testcase, app.PhysicalValueUI.UnitAlias, "\%")
      verifyEqual(testcase, app.PhysicalValueUI.UnitText, "1")
      verifyEqual(testcase, app.PhysicalValueUI.UnitItems, "\%")

      press(testcase, app.RefreshButtonUI.MainButton)

      verifyEqual(testcase, app.PhysicalValueUI.UnitLabelUI.MainLabel.Text, '\%')
      verifyEqual(testcase, app.PhysicalValueUI.UnitAlias, "\%")
      verifyEqual(testcase, app.PhysicalValueUI.UnitText, "1")
      verifyEqual(testcase, app.PhysicalValueUI.UnitItems, "\%")
    end  % function

    function Gesture_UnitItems_1(testcase)
      % 1. At first the app has "m/s" and "mph" in the unit drop down.
      % 2. Enter simscape.Value(1, "km/hr") to add "km/hr" to the drop down.
      % 3. Enter simscape.Value(3, "mph") to change the unit to "mph".
      % 4. Validate that "km/hr" is in the drop down items.
      app = AppTest_PhysicalValueUI_UnitItems_1;
      type(testcase, app.PhysicalValueUI_1.ValueTextUI.MainEditField, "simscape.Value(1, ""km/hr"")")
      type(testcase, app.PhysicalValueUI_1.ValueTextUI.MainEditField, "2")
      type(testcase, app.PhysicalValueUI_1.ValueTextUI.MainEditField, "simscape.Value(3, ""mph"")")
      type(testcase, app.PhysicalValueUI_1.ValueTextUI.MainEditField, "4")
      items = app.PhysicalValueUI_1.UnitDropDownUI.MainDropDown.Items;
      verifyEqual(testcase, items, {'m/s', 'mph', 'km/hr'})
    end  % function

  end  % methods
end  % classdef
