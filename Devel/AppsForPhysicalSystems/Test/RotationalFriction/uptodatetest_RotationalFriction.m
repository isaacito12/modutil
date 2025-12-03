classdef uptodatetest_RotationalFriction < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2021-2025 The MathWorks, Inc.

  methods (Test)
    % Functions in this "Test" section are the tests.
    % Before a function in this section runs, the TestSetup function
    % defined in the "TestMethodSetup" section runs.

    %% Up-to-date tests

    % -------------------------------------------------------------------------
    % Description

    function PassingTest_1(~)
      % The description file is a Live Script. Make sure it runs without any errors.
      RotationalFriction_Description
      close all
    end  % function

    function description_html_is_uptodate(testcase)
      %%
      % Make sure the description HTML file is up to date.
      source_fullpath = FileUtil1.getFileFullPath("RotationalFriction_Description.m");
      destination_folder = fileparts(source_fullpath);
      destination_fullpath = fullfile(destination_folder, "RotationalFriction_Description.html");
      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
        if not(needs_update)

          return

        end  % if
      end  % if
      actual_path = string( export(source_fullpath, destination_fullpath, Run=true, Format="html", HideCode=true));
      expected_path = destination_fullpath;
      verifyEqual(testcase, actual_path, expected_path)
      needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true);
      verifyTrue(testcase, not(needs_update))
    end  % function

    function description_markdown_is_uptodate(testcase)
      %%
      % Make sure the description Markdown file is up to date.
      source_fullpath = FileUtil1.getFileFullPath("RotationalFriction_Description.m");
      destination_folder = fileparts(source_fullpath);
      destination_fullpath = fullfile(destination_folder, "RotationalFriction_Description.md");
      if isfile(destination_fullpath)
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
        if not(needs_update)

          return

        end  % if
      end  % if
      FileUtil1.exportToMarkdown(source_fullpath, MarkdownFolderPath=destination_folder, HideCode=true);
      needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true);
      verifyTrue(testcase, not(needs_update))
    end  % function

  end  % methods
end  % classdef
