classdef uiuptodatetest_SignalUtil < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2025 The MathWorks, Inc.

  properties
    % Do not specify the class name for a property to hold a handle to an app.
    % For class-based test apps, the class name is the app name, making
    % it difficult to use a common teardown if the class name is specified here.
    App (1,1)
  end  % properties

  methods (TestMethodSetup)
    % Functions in the TestMethodSetup section always run before
    % each test defined in the Test section runs.

    function test_method_setup(testcase)
      %%
      function closeAll
        % Delete the app's figure object from memory.
        if class(testcase.App) ~= "double"
          if isstruct(testcase.App) && not(isfield(testcase.App, "Window"))
            % Function-based app with no window to delete.

            return

          end  % if
          delete(testcase.App.Window.MainFigure)
        end  % if
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

    %% Up-to-date tests

    function app_screenshot_is_uptodate_1_1_dark(testcase)
      %%
      source_fullpath = FileUtil1.getFileFullPath("SignalDesignApp.m");

      theme_name = "dark";
      destination_filename = "screenshot-SignalDesignApp-" + theme_name + ".png";
      destination_fullpath = which(destination_filename);

      if isempty(destination_fullpath)
        needs_update = true;
        destination_fullpath = fullfile(pwd, destination_filename);
      else
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      end  % if

      if needs_update
        % Display the time stamps.
        FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true);

        testcase.App = SignalDesignApp();  % !screenshot-target

        testcase.App.Window.MainFigure.Theme = theme_name;

        % Take screenshot
        disp("Update screenshot")
        exportapp(testcase.App.Window.MainFigure, destination_fullpath)

      else
        % The closeAll function checks class(testcase.App) ~= "double"
        % when finishing the execution of a test.
        testcase.App = 0;
      end  % if

      newer = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      verifyFalse(testcase, newer)
    end  % function

    function app_screenshot_is_uptodate_1_2_light(testcase)
      %%
      source_fullpath = FileUtil1.getFileFullPath("SignalDesignApp.m");

      theme_name = "light";
      destination_filename = "screenshot-SignalDesignApp-" + theme_name + ".png";
      destination_fullpath = which(destination_filename);

      if isempty(destination_fullpath)
        needs_update = true;
        destination_fullpath = fullfile(pwd, destination_filename);
      else
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      end  % if

      if needs_update
        % Display the time stamps.
        FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true);

        testcase.App = SignalDesignApp();  % !screenshot-target

        testcase.App.Window.MainFigure.Theme = theme_name;

        % Take screenshot
        disp("Update screenshot")
        exportapp(testcase.App.Window.MainFigure, destination_fullpath)

      else
        % The closeAll function checks class(testcase.App) ~= "double"
        % when finishing the execution of a test.
        testcase.App = 0;
      end  % if

      newer = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      verifyFalse(testcase, newer)
    end  % function

    function app_screenshot_is_uptodate_2_1_dark(testcase)
      %%
      source_fullpath = FileUtil1.getFileFullPath("TraceGeneratorApp.m");

      theme_name = "dark";
      destination_filename = "screenshot-TraceGeneratorApp-" + theme_name + ".png";
      destination_fullpath = which(destination_filename);

      if isempty(destination_fullpath)
        needs_update = true;
        destination_fullpath = fullfile(pwd, destination_filename);
      else
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      end  % if

      if needs_update
        % Display the time stamps.
        FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true);

        testcase.App = TraceGeneratorApp();  % !screenshot-target

        testcase.App.Window.MainFigure.Theme = theme_name;

        % Take screenshot
        disp("Update screenshot")
        exportapp(testcase.App.Window.MainFigure, destination_fullpath)

      else
        % The closeAll function checks class(testcase.App) ~= "double"
        % when finishing the execution of a test.
        testcase.App = 0;
      end  % if

      newer = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      verifyFalse(testcase, newer)
    end  % function

    function app_screenshot_is_uptodate_2_2_light(testcase)
      %%
      source_fullpath = FileUtil1.getFileFullPath("TraceGeneratorApp.m");

      theme_name = "light";
      destination_filename = "screenshot-TraceGeneratorApp-" + theme_name + ".png";
      destination_fullpath = which(destination_filename);

      if isempty(destination_fullpath)
        needs_update = true;
        destination_fullpath = fullfile(pwd, destination_filename);
      else
        needs_update = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      end  % if

      if needs_update
        % Display the time stamps.
        FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath, DisplayInfo=true);

        testcase.App = TraceGeneratorApp();  % !screenshot-target

        testcase.App.Window.MainFigure.Theme = theme_name;

        % Take screenshot
        disp("Update screenshot")
        exportapp(testcase.App.Window.MainFigure, destination_fullpath)

      else
        % The closeAll function checks class(testcase.App) ~= "double"
        % when finishing the execution of a test.
        testcase.App = 0;
      end  % if

      newer = FileUtil1.sourceFileIsNewer(Source=source_fullpath, Destination=destination_fullpath);
      verifyFalse(testcase, newer)
    end  % function

  end  % methods

end  % classdef
