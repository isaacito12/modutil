classdef uiTest_HorizontalContainer < matlab.uitest.TestCase
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

    function app_launches_without_warnings_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_HorizontalContainer_1  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        AppTest_HorizontalContainer_2  % !test-target
      end  % nested function
    end  % function

    %% Color theme
    % Take screenshots of the app. Visually inspect the saved images.

    function DarkTheme_1(~)
      if isMATLABReleaseOlderThan("R2025a")
        disp("!skipping")

        return

      end  % if
      app = AppTest_HorizontalContainer_1;
      app.Window.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-AppTest_HorizontalContainer_1-dark-1.png");
      exportapp(app.Window.MainFigure, save_path)
    end  % function

    function LightTheme_1(~)
      app = AppTest_HorizontalContainer_1;
      if isMATLABReleaseOlderThan("R2025a")
        save_path = fullfile(pwd, "screenshot-AppTest_HorizontalContainer_1-24b-1.png");
      else
        app.Window.MainFigure.Theme = "light";
        save_path = fullfile(pwd, "screenshot-AppTest_HorizontalContainer_1-light-1.png");
      end  % if
      exportapp(app.Window.MainFigure, save_path)
    end  % function

    % ---

    function DarkTheme_2(~)
      if isMATLABReleaseOlderThan("R2025a")
        disp("!skipping")

        return

      end  % if
      app = AppTest_HorizontalContainer_2;
      app.Window.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-AppTest_HorizontalContainer_2-dark-1.png");
      exportapp(app.Window.MainFigure, save_path)
    end  % function

    function LightTheme_2(~)
      app = AppTest_HorizontalContainer_2;
      if isMATLABReleaseOlderThan("R2025a")
        save_path = fullfile(pwd, "screenshot-AppTest_HorizontalContainer_2-24b-1.png");
      else
        app.Window.MainFigure.Theme = "light";
        save_path = fullfile(pwd, "screenshot-AppTest_HorizontalContainer_2-light-1.png");
      end  % if
      exportapp(app.Window.MainFigure, save_path)
    end  % function

  end  % methods
end  % classdef
