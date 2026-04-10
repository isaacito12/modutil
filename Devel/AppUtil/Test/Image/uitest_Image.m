classdef uitest_Image < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2026 The MathWorks, Inc.

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

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function app_launches_without_warnings_0(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = DemoApp_Image_0_raw;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_1(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = DemoApp_Image_1_simplest;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = DemoApp_Image_2_ver_hor_align;  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_3(testcase)
      verifyWarningFree(testcase, @() target())
      function target()
        testcase.App = DemoApp_Image_3;  % !test-target
      end  % nested function
    end  % function

    %% Gesture test

    function Gesture_1(testcase)
      testcase.App = DemoApp_Image_3;

      % Click the icon programmatically.
      press(testcase, testcase.App.ImageUI.MainImage)

      actual_text = string(clipboard("paste"));
      expected_text = "Copied: Demo app for the Image component";
      verifyEqual(testcase, actual_text, expected_text)
    end  % function

  end  % methods
end  % classdef
