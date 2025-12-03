classdef uiuptodatetest_RotationalFriction < matlab.uitest.TestCase
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
    % Functions in this "TestMethodSetup" section always run before
    % each test defined in the "Test" section runs.

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

    %% Screenshots
    % Take screenshots of the app. Visually inspect the saved images.

    function DarkTheme_1(testcase)
      if isMATLABReleaseOlderThan("R2025a")

        return

      end  % if
      testcase.App = RotationalFriction1.RotationalFrictionAppMain;
      drawnow
      testcase.App.Window.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-RotationalFrictionApp-dark-1.png");
      exportapp(testcase.App.Window.MainFigure, save_path)
    end  % function

    function LightTheme_1(testcase)
      testcase.App = RotationalFriction1.RotationalFrictionAppMain;
      drawnow
      if not(isMATLABReleaseOlderThan("R2025a"))
        testcase.App.Window.MainFigure.Theme = "light";
        save_path = fullfile(pwd, "screenshot-RotationalFrictionApp-light-1.png");
      else
        save_path = fullfile(pwd, "screenshot-RotationalFrictionApp-1.png");
      end  % if
      exportapp(testcase.App.Window.MainFigure, save_path)
    end  % function

  end  % methods
end  % classdef
