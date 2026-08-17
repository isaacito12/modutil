classdef uptodateTest_Vehicle1DForce < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
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
    % Functions in this "Test" section are the tests.
    % Before a function in this section runs, the functions defined in the TestMethodSetup section run.

    %% Up-to-date tests

    % -------------------------------------------------------------------------
    % Description

    function PassingTest_1(~)
      % The description file is a Live Script. Make sure it runs without any errors.
      Vehicle1DForceApp_Description_mus1
    end  % function

    function description_html_is_uptodate(testcase)
      %%
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("The current path is outside of LocalTopFolder. Skipping.")

        return

      end  % if

      source_fullpath = mus1.FileUtil.getFileFullPath("Vehicle1DForceApp_Description_mus1.mlx");
      [folder, file_base_name, ~] = fileparts(source_fullpath);
      destination_fullpath = fullfile(folder, file_base_name + ".html");
      if isfile(destination_fullpath)
        destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
        if destination_is_newer
          disp("The HTML file is up to date. Skipping.")

          return

        end  % if
      end  % if
      % Generate HTML.
      actual_path = string( export(source_fullpath, destination_fullpath, Run=true, Format="html", HideCode=false));
      verifyEqual(testcase, actual_path, destination_fullpath)
      destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function plot_image_is_uptodate(testcase)
      %%
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("The current path is outside of LocalTopFolder. Skipping.")

        return

      end  % if

      source_name = "mus1.app.Vehicle1DForce.plotVehicle1DForce";
      image_filename = "plot-image-Vehicle1DForce.png";

      source_fullpath = mus1.FileUtil.getFileFullPath(source_name);

      description_fullpath = mus1.FileUtil.getFileFullPath("Vehicle1DForceApp_Description_mus1.mlx");
      description_folder = fileparts(description_fullpath);

      destination_folder = fullfile(description_folder, "media");
      destination_fullpath = fullfile(destination_folder, image_filename);

      source_is_newer = mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      if source_is_newer
        fig = mus1.app.Vehicle1DForce.plotVehicle1DForce;
        fig.Position(3:4) = [600 500];  % width height
        exportgraphics(fig, destination_fullpath)
        disp("Saved: " + destination_fullpath)
      else
        disp("Skipping. Screenshot is up to date.")
      end  % if

      source_is_newer = mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      verifyFalse(testcase, source_is_newer)

    end  % function

  end  % methods
end  % classdef
