classdef uiTest_FileListApp < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2024-2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in this "TestMethodSetup" section always run before
    % each test defined in the "Test" section runs.

    function test_method_setup_1(testcase)
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

    function PassingTest_1(~)
      % Calling the command without any arguments opens the app with sample data.
      % This is to help users see the app.
      FileListApp  % !test-target
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @test_target, "FileListApp:EmptyStringForFileList")
      function test_target
        FileListApp("")  % !test-target
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @test_target, "FileListApp:EmptyTableForFileList")
      function test_target
        FileListApp(table.empty)  % !test-target
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @test_target, "FileListApp:MissingFilePathColumn")
      function test_target
        data = ["1" "2"];
        t = table(data);
        FileListApp(t)  % !test-target
      end  % nested function
    end  % function

    function Test_error_4(testcase)
      verifyError(testcase, @test_target, "MATLAB:validators:mustBeFolder")
      function test_target
        FileListApp("file1.m", TopFolder="test_test_test")  % !test-target
      end  % nested function
    end  % function

    %% Tests

    function PassingTest_1_1(~)
      file_list = "file1.m";
      FileListApp(file_list)
    end  % function

    function PassingTest_1_2(~)
      file_list = ["file1.m", "file2.m", "file3.m"];
      FileListApp(file_list)
    end  % function

    function PassingTest_2_1(~)
      FilePath = "file1.m";
      file_list_table = table(FilePath);
      FileListApp(file_list_table)
    end  % function

    function PassingTest_2_2(~)
      FilePath = ["file1.m"; "file2.m"; "file3.m"];
      file_list_table = table(FilePath);
      FileListApp(file_list_table)
    end  % function

    function PassingTest_3_1(~)
      % Test the TopFolder option.
      file_list = "file1.m";
      FileListApp(file_list, TopFolder=matlabroot)
    end  % function

  end  % methods
end  % classdef
