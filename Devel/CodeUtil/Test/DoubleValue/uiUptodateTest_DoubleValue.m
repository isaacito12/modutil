classdef uiUptodateTest_DoubleValue < matlab.uitest.TestCase
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
    % Functions in this "TestMethodSetup" section always run before
    % each test defined in the "Test" section runs.

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

    function app_screenshot_dark_1(testcase)
      %%
      if TestUtil1.isR2024bOrOlder || TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
      source = FileUtil1.getFileFullPath("apptest_DoubleValue_1_workspace");
      destination = fullfile(pwd, "screenshot-AppTest-DoubleValue-1-dark.png");

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = apptest_DoubleValue_1_workspace;  % !screenshot-target
        app.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.Window.MainFigure, destination)
      else
        disp("Screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source, Destination=destination));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_light_1(testcase)
      %%
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      source = FileUtil1.getFileFullPath("apptest_DoubleValue_1_workspace");
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b
        destination = fullfile(pwd, "screenshot-AppTest-DoubleValue-1-24b.png");
      else
        % R2025a or newer
        destination = fullfile(pwd, "screenshot-AppTest-DoubleValue-1-light.png");
      end  % if

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = apptest_DoubleValue_1_workspace;  % !screenshot-target
        app.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(app.Window.MainFigure, destination)
      else
        disp("Screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source, Destination=destination));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    % -------------------------------------------------------------------------

    function app_screenshot_dark_2(testcase)
      %%
      if TestUtil1.isR2024bOrOlder || TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
      source = FileUtil1.getFileFullPath("apptest_DoubleValue_2_watch");
      destination = fullfile(pwd, "screenshot-AppTest-DoubleValue-2-dark.png");

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = apptest_DoubleValue_2_watch;  % !screenshot-target
        app.Window.MainFigure.Theme = "dark";
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
      source = FileUtil1.getFileFullPath("apptest_DoubleValue_2_watch");
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b
        destination = fullfile(pwd, "screenshot-AppTest-DoubleValue-2-24b.png");
      else
        % R2025a or newer
        destination = fullfile(pwd, "screenshot-AppTest-DoubleValue-2-light.png");
      end  % if

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = apptest_DoubleValue_2_watch;  % !screenshot-target
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
