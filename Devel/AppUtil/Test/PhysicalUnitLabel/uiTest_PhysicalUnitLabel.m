classdef uiTest_PhysicalUnitLabel < matlab.uitest.TestCase
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
<<<<<<< HEAD
     evalin("base", "clearvars")
=======
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3

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
      verifyWarningFree(testcase, @DemoApp_PhysicalUnitLabel_1_simplest)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @test_target)
      function test_target
        DemoApp_PhysicalUnitLabel_2_StartupError(EnableStartupError=false)  % !test-target
      end  % nested function
    end  % function

    %% Test startup error

    function app_startup_1_ok(testcase)
      verifyWarningFree(testcase, @test_target)
      function test_target
        DemoApp_PhysicalUnitLabel_2_StartupError(EnableStartupError=false)  % !test-target
      end  % nested function
    end  % function

    function app_startup_2_error(testcase)
      verifyError(testcase, @test_target, "PhysicalUnitLabel:UnitMustBeCommensurate")
      function test_target
        DemoApp_PhysicalUnitLabel_2_StartupError(EnableStartupError=true)  % !test-target
      end  % nested function
    end  % function

    function app_startup_3_error(testcase)
      app = DemoApp_PhysicalUnitLabel_1_simplest;
      app.PhysicalUnitLabel_1.Reporting = "on";

      % At this point, unit and alias are not specified.
      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitSpecified, false)
      verifyEqual(testcase, app.PhysicalUnitLabel_1.AliasSpecified, false)

      % Specify alias.
      app.PhysicalUnitLabel_1.UnitAlias = "\%";

      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitSpecified, true)
      verifyEqual(testcase, app.PhysicalUnitLabel_1.AliasSpecified, true)

      verifyError(testcase, @test_target, "PhysicalUnitLabel:InvalidUnitForAlias")
      function test_target

        % Assign unit text which is not "1". It is not allowed when alias is defined.
        app.PhysicalUnitLabel_1.UnitText = "s";

      end  % nested function
    end  % function

    %% Test features

    function feature_1(testcase)
      app = DemoApp_PhysicalUnitLabel_1_simplest;
      app.PhysicalUnitLabel_1.Reporting = "on";
      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitSpecified, false)
      verifyEqual(testcase, app.PhysicalUnitLabel_1.AliasSpecified, false)
      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitText, "1")
      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitAlias, "")
    end  % function

    function feature_2(testcase)
      app = DemoApp_PhysicalUnitLabel_1_simplest;
      app.PhysicalUnitLabel_1.Reporting = "on";

      app.PhysicalUnitLabel_1.UnitText = "m";

      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitSpecified, true)
      verifyEqual(testcase, app.PhysicalUnitLabel_1.AliasSpecified, false)
      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitText, "m")
      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitAlias, "")
    end  % function

    function feature_3(testcase)
      app = DemoApp_PhysicalUnitLabel_1_simplest;
      app.PhysicalUnitLabel_1.Reporting = "on";

      app.PhysicalUnitLabel_1.UnitAlias = "\%";

      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitText, "1")
      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitAlias, "\%")
      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitSpecified, true)
      verifyEqual(testcase, app.PhysicalUnitLabel_1.AliasSpecified, true)

      app.PhysicalUnitLabel_1.UnitAlias = "";

      % At this point, unit and alias must be still specified.
      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitSpecified, true)
      verifyEqual(testcase, app.PhysicalUnitLabel_1.AliasSpecified, true)
    end  % function

    function feature_4(testcase)
      app = DemoApp_PhysicalUnitLabel_1_simplest;
      app.PhysicalUnitLabel_1.Reporting = "on";

      app.PhysicalUnitLabel_1.UnitText = "m";

      % Assigning a commensurate unit should work.
      app.PhysicalUnitLabel_1.UnitText = "in";

      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitText, "in")
    end  % function

    function feature_5(testcase)
      app = DemoApp_PhysicalUnitLabel_1_simplest;
      app.PhysicalUnitLabel_1.Reporting = "on";

      app.PhysicalUnitLabel_1.UnitAlias = "\%";

      % Assigning "1" to UnitText must work when UnitAlias is defined.
      app.PhysicalUnitLabel_1.UnitText = "1";

      verifyEqual(testcase, app.PhysicalUnitLabel_1.UnitSpecified, true)
      verifyEqual(testcase, app.PhysicalUnitLabel_1.AliasSpecified, true)
    end  % function

    %% Test error cases

    function error_1(testcase)
      app = DemoApp_PhysicalUnitLabel_1_simplest;
      app.PhysicalUnitLabel_1.Reporting = "on";

      verifyError(testcase, @test_target, "PhysicalUnitLabel:UnitMustBeCommensurate")
      function test_target

        % Specify a wrong unit.
        app.PhysicalUnitLabel_1.UnitText = "098";

      end  % nested function
    end  % function

    function error_2_catch_in_uialert(~)
      app = DemoApp_PhysicalUnitLabel_1_simplest;
      app.PhysicalUnitLabel_1.Reporting = "on";

      app.PhysicalUnitLabel_1.UnitText = "m";

      try
        % Specify unit alias. At this point, unit is already defined, thus this is an error.
        % Compare HasUIError before and after the second assignment to UnitText.
        app.PhysicalUnitLabel_1.UnitAlias = "\%";  % Error. Unit, which is not "1", is already defined.
        
      catch exception
<<<<<<< HEAD
        uialert(app.MainFigure, exception.message, "Error")
=======
        uialert(app.Window.MainFigure, exception.message, "Error")
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
      end
    end  % function

    %% Test callback

    function callback_1(~)
      app = DemoApp_PhysicalUnitLabel_3_callback;
      app.PhysicalUnitLabel_1.Reporting = "on";

      % Assignment to UnitText triggers a callback, which displays info in Command Window.
      % Visually inspect the outputs.
      app.PhysicalUnitLabel_1.UnitText = "km";
      app.PhysicalUnitLabel_2.UnitText = "hr";
    end  % function

  end  % methods
end  % classdef
