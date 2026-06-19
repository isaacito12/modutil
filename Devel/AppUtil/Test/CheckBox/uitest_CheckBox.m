classdef uitest_CheckBox < matlab.uitest.TestCase
  %% Class-based unit test for app

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
          delete(testcase.App.MainFigure)
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
        testcase.App = apptest_CheckBox_1_simplest;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_CheckBox_2_align_inside;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_CheckBox_3_tiling;  % !test-target
      end  % nested function
    end  % function

    %% Gesture test

    function Gesture_1(testcase)
      % The state of check box after pressing twice must be the same as the initial state.
      testcase.App = apptest_CheckBox_1_simplest;
      v1 = testcase.App.CheckBoxUI.Value;
      press(testcase, testcase.App.CheckBoxUI.MainCheckBox)
      press(testcase, testcase.App.CheckBoxUI.MainCheckBox)
      v2 = testcase.App.CheckBoxUI.Value;
      verifyEqual(testcase, v1, v2)
    end  % function

    %% Color theme
    % Take screenshots of the app. Visually inspect the saved images.

    function LightTheme_1(testcase)
      testcase.App = apptest_CheckBox_1_simplest;
      if not(isMATLABReleaseOlderThan("R2025a"))
        testcase.App.MainFigure.Theme = "light";
      end  % if
      save_path = fullfile(pwd, "screenshot-testing-light-1.png");
      exportapp(testcase.App.MainFigure, save_path)
    end  % function

    function LightTheme_2(testcase)
      testcase.App = apptest_CheckBox_2_align_inside;
      if not(isMATLABReleaseOlderThan("R2025a"))
        testcase.App.MainFigure.Theme = "light";
      end  % if
      save_path = fullfile(pwd, "screenshot-testing-light-2.png");
      exportapp(testcase.App.MainFigure, save_path)
    end  % function

    function LightTheme_3(testcase)
      testcase.App = apptest_CheckBox_3_tiling;
      if not(isMATLABReleaseOlderThan("R2025a"))
        testcase.App.MainFigure.Theme = "light";
      end  % if
      save_path = fullfile(pwd, "screenshot-testing-light-3.png");
      exportapp(testcase.App.MainFigure, save_path)
    end  % function

    function DarkTheme_1(testcase)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      testcase.App = apptest_CheckBox_1_simplest;
      testcase.App.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-1.png");
      exportapp(testcase.App.MainFigure, save_path)
    end  % function

    function DarkTheme_2(testcase)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      testcase.App = apptest_CheckBox_2_align_inside;
      testcase.App.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-2.png");
      exportapp(testcase.App.MainFigure, save_path)
    end  % function

    function DarkTheme_3(testcase)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      testcase.App = apptest_CheckBox_3_tiling;
      testcase.App.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-3.png");
      exportapp(testcase.App.MainFigure, save_path)
    end  % function

  end  % methods
end  % classdef
