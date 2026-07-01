classdef uptodateTest_RotationalFrictionTorque < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2021-2026 The MathWorks, Inc.

  properties
    % Some of the tests in this class run only if test is running locally under the LocalTopFolder.
    LocalTopFolder (1,1) pattern = "C:\local"
  end  % properties

  methods (Test)
    % Functions in this "Test" section are the tests.
    % Before a function in this section runs, the TestSetup function
    % defined in the "TestMethodSetup" section runs.

    %% Up-to-date tests

    % -------------------------------------------------------------------------
    % Description

    function PassingTest_1(~)
      % The description file is a Live Script. Make sure it runs without any errors.
      RotationalFrictionTorqueApp_Description
      close all
    end  % function

    function description_html_is_uptodate(testcase)
      %%
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("The current path is outside of LocalTopFolder. Skipping.")

        return

      end  % if
      % Make sure the description HTML file is up to date.

      source_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorqueApp_Description.mlx");
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
      actual_path = string( export(source_fullpath, destination_fullpath, Run=true, Format="html", HideCode=true));
      verifyEqual(testcase, actual_path, destination_fullpath)
      destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true));
      verifyTrue(testcase, destination_is_newer)
    end  % function

    function description_markdown_is_uptodate(testcase)
      %%
      if isMATLABReleaseOlderThan("R2025b")
        disp("Skipping this test in R2025a or older.")

        return

      end  % if
      if mus1.TestUtil.isNonLocal(testcase.LocalTopFolder)
        disp("The current path is outside of LocalTopFolder. Skipping.")

        return

      end  % if
      % Make sure the description Markdown file is up to date.

      source_fullpath = mus1.FileUtil.getFileFullPath("RotationalFrictionTorqueApp_Description.mlx");
      [folder, file_base_name, ~] = fileparts(source_fullpath);
      destination_fullpath = fullfile(folder, file_base_name + ".md");
      if isfile(destination_fullpath)
        destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath));
        if destination_is_newer
          disp("The Markdown file is up to date. Skipping.")

          return

        end  % if
      end  % if
      % Generate Markdown.
      destination_folder = fileparts(destination_fullpath);
      mus1.FileUtil.exportToMarkdown(source_fullpath, MarkdownFolderPath=destination_folder, HideCode=true);
      destination_is_newer = not(mus1.FileUtil.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true));
      verifyTrue(testcase, destination_is_newer)
    end  % function

  end  % methods
end  % classdef
