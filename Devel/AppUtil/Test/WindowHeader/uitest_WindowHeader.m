classdef uitest_WindowHeader < matlab.uitest.TestCase
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
        testcase.App = apptest_WindowHeader_1_simplest;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_WindowHeader_2_no_MainFigure;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = apptest_WindowHeader_3;  % !test-target
      end  % nested function
    end  % function

    %% Gesture test

    function Gesture_1(testcase)
      % 1. Click the "Source" link in the window header, which opens the source file in the editor.
      % 2. (Close the source file.)
      % 3. Check that the expected file opened.
      % For the documentation about the matlab.desktop.editor commands, type
      % "help matlab.desktop.editor" in the command window.
      testcase.App = apptest_WindowHeader_3;
      press(testcase, testcase.App.WindowHeaderUI.SourceLinkUI.MainHyperlink)  % !attention: locally works, but can fail in CI.
      currentfile_fullpath = matlab.desktop.editor.getActiveFilename;
      close(matlab.desktop.editor.getActive)
      [~, actual_basefilename, ~] = fileparts(currentfile_fullpath);
      expected_basefilename = testcase.App.WindowHeaderUI.AppSourceName;
      verifyEqual(testcase, string(actual_basefilename), expected_basefilename)
    end  % function

    %% Color theme
    % Take screenshots of the app. Visually inspect the saved images.

    function LightTheme_1(testcase)
      testcase.App = apptest_WindowHeader_3;
      drawnow
      if not(isMATLABReleaseOlderThan("R2025a"))
        testcase.App.MainFigure.Theme = "light";
      end  % if
      save_path = fullfile(pwd, "screenshot-testing-light-1.png");
      exportapp(testcase.App.MainFigure, save_path)
    end  % function

    function DarkTheme_1(testcase)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      testcase.App = apptest_WindowHeader_3;
      drawnow
      testcase.App.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-1.png");
      exportapp(testcase.App.MainFigure, save_path)
    end  % function

  end  % methods
end  % classdef
