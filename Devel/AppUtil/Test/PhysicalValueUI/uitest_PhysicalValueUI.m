classdef uitest_PhysicalValueUI < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2025 The MathWorks, Inc.

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
      function closeAll
        % Delete the app's figure object from memory.
        if class(testcase.App) ~= "double"
          if isstruct(testcase.App) && not(isfield(testcase.App, "Window"))
            % Function-based app with no window to delete.

            return

          end  % if
          delete(testcase.App.Window.MainFigure)
        end  % if
        close all
        bdclose all
      end  % nested function

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAll)

      close all
      bdclose all
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
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_PhysicalValueUI_1_simplest;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_PhysicalValueUI_2;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_PhysicalValueUI_Refresh_1;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_4(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_PhysicalValueUI_Refresh_2;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_5(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_PhysicalValueUI_SimscapeValue;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_6(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_PhysicalValueUI_UnitAlias_1_empty;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_7(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_PhysicalValueUI_UnitAlias_2_percent;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_8(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_PhysicalValueUI_UnitItems_1;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_9(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_PhysicalValueUI_UnitText_1;  % !test-target
      end  % nested function
    end  % function

    %% Test

    function Test_1(testcase)
      testcase.App = apptest_PhysicalValueUI_SimscapeValue;

      verifyEqual(testcase, testcase.App.PhysValUI_1.ValueText, "2.3")
      verifyEqual(testcase, simscape.Unit(testcase.App.PhysValUI_1.UnitText), simscape.Unit("ms"))

      verifyEqual(testcase, testcase.App.PhysValUI_2.ValueText, "-4")
      verifyEqual(testcase, simscape.Unit(testcase.App.PhysValUI_2.UnitText), simscape.Unit("lbf*in"))

    end  % function

    %% Gesture test

    function Gesture_UnitAlias_1(testcase)
      testcase.App = apptest_PhysicalValueUI_UnitAlias_1_empty;

      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitLabelUI.MainLabel.Text, '')
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitAlias, "")
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitText, "1")
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitItems, "")

      press(testcase, testcase.App.RefreshButtonUI.MainButton)

      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitLabelUI.MainLabel.Text, '')
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitAlias, "")
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitText, "1")
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitItems, "")
    end  % function

    function Gesture_UnitAlias_2(testcase)
      testcase.App = apptest_PhysicalValueUI_UnitAlias_2_percent;

      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitLabelUI.MainLabel.Text, '\%')
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitAlias, "\%")
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitText, "1")
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitItems, "\%")

      press(testcase, testcase.App.RefreshButtonUI.MainButton)

      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitLabelUI.MainLabel.Text, '\%')
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitAlias, "\%")
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitText, "1")
      verifyEqual(testcase, testcase.App.PhysicalValueUI.UnitItems, "\%")
    end  % function

    function Gesture_UnitItems_1(testcase)
      % 1. At first the app has "m/s" and "mph" in the unit drop down.
      % 2. Enter simscape.Value(1, "km/hr") to add "km/hr" to the drop down.
      % 3. Enter simscape.Value(3, "mph") to change the unit to "mph".
      % 4. Validate that "km/hr" is in the drop down items.
      testcase.App = apptest_PhysicalValueUI_UnitItems_1;
      type(testcase, testcase.App.PhysicalValueUI.ValueTextUI.MainEditField, "simscape.Value(1, ""km/hr"")")
      type(testcase, testcase.App.PhysicalValueUI.ValueTextUI.MainEditField, "2")
      type(testcase, testcase.App.PhysicalValueUI.ValueTextUI.MainEditField, "simscape.Value(3, ""mph"")")
      type(testcase, testcase.App.PhysicalValueUI.ValueTextUI.MainEditField, "4")
      items = testcase.App.PhysicalValueUI.UnitDropDownUI.MainDropDown.Items;
      verifyEqual(testcase, items, {'m/s', 'mph', 'km/hr'})
    end  % function

    %% Color theme
    % Take screenshots of the app. Visually inspect the saved images.

    function LightTheme_1(testcase)
      testcase.App = apptest_PhysicalValueUI_1_simplest;
      drawnow
      if not(isMATLABReleaseOlderThan("R2025a"))
        testcase.App.Window.MainFigure.Theme = "light";
      end  % if
      save_path = fullfile(pwd, "screenshot-testing-light-1.png");
      exportapp(testcase.App.Window.MainFigure, save_path)
    end  % function

    function DarkTheme_1(testcase)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      testcase.App = apptest_PhysicalValueUI_1_simplest;
      drawnow
      testcase.App.Window.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-1.png");
      exportapp(testcase.App.Window.MainFigure, save_path)
    end  % function

  end  % methods
end  % classdef
