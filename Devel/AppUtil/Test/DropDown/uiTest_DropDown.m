classdef uiTest_DropDown < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

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

    % -------------------------------------------------------------------------
    % Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @DemoApp_DropDown_1_simplest)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @DemoApp_DropDown_2_editable_off)
    end  % function

    function clean_launch_3(testcase)
      verifyWarningFree(testcase, @DemoApp_DropDown_3_editable_on)
    end  % function

    function clean_launch_4(testcase)
      verifyWarningFree(testcase, @DemoApp_DropDown_4_align)
    end  % function

    % -------------------------------------------------------------------------
    % Tests with app 1

    function choose_1(testcase)
      app = DemoApp_DropDown_1_simplest;

      choose(testcase, app.DropDownUI_1.MainDropDown, "Item 2")
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, "Item 2")

      choose(testcase, app.DropDownUI_1.MainDropDown, "Item 1")
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, "Item 1")

      choose(testcase, app.DropDownUI_1.MainDropDown, "Item 2")
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, "Item 2")

    end  % function

    % -------------------------------------------------------------------------
    % Tests with app 2

    function callback_2_1(testcase)
      app = DemoApp_DropDown_2_editable_off;

      press(testcase, app.ButtonUI_1.MainButton)
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, "Item 4")

      choose(testcase, app.DropDownUI_1.MainDropDown, "Item 3")
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, "Item 3")

      press(testcase, app.ButtonUI_1.MainButton)
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, "Item 5")
    end  % function

    % -------------------------------------------------------------------------
    % Tests with app 3

    function test_3(testcase)
      app = DemoApp_DropDown_3_editable_on;

      % Append item.
      press(testcase, app.ButtonUI_1.MainButton)
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, "Item 3")

      choose(testcase, app.DropDownUI_1.MainDropDown, "Item 1")
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, "Item 1")

      % Interactively add a new item. It must be appended.
      type(testcase, app.DropDownUI_1.MainDropDown, "typed")
      verifyEqual(testcase, numel(app.DropDownUI_1.Items), 4)
      x = app.DropDownUI_1.Items(end);
      verifyEqual(testcase, x, "typed")

      choose(testcase, app.DropDownUI_1.MainDropDown, "Item 2")
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, "Item 2")

      % Remove the last item. The updated last item must be selected.
      press(testcase, app.ButtonUI_2.MainButton)
      x = app.DropDownUI_1.Value;
      verifyEqual(testcase, x, app.DropDownUI_1.Items(end))
    end  % function

  end  % methods
end  % classdef
