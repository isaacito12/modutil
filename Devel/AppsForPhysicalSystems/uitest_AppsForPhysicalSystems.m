classdef uitest_AppsForPhysicalSystems < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2026 The MathWorks, Inc.

  properties
    LocalTopFolder (1,1) string = "C:\local\modutil\modeling-utility"
  end  % properties

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

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function PassingTest_1_local_test_only(testcase)
      if not(startsWith(pwd, testcase.LocalTopFolder))
        disp("This test is running outside of the specified repository folder.")
        disp("Skipping")

        return

      end  % if
      testcase.App = CodeCoverageApp_AppsForPhysicalSystems;  % !test-target
    end  % function

    function PassingTest_2(testcase)
      top_folder = testcase.LocalTopFolder;
      if not(isfolder(top_folder))
        % Assume that the repository root folder is the current working folder.
        % This branch is executed, for example, during a remote test in a CI pipeline.
        top_folder = pwd;
      end  % if
      testcase.App = CodeCoverageApp_AppsForPhysicalSystems(top_folder);  % !test-target
    end  % function

  end  % methods
end  % classdef
