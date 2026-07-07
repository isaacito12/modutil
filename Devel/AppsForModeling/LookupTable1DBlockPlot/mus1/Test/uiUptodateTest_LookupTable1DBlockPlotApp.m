classdef uiUptodateTest_LookupTable1DBlockPlotApp < matlab.uitest.TestCase
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
      evalin("base", "clearvars")

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAllAfterTest)
      function closeAllAfterTest
        % Close/delete all figure windows. This closes/deletes not only the test targets but also
        % all the other figure windows too to provide clean state for the next test.
        figs = findall(0, Type="Figure");
        if not(any(isempty(figs)))
          disp("Deleting figures (" + numel(figs) + ")")
          delete(figs)
        end  % if

        bdclose all

        % Do not clear variables in the base workspace at the end of a test
        % to make it easy to debug after test if necessary.

      end  % nested function
    end  % function

  end  % methods

  methods (Test)
    % Functions in the Test section are the tests.
    % Before a function in this section runs, the functions defined in the TestMethodSetup section run.

    %% Screenshots

    function app_screenshot_1_dark(testcase)
      %%
      if mus1.TestUtil.isR2024bOrOlder || mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping (the test is not running within the specified local path.)")

        return

      end  % if
      % R2025a or newer
      keyword = "LookupTable1DBlockPlot";
      source_fullpath = mus1.FileUtil.getFileFullPath("mus1_LookupTable1DBlockPlotApp");

      destination_folder = fileparts(source_fullpath);
      destination_folder = extractBefore(destination_folder, ("/"|"\") + "Devel" + ("/"|"\"));
      destination_folder = fullfile(destination_folder, "Devel", "AppsForModeling", "LookupTable1DBlockPlot", "mus1");

      verifyTrue(testcase, isfolder(destination_folder))

      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return values to suppress warning.

      destination_fullpath = fullfile(destination_folder, "screenshot-LookupTable1DBlockPlotApp-dark-1.png");

      if isfile(destination_fullpath)
        needs_update = mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        modelfile_fullpath = mus1.FileUtil.getFileFullPath("SampleModel_LookupTable1DBlockPlotApp_24b.mdl");
        app = mus1_LookupTable1DBlockPlotApp(ModelFilePath=modelfile_fullpath);  % !screenshot-target
        app.Window.MainFigure.Theme = "dark";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      verifyTrue(testcase, contains(source_fullpath, keyword))
      verifyTrue(testcase, contains(destination_fullpath, keyword))

      destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function app_screenshot_1_light(testcase)
      %%
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping (the test is not running within the specified local path.)")

        return

      end  %if
      % R2025a or newer
      keyword = "LookupTable1DBlockPlot";
      source_fullpath = mus1.FileUtil.getFileFullPath("mus1_LookupTable1DBlockPlotApp");

      destination_folder = fileparts(source_fullpath);
      destination_folder = extractBefore(destination_folder, ("/"|"\") + "Devel" + ("/"|"\"));
      destination_folder = fullfile(destination_folder, "Devel", "AppsForModeling", "LookupTable1DBlockPlot", "mus1");

      verifyTrue(testcase, isfolder(destination_folder))

      destination_folder = fullfile(destination_folder, "media");
      [~, ~] = mkdir(destination_folder);  % Assign return values to suppress warning.

      if mus1.TestUtil.isR2024bOrOlder
        destination_fullpath = fullfile(destination_folder, "screenshot-LookupTable1DBlockPlotApp-24b.png");
        modelfile_fullpath = mus1.FileUtil.getFileFullPath("SampleModel_LookupTable1DBlockPlotApp_24b.mdl");
      else
        destination_fullpath = fullfile(destination_folder, "screenshot-LookupTable1DBlockPlotApp-light-1.png");
        modelfile_fullpath = mus1.FileUtil.getFileFullPath("SampleModel_LookupTable1DBlockPlotApp.mdl");
      end  % if

      if isfile(destination_fullpath)
        needs_update = mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      else
        needs_update = true;
      end  % if

      if needs_update
        % Open the app with a model to take a screenshot.
        app = mus1_LookupTable1DBlockPlotApp(ModelFilePath=modelfile_fullpath);  % !screenshot-target
        app.Window.MainFigure.Theme = "light";
        drawnow
        exportapp(app.Window.MainFigure, destination_fullpath)
      else
        disp("The screenshot is up to date.")
      end  % if

      verifyTrue(testcase, contains(source_fullpath, keyword))
      verifyTrue(testcase, contains(destination_fullpath, keyword))

      destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
      verifyTrue(testcase, destination_is_newer)
    end  % function

  end  % methods
end  % classdef
