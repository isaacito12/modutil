classdef uiTest_PhysicalValueWithUnitDropDown < matlab.uitest.TestCase
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

    % -------------------------------------------------------------------------
    % Demo app 1

    function app1_clean_launch(testcase)
      % Minimum quality check.
      % Check that models, scripts, functions, and classes run right out of the box.

      % Warnings can be displayed even when the app opens and starts working seemingly normally.
      % Make sure there is no warning when opening an app.
      verifyWarningFree(testcase, @DemoApp_PhysicalValueWithUnitDropDown_1_simplest)
    end  % function

    function app1_default_states_1(testcase)
      app = DemoApp_PhysicalValueWithUnitDropDown_1_simplest;
      % At this point, the unit of the physical value UI is "1".

      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.initialized, true)
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.UnitText, "1")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.ValueText, "")
    end  % function

    function app1_basic_1(testcase)
      app = DemoApp_PhysicalValueWithUnitDropDown_1_simplest;
      % At this point, the unit of the physical value UI is "1".

      type(testcase, app.PhysicalValueWithUnitDropDown_1.ValueTextUI.MainEditField, "2.3")
      type(testcase, app.PhysicalValueWithUnitDropDown_1.ValueTextUI.MainEditField, "1 - 2")
    end  % function

    function app1_error_1(testcase)
      app = DemoApp_PhysicalValueWithUnitDropDown_1_simplest;
      % At this point, the unit of the physical value UI is "1".

      % Programmatically specify wrong text.
      app.PhysicalValueWithUnitDropDown_1.ValueText = "---";
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.hasError, true)

      % Remove the error.
      app.PhysicalValueWithUnitDropDown_1.ValueText = "-4";
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.hasError, false)

      % Interactively specify wrong text.
      type(testcase, app.PhysicalValueWithUnitDropDown_1.ValueTextUI.MainEditField, "0-")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.hasError, true)
    end  % function

    % -------------------------------------------------------------------------
    % Demo app 2

    function app2_clean_launch(testcase)
      % Minimum quality check.
      % Check that models, scripts, functions, and classes run right out of the box.

      % Warnings can be displayed even when the app opens and starts working seemingly normally.
      % Make sure there is no warning when opening an app.
      verifyWarningFree(testcase, @DemoApp_PhysicalValueWithUnitDropDown_2)
    end  % function

    function app2_basic_feature_1(testcase)
      app = DemoApp_PhysicalValueWithUnitDropDown_2;

      % Get unit text, value text, and simscape.Value.
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.UnitText, "min")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.ValueText, "2")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.SimscapeValue, simscape.Value(2, "min"))

      choose(testcase, app.PhysicalValueWithUnitDropDown_1.UnitDropDownUI.DropDownUI.MainDropDown, "s")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.SimscapeValue, simscape.Value(2, "s"))

    end  % function

    function app2_basic_feature_2(testcase)
      app = DemoApp_PhysicalValueWithUnitDropDown_2;

      % Adding a new element is blocked, even if it is a commensurate unit.
      % This triggers a pop-up error window. (Must visually inspect.)
      app.PhysicalValueWithUnitDropDown_1.UnitText = "hr";

      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.UnitItems, ["s", "min"])

      % This also triggers a pop-up error window. (Must visually inspect.)
      app.PhysicalValueWithUnitDropDown_1.SimscapeValue = simscape.Value(-1, "hr");
    end  % function

    function app2_basic_feature_3(testcase)
      % Create a struct in the base workspace.
      % Define a parameter in the struct using simscape.Value.
      evalin("base", "params = struct; params.A = simscape.Value(5, ""min"");")

      app = DemoApp_PhysicalValueWithUnitDropDown_2;

      % Access the base workspace data from the app.
      type(testcase, app.PhysicalValueWithUnitDropDown_1.ValueTextUI.MainEditField, "params.A")
      
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.SimscapeValue, simscape.Value(5, "min"))
    end  % function

    function app2_error_1(testcase)
      app = DemoApp_PhysicalValueWithUnitDropDown_2;

      verifyError(testcase, @test_target, "physmod:common:units:core:parse:UnitSyntaxError")
      function test_target
        % Add a wrong unit text through UnitText.
        app.PhysicalValueWithUnitDropDown_1.UnitText = "-";
      end  % function
    end  % function

    function app2_error_2(testcase)
      app = DemoApp_PhysicalValueWithUnitDropDown_2;

      verifyError(testcase, @test_target, "PhysicalValue:set_UnitText:UnitIsNotCommensurate")
      function test_target
        % Add a unit which is not commensurate.
        app.PhysicalValueWithUnitDropDown_1.UnitText = "rad/s";
      end  % function
    end  % function

    % -------------------------------------------------------------------------
    % Demo app 3

    function app3_clean_launch(testcase)
      % Minimum quality check.
      % Check that models, scripts, functions, and classes run right out of the box.

      % Warnings can be displayed even when the app opens and starts working seemingly normally.
      % Make sure there is no warning when opening an app.
      verifyWarningFree(testcase, @DemoApp_PhysicalValueWithUnitDropDown_3)
    end  % function

    function app3_basic_feature_1(testcase)
      app = DemoApp_PhysicalValueWithUnitDropDown_3;

      % Get unit text, value text, and simscape.Value.
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.UnitText, "s")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.ValueText, "2")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.SimscapeValue, simscape.Value(2, "s"))

      choose(testcase, app.PhysicalValueWithUnitDropDown_1.UnitDropDownUI.DropDownUI.MainDropDown, "min")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_1.SimscapeValue, simscape.Value(2, "min"))

      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_2.UnitText, "m/s")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_2.ValueText, "-pi")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_2.SimscapeValue, simscape.Value(-pi, "m/s"))

      choose(testcase, app.PhysicalValueWithUnitDropDown_2.UnitDropDownUI.DropDownUI.MainDropDown, "km/min")
      verifyEqual(testcase, app.PhysicalValueWithUnitDropDown_2.SimscapeValue, simscape.Value(-pi, "km/min"))
    end  % function

  end  % methods
end  % classdef
