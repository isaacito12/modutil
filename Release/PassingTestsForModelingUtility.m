classdef PassingTestsForModelingUtility < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html
  %
  % Test constraints for qualifications
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints-package.html

  % Copyright 2024-2025 The MathWorks, Inc.

  properties
    % Do not specify the class name for a property to hold a handle to an app.
    % For class-based test apps, the class name is the app name, making
    % it difficult to use a common teardown if the class name is specified here.
    App (1,1)
  end  % properties

  methods (TestClassSetup)
    function test_class_setup(testcase)
      % Add a specific folder to the MATLAB path at the start of tests in this class.
      % The added folder is removed when the test in this class ends.
      % https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.pathfixture-class.html
      applyFixture(testcase, matlab.unittest.fixtures.PathFixture("ModelingUtilityForSimscape"))
    end  % function
  end  % methods

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
            delete(testcase.App.Window.MainFigure)
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

    function PassingTest_1(~)
      demo_TimedTrace  % !test-target
    end  % function

    function PassingTest_2(~)
      web("RotationalFriction_Description.html")  % !test-target
      % [~, h] = web("RotationalFriction_Description.html", "-new");  %#ok<WEBREMOVE> % !test-target
      % close(h)
    end  % function

    function PassingTest_3(~)
      load_system("samplemodel_LookupTable1DBlockPlotApp")  % !test-target
    end  % function

    function PassingTest_4(~)
      load_system("samplemodel_RotationalFriction_refsub")  % !test-target
    end  % function

    function PassingTest_5(~)
      evalin("base", "sampleparams_RotationalFriction")  % !test-target
    end  % function

    function PassingTest_6(~)
      web("SignalDesignApp_Description.html")  % !test-target
      % [~, h] = web("SignalDesignApp_Description.html", "-new");  %#ok<WEBREMOVE> % !test-target
      % close(h)
    end  % function

    function PassingTest_7(~)
      web("TraceGeneratorApp_Description.html")  % !test-target
      % [~, h] = web("TraceGeneratorApp_Description.html", "-new");  %#ok<WEBREMOVE> % !test-target
      % close(h)
    end  % function

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function app_launches_without_warnings_1(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = LookupTable1DBlockPlotApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2_1(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = RotationalFrictionApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2_2(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = RotationalFrictionCustomApp1;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = SignalDesignApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_6(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = TextSearchApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_7(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = TextSearchResultViewerApp;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_8(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        testcase.App = TraceGeneratorApp;  % !test-target
      end  % nested function
    end  % function

  end  % methods
end  % classdef
