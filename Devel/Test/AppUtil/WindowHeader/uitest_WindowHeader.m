classdef uitest_WindowHeader < matlab.uitest.TestCase
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

  properties
    % Some of the tests in this class run only if test is running locally under the LocalTopFolder.
    LocalTopFolder (1,1) pattern = "C:\local"
  end  % properties

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
      verifyWarningFree(testcase, @apptest_WindowHeader_1_simplest)
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @apptest_WindowHeader_2_no_MainFigure)
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @apptest_WindowHeader_3)
    end  % function

    %% Gesture test

    function Gesture_1(testcase)
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping (the test is not running within the specified local path.)")

        return

      end  %if

      % 1. Click the "Source" link in the window header, which opens the source file in the editor.
      % 2. (Close the source file.)
      % 3. Check that the expected file opened.
      % For the documentation about the matlab.desktop.editor commands, type
      % "help matlab.desktop.editor" in the command window.
      app = apptest_WindowHeader_3;
      press(testcase, app.WindowHeaderUI.SourceLinkUI.MainHyperlink)  % !attention: locally works, but can fail in CI.
      currentfile_fullpath = matlab.desktop.editor.getActiveFilename;
      close(matlab.desktop.editor.getActive)
      [~, actual_basefilename, ~] = fileparts(currentfile_fullpath);
      expected_basefilename = app.WindowHeaderUI.AppSourceName;
      verifyEqual(testcase, string(actual_basefilename), expected_basefilename)
    end  % function

    %% Color theme
    % Take screenshots of the app. Visually inspect the saved images.

    function LightTheme_1(~)
      app = apptest_WindowHeader_3;
      drawnow
      if not(isMATLABReleaseOlderThan("R2025a"))
        app.MainFigure.Theme = "light";
      end  % if
      save_path = fullfile(pwd, "screenshot-testing-light-1.png");
      exportapp(app.MainFigure, save_path)
    end  % function

    function DarkTheme_1(~)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      app = apptest_WindowHeader_3;
      drawnow
      app.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-1.png");
      exportapp(app.MainFigure, save_path)
    end  % function

  end  % methods
end  % classdef
