classdef uptodateTest_AbstractMotorEfficiency < matlab.unittest.TestCase
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

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAllAfterTest)
      function closeAllAfterTest
        % Running a live script can open figure windows.
        % Delete all figure windows (not just making the window invisible).
        % This closes not only the test targets but also all other figure windows.
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
    % Functions in this "Test" section are the tests.
    % Before a function in this section runs, the TestSetup function
    % defined in the "TestMethodSetup" section runs.

    %% Up-to-date tests

    % -------------------------------------------------------------------------
    % Description

    function PassingTest_1(~)
      % The description file is a Live Script. Make sure it runs without any errors.
      AbstractMotorEfficiencyApp_Description
    end  % function

    function description_html_is_uptodate(testcase)
      %%
      % Make sure the description HTML file is up to date.
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("The current path is outside of LocalTopFolder. Skipping.")

        return

      end  % if

      source_fullpath = FileUtil1.getFileFullPath("AbstractMotorEfficiencyApp_Description.mlx");
      [folder, file_base_name, ~] = fileparts(source_fullpath);
      destination_fullpath = fullfile(folder, file_base_name + ".html");
      if isfile(destination_fullpath)
        destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
        if destination_is_newer
          disp("The HTML file is up to date. Skipping.")

          return

        end  % if
      end  % if
      % Generate HTML.
      disp("Generating: " + destination_fullpath)
      actual_path = string( export(source_fullpath, destination_fullpath, Run=true, Format="html", HideCode=false));
      verifyEqual(testcase, actual_path, destination_fullpath)
      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function description_markdown_is_uptodate(testcase)
      %%
      if isMATLABReleaseOlderThan("R2025b")
        disp("Skipping this test in R2025a or older.")

        return

      end  % if
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("The current path is outside of LocalTopFolder. Skipping.")

        return

      end  % if
      % Make sure the description Markdown file is up to date.

      source_fullpath = FileUtil1.getFileFullPath("AbstractMotorEfficiencyApp_Description.mlx");
      [folder, file_base_name, ~] = fileparts(source_fullpath);
      destination_fullpath = fullfile(folder, file_base_name + ".md");
      if isfile(destination_fullpath)
        destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
        if destination_is_newer
          disp("The Markdown file is up to date. Skipping.")

          return

        end  % if
      end  % if
      % Generate Markdown.
      destination_folder = fileparts(destination_fullpath);
      FileUtil1.exportToMarkdown(source_fullpath, MarkdownFolderPath=destination_folder, HideCode=true);

      num_lines = FileUtil1.updateMarkdownForMathRendering(destination_fullpath);
      disp("Updated markdown for math rendering. Number of lines updated: " + num_lines)

      destination_is_newer = not(FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true));
      verifyTrue(testcase, destination_is_newer)
    end  % function

  end  % methods
end  % classdef
