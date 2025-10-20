classdef ModelingUtilityPassingTests < matlab.uitest.TestCase
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
          if isstruct(testcase.App)
            % Function-based app
            if not(isfield(testcase.App, "Window"))
              % There is no window to delete.

              return

            end  % if
            % App.Window is a struct field which does not trigger destructor.
            % Delete the figure directly.
            delete(testcase.App.Window.MainFigure)
          else
            % Class-based app
            % App.Window's destructor deletes the figure.
            delete(testcase.App.Window)
          end  % if
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

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function app_launches_without_warnings_1(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = demoapp_PhysicalValue_1;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = demoapp_PhysicalValue_2_derive;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = demoapp_plotLookupTable1DBlocks;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_4(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = MonitorInfoApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_5(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = SignalDesignApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_6(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = TextSearchApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_7(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = TextSearchResultViewerApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_8(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = TimedTraceBuilderApp;  % !test-target
      end  % nested function
    end  % function

    %% Color theme
    % Take screenshots of the app. Visually inspect the saved images.

    function LightTheme_1(testcase)
      testcase.App = SignalDesignApp;
      drawnow
      testcase.App.Window.MainFigure.Theme = "light";
      save_path = fullfile(pwd, "screenshot-SignalDesignApp-light-1.png");
      exportapp(testcase.App.Window.MainFigure, save_path)
    end  % function

    function DarkTheme_1(testcase)
      testcase.App = SignalDesignApp;
      drawnow
      testcase.App.Window.MainFigure.Theme = "dark";
      save_path = fullfile(pwd, "screenshot-SignalDesignApp-dark-1.png");
      exportapp(testcase.App.Window.MainFigure, save_path)
    end  % function

  end  % methods
end  % classdef
