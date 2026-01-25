classdef uiUptodateTest_RotationalFriction < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2026 The MathWorks, Inc.

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
        delete(testcase.App.Window.MainFigure)
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

    %% Screenshots
    % Take screenshots of the app. Visually inspect the saved images.

    function app_screenshot_1_1_dark(testcase)
      %%
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        % Do not take a screenshot. The testcase.App.Window.MainFigure is still necessary for the teardown to delete.
        disp("This test is used in MATLAB R2025a or newer. This MATLAB is " + matlabRelease.Release + ". Skipping.")
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");

        return

      end  % if
      % R2025a or newer
      source_fullpath = FileUtil1.getFileFullPath("RotationalFriction1.RotationalFrictionAppMain");
      destination_fullpath = fullfile(pwd, "..", "media", "screenshot-RotationalFrictionAppMain-dark-1.png");

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        testcase.App = RotationalFriction1.RotationalFrictionAppMain;  % !screenshot-target
        testcase.App.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(testcase.App.Window.MainFigure, destination_fullpath)
      else
        % Do not take a screenshot. The testcase.App.Window.MainFigure is still necessary for the teardown to delete.
        disp("The screenshot is up to date. Skipping.")
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_1_2_dark(testcase)
      %%
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        % Do not take a screenshot. The testcase.App.Window.MainFigure is still necessary for the teardown to delete.
        disp("This test is used in MATLAB R2025a or newer. This MATLAB is " + matlabRelease.Release + ". Skipping.")
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");

        return

      end  % if
      % R2025a or newer
      source_fullpath = FileUtil1.getFileFullPath("RotationalFrictionApp");
      destination_fullpath = fullfile(pwd, "..", "media", "screenshot-RotationalFrictionApp-dark-1.png");

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        testcase.App = RotationalFriction1.RotationalFrictionAppMain;  % !screenshot-target
        testcase.App.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(testcase.App.Window.MainFigure, destination_fullpath)
      else
        % Do not take a screenshot. The testcase.App.Window.MainFigure is still necessary for the teardown to delete.
        disp("The screenshot is up to date. Skipping.")
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_2_1_light(testcase)
      %%
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        % Do not take a screenshot. The testcase.App.Window.MainFigure is still necessary for the teardown to delete.
        disp("This test is used in MATLAB R2025a or newer. This MATLAB is " + matlabRelease.Release + ". Skipping.")
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");

        return

      end  % if
      % R2025a or newer
      source_fullpath = FileUtil1.getFileFullPath("RotationalFriction1.RotationalFrictionAppMain");
      destination_fullpath = fullfile(pwd, "..", "media", "screenshot-RotationalFrictionAppMain-light-1.png");

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        testcase.App = RotationalFriction1.RotationalFrictionAppMain;  % !screenshot-target
        testcase.App.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(testcase.App.Window.MainFigure, destination_fullpath)
      else
        % Do not take a screenshot. The testcase.App.Window.MainFigure is still necessary for the teardown to delete.
        disp("The screenshot is up to date. Skipping.")
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_2_2_light(testcase)
      %%
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older
        % Do not take a screenshot. The testcase.App.Window.MainFigure is still necessary for the teardown to delete.
        disp("This test is used in MATLAB R2025a or newer. This MATLAB is " + matlabRelease.Release + ". Skipping.")
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");

        return

      end  % if
      % R2025a or newer
      source_fullpath = FileUtil1.getFileFullPath("RotationalFrictionApp");
      destination_fullpath = fullfile(pwd, "..", "media", "screenshot-RotationalFrictionApp-light-1.png");

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        testcase.App = RotationalFriction1.RotationalFrictionAppMain;  % !screenshot-target
        testcase.App.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(testcase.App.Window.MainFigure, destination_fullpath)
      else
        % Do not take a screenshot. The testcase.App.Window.MainFigure is still necessary for the teardown to delete.
        disp("The screenshot is up to date. Skipping.")
        testcase.App = struct;
        testcase.App.Window.MainFigure = uifigure(Visible="off");
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

  end  % methods
end  % classdef
