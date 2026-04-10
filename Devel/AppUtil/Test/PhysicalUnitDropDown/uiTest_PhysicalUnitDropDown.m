classdef uiTest_PhysicalUnitDropDown < matlab.uitest.TestCase
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

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function app_launches_without_warnings_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        DemoApp_PhysicalUnitDropDown_1  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        DemoApp_PhysicalUnitDropDown_2  % !test-target
      end  % nested function
    end  % function

    %% Error case tests

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "PhysicalUnitDropDown:UnitItemsAlreadyDefined")
      function test_target
        app = DemoApp_PhysicalUnitDropDown_2;

        % UnitItems is already defined with the app code.
        % Overriding the UnitItems must results in an error.
        app.PhysicalUnitDropDownUI.UnitItems = ["s", "min"];  % !test-target

      end  % nested function
    end  % function

    %% Basic gesture tests

    function GestureTest_1(testcase)
      app = DemoApp_PhysicalUnitDropDown_2;
      choose(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "in")  % !test-target
      choose(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "m")  % !test-target
      choose(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "in")  % !test-target
    end  % function

    %% Attempt to specify invalid unit text
    % Set a unit which is not commensurate with the defined units.
    % The attempt must result in an error pop-up dialog showing up, and
    % the app must keep the current drop down list and the unit text.

    function Test_1_1(testcase)
      app = DemoApp_PhysicalUnitDropDown_2;

      % Programmatic
      app.PhysicalUnitDropDownUI.UnitText = "N";  % !test-target

      % The app must reject the newly specified UnitText and keep UnitItems and UnitText intact.
      unit_items = app.PhysicalUnitDropDownUI.UnitItems;
      verifyEqual(testcase, unit_items, ["m", "in"])

      unit_text = app.PhysicalUnitDropDownUI.UnitText;
      verifyEqual(testcase, unit_text, "m")

    end  % function

    function Test_1_2(testcase)
      app = DemoApp_PhysicalUnitDropDown_2;

      % Interactive
      type(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "N")  % !test-target

      % The app must reject the newly specified UnitText and keep UnitItems and UnitText intact.
      unit_items = app.PhysicalUnitDropDownUI.UnitItems;
      verifyEqual(testcase, unit_items, ["m", "in"])

      unit_text = app.PhysicalUnitDropDownUI.UnitText;
      verifyEqual(testcase, unit_text, "m")

    end  % function

    function Test_1_3(testcase)
      app = DemoApp_PhysicalUnitDropDown_2;

      % Programmatic
      app.PhysicalUnitDropDownUI.UnitText = "aaa";  % !test-target

      % The app must reject the newly specified UnitText and keep UnitItems and UnitText intact.
      unit_items = app.PhysicalUnitDropDownUI.UnitItems;
      verifyEqual(testcase, unit_items, ["m", "in"])

      unit_text = app.PhysicalUnitDropDownUI.UnitText;
      verifyEqual(testcase, unit_text, "m")

    end  % function

    function Test_1_4(testcase)
      app = DemoApp_PhysicalUnitDropDown_2;

      % Interactive
      type(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "aaa")  % !test-target

      % The app must reject the newly specified UnitText and keep UnitItems and UnitText intact.
      unit_items = app.PhysicalUnitDropDownUI.UnitItems;
      verifyEqual(testcase, unit_items, ["m", "in"])

      unit_text = app.PhysicalUnitDropDownUI.UnitText;
      verifyEqual(testcase, unit_text, "m")

    end  % function


    %% Add commensurate units

    function Test_2_1(testcase)
      app = DemoApp_PhysicalUnitDropDown_2;

      % Programmatic
      app.PhysicalUnitDropDownUI.UnitText = "km";  % !test-target

      % The app must add the newly specified UnitText at the end of the unti items list.
      unit_items = app.PhysicalUnitDropDownUI.UnitItems;
      verifyEqual(testcase, unit_items, ["m", "in", "km"])

      unit_text = app.PhysicalUnitDropDownUI.UnitText;
      verifyEqual(testcase, unit_text, "km")

      choose(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "in")  % !test-target
      choose(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "m")  % !test-target
      choose(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "km")  % !test-target

    end  % function

    function Test_2_2(testcase)
      app = DemoApp_PhysicalUnitDropDown_2;

      % Interactive
      type(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "km")  % !test-target

      % The app must add the newly specified UnitText at the end of the unti items list.
      unit_items = app.PhysicalUnitDropDownUI.UnitItems;
      verifyEqual(testcase, unit_items, ["m", "in", "km"])

      unit_text = app.PhysicalUnitDropDownUI.UnitText;
      verifyEqual(testcase, unit_text, "km")

      choose(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "in")  % !test-target
      choose(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "m")  % !test-target
      choose(testcase, app.PhysicalUnitDropDownUI.EditableDropDownUI.MainDropDown, "km")  % !test-target

    end  % function

  end  % methods
end  % classdef
