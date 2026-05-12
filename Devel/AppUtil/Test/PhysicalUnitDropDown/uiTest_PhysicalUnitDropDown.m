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

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @DemoApp_PhysicalUnitDropDown_1_simplest)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @DemoApp_PhysicalUnitDropDown_2)
    end  % function

    % -------------------------------------------------------------------------
    % Test UnitText.

    function set_UnitText_1_startup(testcase)
      main_figure = uifigure(Visible="off");
      main_figure.Name = "Test";
      main_figure.Position(3:4) = [500, 300];  % width, height
      main_v_container = AppUtil1.VerticalContainer(main_figure);
      v_layout = addVerticalGridLayout(main_v_container);

      dropdown_1 = AppUtil1.Component.PhysicalUnitDropDown(v_layout);

      verifyEqual(testcase, dropdown_1.UnitSpecified, false)

      % Allow to define UnitText before defining UnitItems.
      % This sets UnitSpecified to be true.
      dropdown_1.UnitText = "s";

      verifyEqual(testcase, dropdown_1.UnitSpecified, true)

      % After UnitSpecified is set to true, UnitItems can't be directly modified.
      verifyError(testcase, @test_target, "PhysicalUnitDropDown:UnitItemsAlreadyDefined")
      function test_target
        dropdown_1.UnitItems = ["s", "min"];
      end  % nested function

      % It is still possible to specify a commensurate unit for UnitText.
      % This grows the UnitItems.
      dropdown_1.UnitText = "min";

      verifyEqual(testcase, dropdown_1.UnitItems, ["s", "min"])

    end  % function

    function set_UnitText_error_1_startup(testcase)
      main_figure = uifigure(Visible="off");
      main_figure.Name = "Test";
      main_figure.Position(3:4) = [500, 300];  % width, height
      main_v_container = AppUtil1.VerticalContainer(main_figure);
      v_layout = addVerticalGridLayout(main_v_container);

      dropdown_1 = AppUtil1.Component.PhysicalUnitDropDown(v_layout);
      dropdown_1.UnitItems = ["m/s", "mph"];

      verifyError(testcase, @test_target, "PhysicalUnitDropDown:physmod:common:units:core:parse:UnitSyntaxError")
      function test_target
        % Assign a wrong text.
        dropdown_1.UnitText = "-";
      end  % nested function
    end  % function

    function set_UnitText_error_2(~)
      app = DemoApp_PhysicalUnitDropDown_1_simplest;
      % At this point, the defined unit is "1".

      % Enter a wrong text.
      app.PhysicalUnitDropDown_1.UnitText = "m";
      % The error pop-up window must open. (Visually inspect.)
    end  % function

    function set_UnitText_get_UnitText_1(testcase)
      app = DemoApp_PhysicalUnitDropDown_2;
      % At this point, the defined unit is "m/s".

      app.PhysicalUnitDropDown_1.UnitText = "mph";
      verifyEqual(testcase, app.PhysicalUnitDropDown_1.UnitText, "mph")

      app.PhysicalUnitDropDown_1.UnitText = "m/s";
      verifyEqual(testcase, app.PhysicalUnitDropDown_1.UnitText, "m/s")
    end  % function

    % -------------------------------------------------------------------------
    % Test UnitItems

    function set_UnitItems_error_1_startup(testcase)
      main_figure = uifigure(Visible="off");
      main_figure.Name = "Test";
      main_figure.Position(3:4) = [500, 300];  % width, height
      main_v_container = AppUtil1.VerticalContainer(main_figure);
      v_layout = addVerticalGridLayout(main_v_container);
      dropdown_1 = AppUtil1.Component.PhysicalUnitDropDown(v_layout);

      verifyError(testcase, @test_target, "PhysicalUnitDropDown:InvalidUnitItems")
      function test_target
        % Specify a wrong text.
        dropdown_1.UnitItems = "-";
      end  % nested function
    end  % function

    function set_UnitItems_error_2_startup(testcase)
      main_figure = uifigure(Visible="off");
      main_figure.Name = "Test";
      main_figure.Position(3:4) = [500, 300];  % width, height
      main_v_container = AppUtil1.VerticalContainer(main_figure);
      v_layout = addVerticalGridLayout(main_v_container);
      dropdown_1 = AppUtil1.Component.PhysicalUnitDropDown(v_layout);

      verifyError(testcase, @test_target, "PhysicalUnitDropDown:InvalidUnitItems")
      function test_target
        % Specify a wrong text in a string array.
        dropdown_1.UnitItems = ["m", "s", "-"];
      end  % nested function
    end  % function

    function set_UnitItems_error_3(testcase)
      main_figure = uifigure(Visible="off");
      main_figure.Name = "Test";
      main_figure.Position(3:4) = [500, 300];  % width, height
      main_v_container = AppUtil1.VerticalContainer(main_figure);
      v_layout = addVerticalGridLayout(main_v_container);
      dropdown_1 = AppUtil1.Component.PhysicalUnitDropDown(v_layout);
      dropdown_1.UnitItems = ["s", "min"];

      verifyError(testcase, @test_target, "PhysicalUnitDropDown:UnitItemsAlreadyDefined")
      function test_target
        % Specify UnitItems again, which is not allowed.
        dropdown_1.UnitItems = ["rad/s", "rpm"];
      end  % nested function

      % UnitItems must keep the previous setting.
      verifyEqual(testcase, dropdown_1.UnitItems, ["s", "min"])
    end  % function

    %% Basic gesture tests

    function GestureTest_1(testcase)
      app = DemoApp_PhysicalUnitDropDown_2;
      choose(testcase, app.PhysicalUnitDropDown_1.DropDownUI.MainDropDown, "mph")
      choose(testcase, app.PhysicalUnitDropDown_1.DropDownUI.MainDropDown, "m/s")
      choose(testcase, app.PhysicalUnitDropDown_1.DropDownUI.MainDropDown, "mph")
    end  % function

  end  % methods
end  % classdef
