classdef uiTest_TestResultAppMain < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2026 The MathWorks, Inc.

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

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function app_launches_without_warnings_1(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        TestUtil1.TestResultAppMain  % !test-target
      end  % nested function
    end  % function

    function app_launches_without_warnings_2(testcase)
      verifyWarningFree(testcase, @() test_target())
      function test_target()
        TestUtil1.TestResultAppMain(TestResultFileName="")  % !test-target
      end  % nested function
    end  % function

    % Error cases

    function ErrorCase_1(testcase)
      verifyError(testcase, @() test_target(), "TestResultAppMain:InvalidFile")
      function test_target()
        TestUtil1.TestResultAppMain(TestResultFileName="dummy_dummy_dummy")  % !test-target
      end  % nested function
    end  % function

    % Passing tests

    function PassingTest_1(~)
      % Launch the app with the TestResultFileName option.
      result_file = SearchUtil1.searchFiles("sample-test-result-TestResultAppMain-1.xml");
      TestUtil1.TestResultAppMain(TestResultFileName=result_file)  % !test-target
    end  % function

    function PassingTest_2(~)
      % Load a test result file to the drop down and the table.
      result_file_1 = SearchUtil1.searchFiles("sample-test-result-TestResultAppMain-1.xml");
      app = TestUtil1.TestResultAppMain;

      % This updates the drop down.
      app.TestResultFileDropDownUI.Items = result_file_1;  % !test-target

      % This updates the table.
      app.TestResultFileDropDownUI.Value = result_file_1;  % !test-target
    end  % function

    %% Gesture test

    function GestureTest_1(testcase)
      % Load multiple test result files to the drop down and the table.
      result_file_1 = SearchUtil1.searchFiles("sample-test-result-TestResultAppMain-1.xml");
      result_file_2 = SearchUtil1.searchFiles("sample-test-result-TestResultAppMain-2.xml");

      app = TestUtil1.TestResultAppMain;

      % Set the items in the drop down.
      app.TestResultFileDropDownUI.Items = result_file_1;  % !test-target
      app.TestResultFileDropDownUI.Items(end + 1) = result_file_2;  % !test-target

      % Update the table.
      app.TestResultFileDropDownUI.Value = result_file_2;  % !test-target

      choose(testcase, app.TestResultFileDropDownUI.MainDropDown, 1)  % !test-target
      choose(testcase, app.TestResultFileDropDownUI.MainDropDown, 2)  % !test-target
      choose(testcase, app.TestResultFileDropDownUI.MainDropDown, 1)  % !test-target
    end  % function

  end  % methods
end  % classdef
