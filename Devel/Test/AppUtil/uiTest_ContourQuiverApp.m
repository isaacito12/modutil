classdef uiTest_ContourQuiverApp < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

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
      verifyWarningFree(testcase, @ContourQuiverApp)
    end  % function

    %%

    function basic_test_1(testcase)
      app = ContourQuiverApp;
      type(testcase, app.NumContourUI.ValueTextUI.MainEditField, "5")
      type(testcase, app.NumContourUI.ValueTextUI.MainEditField, "10")
      type(testcase, app.NumContourUI.ValueTextUI.MainEditField, "15")
    end  % function

    function basic_test_2(testcase)
      app = ContourQuiverApp;
      choose(testcase, app.CheckBoxUI.MainCheckBox, true)
      type(testcase, app.NumContourUI.ValueTextUI.MainEditField, "5")
      type(testcase, app.NumContourUI.ValueTextUI.MainEditField, "10")
      choose(testcase, app.CheckBoxUI.MainCheckBox, false)
    end  % function

    function basic_test_3(testcase)
      evalin("base", "k = 20;")

      app = ContourQuiverApp;
      type(testcase, app.NumContourUI.ValueTextUI.MainEditField, "k")

      evalin("base", "k = 5;")
      press(testcase, app.ButtonUI.MainButton)
    end  % function

    function basic_test_4(testcase)
      app = ContourQuiverApp;
      press(testcase, app.OpenFigUI.MainHyperlink)
    end  % function

    % -------------------------------------------------------------------------
    % Programmatically manipulate the app.

    function passing_test_1(~)
      evalin("base", "k = 20;")

      app = ContourQuiverApp;
      app.NumContourUI.ValueText = "k";
      app.UpdatePlot();

      app.CheckBoxUI.Value = true;

      evalin("base", "k = 5;")
      app.UpdatePlot();
    end  % function

  end  % methods
end  % classdef
