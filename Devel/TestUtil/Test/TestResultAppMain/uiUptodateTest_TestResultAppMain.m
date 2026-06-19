classdef uiUptodateTest_TestResultAppMain < matlab.uitest.TestCase
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

    function app_screenshot_dark_1(testcase)
      %%
      if TestUtil1.isR2024bOrOlder || TestUtil1.isNonLocal(testcase.LocalTopFolder)
        disp("!Skipping")

        return

      end  % if
      % R2025a or newer
      source = FileUtil1.getFileFullPath("TestUtil1.TestResultAppMain");
      destination = fullfile(pwd, "screenshot-TestResultAppMain-dark-1.png");

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = TestUtil1.TestResultAppMain;  % !screenshot-target
        app.Window.MainFigure.Theme = "dark";
        result_file_1 = SearchUtil1.searchFiles("sample-test-result-TestResultAppMain-1.xml");
        app.TestResultFileDropDownUI.Items = result_file_1;
        app.TestResultFileDropDownUI.Value = result_file_1;
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
      source = FileUtil1.getFileFullPath("TestUtil1.TestResultAppMain");
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b
        destination = fullfile(pwd, "screenshot-TestResultAppMain-24b-1.png");
      else
        % R2025a or newer
        destination = fullfile(pwd, "screenshot-TestResultAppMain-light-1.png");
      end  % if

      if not(isfile(destination)) || FileUtil1.sourceFileIsNewer(Source=source, Destination=destination)
        app = TestUtil1.TestResultAppMain;  % !screenshot-target
        app.Window.MainFigure.Theme = "light";
        result_file_1 = SearchUtil1.searchFiles("sample-test-result-TestResultAppMain-1.xml");
        app.TestResultFileDropDownUI.Items = result_file_1;
        app.TestResultFileDropDownUI.Value = result_file_1;
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
