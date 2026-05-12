classdef uitest_AlignComponents < matlab.uitest.TestCase
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
    % Functions in the TestMethodSetup section always run before
    % each test defined in the Test section runs.

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
      verifyWarningFree(testcase, @apptest_Align_EditField_DropDown_1_horizontal)
    end  % function

    function clean_launch_2(testcase)
      verifyWarningFree(testcase, @apptest_Align_EditField_DropDown_2_vertical)
    end  % function

    function clean_launch_3(testcase)
      verifyWarningFree(testcase, @apptest_AlignComponents_1_horizontal)
    end  % function

    function clean_launch_4(testcase)
      verifyWarningFree(testcase, @apptest_AlignComponents_2_vertical)
    end  % function

    %% Color theme
    % Take screenshots of the app. Visually inspect the saved images.

    function DarkTheme_1(~)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      app = apptest_Align_EditField_DropDown_1_horizontal;
      drawnow
      app.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-1-editfield.png");
      exportapp(app.MainFigure, save_path)
    end  % function

    function LightTheme_1(~)
      app = apptest_Align_EditField_DropDown_1_horizontal;
      drawnow
      if not(isMATLABReleaseOlderThan("R2025a"))
        app.MainFigure.Theme = "light";
      end  % if
      save_path = fullfile(pwd, "screenshot-testing-light-1-editfield.png");
      exportapp(app.MainFigure, save_path)
    end  % function

    function DarkTheme_2(~)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      app = apptest_Align_EditField_DropDown_2_vertical;
      drawnow
      app.Window.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-2-editfield.png");
      exportapp(app.Window.MainFigure, save_path)
    end  % function

    function LightTheme_2(~)
      app = apptest_Align_EditField_DropDown_2_vertical;
      drawnow
      if not(isMATLABReleaseOlderThan("R2025a"))
        app.Window.MainFigure.Theme = "light";
      end  % if
      save_path = fullfile(pwd, "screenshot-testing-light-2-editfield.png");
      exportapp(app.Window.MainFigure, save_path)
    end  % function

    function DarkTheme_3(~)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      app = apptest_AlignComponents_1_horizontal;
      drawnow
      app.Window.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-3-horizontal.png");
      exportapp(app.Window.MainFigure, save_path)
    end  % function

    function LightTheme_3(~)
      app = apptest_AlignComponents_1_horizontal;
      drawnow
      app.Window.MainFigure.Theme = "light";
      save_path = fullfile(pwd, "screenshot-testing-light-3-horizontal.png");
      exportapp(app.Window.MainFigure, save_path)
    end  % function

    function DarkTheme_4(~)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      app = apptest_AlignComponents_1_horizontal;
      drawnow
      app.Window.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-testing-dark-4-horizontal.png");
      exportapp(app.Window.MainFigure, save_path)
    end  % function

    function LightTheme_4(~)
      app = apptest_AlignComponents_1_horizontal;
      drawnow
      app.Window.MainFigure.Theme = "light";
      save_path = fullfile(pwd, "screenshot-testing-light-4-horizontal.png");
      exportapp(app.Window.MainFigure, save_path)
    end  % function

  end  % methods
end  % classdef
