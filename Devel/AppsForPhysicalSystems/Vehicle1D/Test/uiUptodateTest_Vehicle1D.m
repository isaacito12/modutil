<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
classdef uiUptodateTest_Vehicle1DForce < matlab.uitest.TestCase
========
classdef uiUptodateTest_Vehicle1D < matlab.uitest.TestCase
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m
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
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
    % Vehicle1DForce1.Vehicle1DForceAppMain
========
    % Vehicle1D1.Vehicle1DAppMain
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m
    % Save the screenshot image file outside of the namespace.

    function app_screenshot_1_dark(testcase)
      %%
      if TestUtil1.isR2024bOrOlder || TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
      source_fullpath = FileUtil1.getFileFullPath("Vehicle1DForce1.Vehicle1DForceAppMain");

      destination_folder = fileparts(source_fullpath);
      destination_folder = extractBefore(destination_folder, ("/"|"\") + "+Vehicle1DForce1");
      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return value to suppress warning.

      destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceAppMain-dark-1.png");
========
      source_fullpath = FileUtil1.getFileFullPath("Vehicle1D1.Vehicle1DAppMain");

      destination_folder = fileparts(source_fullpath);
      destination_folder = extractBefore(destination_folder, ("/"|"\") + "+Vehicle1D1");
      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return value to suppress warning.

      destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DAppMain-dark-1.png");
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
        app = Vehicle1DForce1.Vehicle1DForceAppMain;  % !screenshot-target
========
        app = Vehicle1D1.Vehicle1DAppMain;  % !screenshot-target
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m
        app.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
        disp("Exported: " + destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_1_light(testcase)
      %%
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  %if

<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
      source_fullpath = FileUtil1.getFileFullPath("Vehicle1DForce1.Vehicle1DForceAppMain");

      destination_folder = fileparts(source_fullpath);
      destination_folder = extractBefore(destination_folder, ("/"|"\") + "+Vehicle1DForce1");
========
      source_fullpath = FileUtil1.getFileFullPath("Vehicle1D1.Vehicle1DAppMain");

      destination_folder = fileparts(source_fullpath);
      destination_folder = extractBefore(destination_folder, ("/"|"\") + "+Vehicle1D1");
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m
      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return value to suppress warning.

      if TestUtil1.isR2024bOrOlder
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceAppMain-24b-1.png");
      else
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceAppMain-light-1.png");
========
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DAppMain-24b-1.png");
      else
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DAppMain-light-1.png");
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m
      end  % if

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
        app = Vehicle1DForce1.Vehicle1DForceAppMain;  % !screenshot-target
========
        app = Vehicle1D1.Vehicle1DAppMain;  % !screenshot-target
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m
        app.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
        disp("Exported: " + destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    % -------------------------------------------------------------------------
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
    % Vehicle1DForceApp
========
    % Vehicle1DApp
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m

    function app_screenshot_2_dark(testcase)
      %%
      if TestUtil1.isR2024bOrOlder || TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
      source_fullpath = FileUtil1.getFileFullPath("Vehicle1DForceApp");
========
      source_fullpath = FileUtil1.getFileFullPath("Vehicle1DApp");
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m

      destination_folder = fileparts(source_fullpath);
      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return value to suppress warning.

<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
      destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceApp-dark-1.png");
========
      destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DApp-dark-1.png");
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
        app = Vehicle1DForceApp;  % !screenshot-target
========
        app = Vehicle1DApp;  % !screenshot-target
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m
        app.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
        disp("Exported: " + destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_2_light(testcase)
      %%
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  %if

<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
      source_fullpath = FileUtil1.getFileFullPath("Vehicle1DForceApp");
========
      source_fullpath = FileUtil1.getFileFullPath("Vehicle1DApp");
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m

      destination_folder = fileparts(source_fullpath);
      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return value to suppress warning.

      if TestUtil1.isR2024bOrOlder
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceApp-24b-1.png");
      else
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DForceApp-light-1.png");
========
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DApp-24b-1.png");
      else
        destination_fullpath = fullfile(destination_folder, "screenshot-Vehicle1DApp-light-1.png");
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m
      end  % if

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
<<<<<<<< HEAD:Devel/AppsForPhysicalSystems/Vehicle1DForce/Test/uiUptodateTest_Vehicle1DForce.m
        app = Vehicle1DForceApp;  % !screenshot-target
========
        app = Vehicle1DApp;  % !screenshot-target
>>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3:Devel/AppsForPhysicalSystems/Vehicle1D/Test/uiUptodateTest_Vehicle1D.m
        app.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
        disp("Exported: " + destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

  end  % methods
end  % classdef
