classdef uiUptodateTest_DropDown < matlab.uitest.TestCase
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

    %% Screenshots

    function app_screenshot_1_1_dark(testcase)
      %%
      if TestUtil1.isR2024bOrOlder || TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
      source_fullpath = FileUtil1.getFileFullPath("DemoApp_DropDown_1_simplest");

      destination_folder = fileparts(source_fullpath);
      destination_fullpath = fullfile(destination_folder, "screenshot-DemoApp_DropDown_1-dark.png");

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        app = DemoApp_DropDown_1_simplest;  % !screenshot-target
        app.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.MainFigure, destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_1_2_light(testcase)
      %%
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  %if

      source_fullpath = FileUtil1.getFileFullPath("DemoApp_DropDown_1_simplest");

      destination_folder = fileparts(source_fullpath);
      if TestUtil1.isR2024bOrOlder
        destination_fullpath = fullfile(destination_folder, "screenshot-DemoApp_DropDown_1-24b.png");
      else
        destination_fullpath = fullfile(destination_folder, "screenshot-DemoApp_DropDown_1-light.png");
      end  % if

      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        app = DemoApp_DropDown_1_simplest;  % !screenshot-target
        app.MainFigure.Theme = "light";
        drawnow
        exportapp(app.MainFigure, destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

  end  % methods
end  % classdef
