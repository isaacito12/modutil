classdef uiTest_PhysicalValueWithUnitLabel < matlab.uitest.TestCase
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

    % -------------------------------------------------------------------------
    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @DemoApp_PhysicalValueWithUnitLabel_1_simplest)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @DemoApp_PhysicalValueWithUnitLabel_2)
    end  % function

    function clean_launch_3(testcase)
      verifyWarningFree(testcase, @DemoApp_PhysicalValueWithUnitLabel_3)
    end  % function

    %% Test features

    function basic_feature_1(testcase)
      app = DemoApp_PhysicalValueWithUnitLabel_1_simplest;
      % At this point, the unit of the physical value UI is "1".

      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.initialized, true)
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.UnitText, "1")
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.UnitAlias, "")
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.ValueText, "")
    end  % function

    % -------------------------------------------------------------------------

    function basic_feature_2_1(testcase)
      app = DemoApp_PhysicalValueWithUnitLabel_2;

      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.UnitText, "m")
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.ValueText, "1.2")
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.SimscapeValue, simscape.Value(1.2, "m"))
    end  % function

    function basic_feature_2_2_gesture(testcase)
      app = DemoApp_PhysicalValueWithUnitLabel_2;

      type(testcase, app.PhysicalValueWithUnitLabel_1.ValueTextUI.MainEditField, "-3 + 3")
      info_text = app.PhysicalValueWithUnitLabel_1.InfoText;
      verifyEqual(testcase, info_text, "0")

      type(testcase, app.PhysicalValueWithUnitLabel_1.ValueTextUI.MainEditField, "sqrt([2 : 3 : 8]).^2")
      info_text = app.PhysicalValueWithUnitLabel_1.InfoText;
      verifyEqual(testcase, info_text, "[2, 5, 8]")

      type(testcase, app.PhysicalValueWithUnitLabel_1.ValueTextUI.MainEditField, "simscape.Value([1 2; 3 4], ""in"")")
      info_text = app.PhysicalValueWithUnitLabel_1.InfoText;
      verifyEqual(testcase, info_text, "[1, 2; 3, 4] (in)")

      type(testcase, app.PhysicalValueWithUnitLabel_1.ValueTextUI.MainEditField, "")
      info_text = app.PhysicalValueWithUnitLabel_1.InfoText;
      verifyEqual(testcase, info_text, "")
    end  % function

    function basic_feature_2_3_programmatic(testcase)
      app = DemoApp_PhysicalValueWithUnitLabel_2;

      app.PhysicalValueWithUnitLabel_1.ValueText = "-3";
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.ValueText, "-3")

      app.PhysicalValueWithUnitLabel_1.ValueText = "-3 + 4";
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.InfoText, "1")

      app.PhysicalValueWithUnitLabel_1.SimscapeValue = simscape.Value([2, 10], "in");
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.SimscapeValue, simscape.Value([2, 10], "in"))
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.UnitText, "in")
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.ValueText, "[2, 10]")
    end  % function

    function basic_feature_2_4_error_programmatic(testcase)
      app = DemoApp_PhysicalValueWithUnitLabel_2;

      app.PhysicalValueWithUnitLabel_1.ValueText = "0-";
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.hasError, true)

      app.PhysicalValueWithUnitLabel_1.ValueText = "1";
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.hasError, false)

      app.PhysicalValueWithUnitLabel_1.ValueText = "simscape.Value(nan, ""km/s"")";
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.hasError, true)

      app.PhysicalValueWithUnitLabel_1.ValueText = "simscape.Value(nan, ""mi"")";
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.hasError, false)
    end  % function

    function basic_feature_2_5_error_interactive(testcase)
      app = DemoApp_PhysicalValueWithUnitLabel_2;
      type(testcase, app.PhysicalValueWithUnitLabel_1.ValueTextUI.MainEditField, "0-")
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.hasError, true)
    end  % function

    function basic_feature_2_6_error_UnitText(testcase)
      app = DemoApp_PhysicalValueWithUnitLabel_2;
      verifyError(testcase, @test_target, "physmod:common:units:core:parse:UnrecognizedUnitName")
      function test_target
        app.PhysicalValueWithUnitLabel_1.UnitText = "invalid_text_for_testing";
      end  % function
    end  % function

    % -------------------------------------------------------------------------

    function basic_feature_3_1_error_interactive(testcase)
      app = DemoApp_PhysicalValueWithUnitLabel_3;

      type(testcase, app.PhysicalValueWithUnitLabel_1.ValueTextUI.MainEditField, "0-")
      type(testcase, app.PhysicalValueWithUnitLabel_2.ValueTextUI.MainEditField, "0-")
      type(testcase, app.PhysicalValueWithUnitLabel_3.ValueTextUI.MainEditField, "0-")

      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.hasError, true)
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_2.hasError, true)
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_3.hasError, true)

      type(testcase, app.PhysicalValueWithUnitLabel_1.ValueTextUI.MainEditField, "0")
      type(testcase, app.PhysicalValueWithUnitLabel_2.ValueTextUI.MainEditField, "0")
      type(testcase, app.PhysicalValueWithUnitLabel_3.ValueTextUI.MainEditField, "0")

      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_1.hasError, false)
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_2.hasError, false)
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_3.hasError, false)
    end  % function

    function basic_feature_3_2_callback(testcase)
      app = DemoApp_PhysicalValueWithUnitLabel_3;

      type(testcase, app.PhysicalValueWithUnitLabel_1.ValueTextUI.MainEditField, "1")
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_4.hasError, true)

      type(testcase, app.PhysicalValueWithUnitLabel_2.ValueTextUI.MainEditField, "2")
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_4.hasError, true)

      type(testcase, app.PhysicalValueWithUnitLabel_3.ValueTextUI.MainEditField, "0.1")
      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_4.hasError, false)

      verifyEqual(testcase, app.PhysicalValueWithUnitLabel_4.ValueText, "0.2")
    end  % function

    % function basic_feature_3_3_error_UnitAlias(testcase)
    %   app = DemoApp_PhysicalValueWithUnitLabel_3;
    %   verifyError(testcase, @test_target, "")
    %   function test_target
    %     app.PhysicalValueWithUnitLabel_3.UnitAlias = "invalid_text_for_testing";
    %   end  % function
    % end  % function

  end  % methods
end  % classdef
