classdef uiUptodateTest_Vehicle1DForce < matlab.uitest.TestCase
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

  properties
    % Some of the tests in this class run only if test is running locally under the LocalTopFolder.
    LocalTopFolder (1,1) pattern = "C:\local"
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

    % -------------------------------------------------------------------------
    % Vehicle1DForce1.Vehicle1DForceAppMain
    % Save the screenshot image file outside of the namespace.

    function app_screenshot_1_dark(testcase)
      %%
      if mus1.TestUtil.isR2024bOrOlder || mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
      source_fullpath = mus1.FileUtil.getFileFullPath("Vehicle1DForce1.Vehicle1DForceAppMain");

      destination_folder = fileparts(source_fullpath);
      destination_folder = extractBefore(destination_folder, ("/"|"\") + "+Vehicle1DForce1");
      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return value to suppress warning.

      destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceAppMain-dark-1.png");

      if isfile(destination_fullpath)
        needs_update = mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        app = Vehicle1DForce1.Vehicle1DForceAppMain;  % !screenshot-target
        app.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
        disp("Exported: " + destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_1_light(testcase)
      %%
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  %if

      source_fullpath = mus1.FileUtil.getFileFullPath("Vehicle1DForce1.Vehicle1DForceAppMain");

      destination_folder = fileparts(source_fullpath);
      destination_folder = extractBefore(destination_folder, ("/"|"\") + "+Vehicle1DForce1");
      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return value to suppress warning.

      if mus1.TestUtil.isR2024bOrOlder
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceAppMain-24b-1.png");
      else
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceAppMain-light-1.png");
      end  % if

      if isfile(destination_fullpath)
        needs_update = mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        app = Vehicle1DForce1.Vehicle1DForceAppMain;  % !screenshot-target
        app.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
        disp("Exported: " + destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    % -------------------------------------------------------------------------
    % Vehicle1DForceApp

    function app_screenshot_2_dark(testcase)
      %%
      if mus1.TestUtil.isR2024bOrOlder || mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
      source_fullpath = mus1.FileUtil.getFileFullPath("Vehicle1DForceApp");

      destination_folder = fileparts(source_fullpath);
      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return value to suppress warning.

      destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceApp-dark-1.png");

      if isfile(destination_fullpath)
        needs_update = mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        app = Vehicle1DForceApp;  % !screenshot-target
        app.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
        disp("Exported: " + destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_2_light(testcase)
      %%
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  %if

      source_fullpath = mus1.FileUtil.getFileFullPath("Vehicle1DForceApp");

      destination_folder = fileparts(source_fullpath);
      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return value to suppress warning.

      if mus1.TestUtil.isR2024bOrOlder
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceApp-24b-1.png");
      else
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceApp-light-1.png");
      end  % if

      if isfile(destination_fullpath)
        needs_update = mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        app = Vehicle1DForceApp;  % !screenshot-target
        app.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
        disp("Exported: " + destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

  end  % methods
end  % classdef
