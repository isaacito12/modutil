classdef uiUptodateTest_SearchUtil < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2026 The MathWorks, Inc.

  properties
    LocalTopFolder (1,1) string = "C:\local"
  end  % properties

  methods (TestMethodSetup)
    % Functions in the TestMethodSetup section always run before
    % each test defined in the Test section runs.

    function test_method_setup(testcase)
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

    %% Screenshots

    % dark

    function app_screenshot_dark_1(testcase)
      %%
      if TestUtil1.isR2024bOrOlder || TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
      source = FileUtil1.getFileFullPath("FileSearchApp.m");
      destination = fullfile(pwd, "screenshot-FileSearchApp-dark-1.png");

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = FileSearchApp;  % !screenshot-target
        app.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.Window.MainFigure, destination)
      else
        disp("Screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source, Destination=destination));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_dark_2(testcase)
      %%
      if TestUtil1.isR2024bOrOlder || TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
      source = FileUtil1.getFileFullPath("TextSearchApp.m");
      destination = fullfile(pwd, "screenshot-TextSearchApp-dark-1.png");

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = TextSearchApp;  % !screenshot-target
        app.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.Window.MainFigure, destination)
      else
        disp("Screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source, Destination=destination));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_dark_3(testcase)
      %%
      if TestUtil1.isR2024bOrOlder || TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
      source = FileUtil1.getFileFullPath("TextSearchResultApp.m");
      destination = fullfile(pwd, "screenshot-TextSearchResultApp-dark-1.png");

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = TextSearchResultApp;  % !screenshot-target
        app.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.Window.MainFigure, destination)
      else
        disp("Screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source, Destination=destination));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    % light

    function app_screenshot_light_1(testcase)
      %%
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      source = FileUtil1.getFileFullPath("FileSearchApp.m");
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b
        destination = fullfile(pwd, "screenshot-FileSearchApp-24b-1.png");
      else
        % R2025a or newer
        destination = fullfile(pwd, "screenshot-FileSearchApp-light-1.png");
      end  % if

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = FileSearchApp;  % !screenshot-target
        app.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(app.Window.MainFigure, destination)
      else
        disp("Screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source, Destination=destination));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_light_2(testcase)
      %%
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      source = FileUtil1.getFileFullPath("TextSearchApp.m");
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b
        destination = fullfile(pwd, "screenshot-TextSearchApp-24b-1.png");
      else
        % R2025a or newer
        destination = fullfile(pwd, "screenshot-TextSearchApp-light-1.png");
      end  % if

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = TextSearchApp;  % !screenshot-target
        app.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(app.Window.MainFigure, destination)
      else
        disp("Screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source, Destination=destination));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_light_3(testcase)
      %%
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      source = FileUtil1.getFileFullPath("TextSearchResultApp.m");
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b
        destination = fullfile(pwd, "screenshot-TextSearchResultApp-24b-1.png");
      else
        % R2025a or newer
        destination = fullfile(pwd, "screenshot-TextSearchResultApp-light-1.png");
      end  % if

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = TextSearchResultApp;  % !screenshot-target
        app.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(app.Window.MainFigure, destination)
      else
        disp("Screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source, Destination=destination));
      verifyTrue(testcase, destination_is_newer)
    end  % function

  end  % methods
end  % classdef
