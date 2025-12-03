classdef uitest_FileUtil < matlab.uitest.TestCase
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

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    % Warnings can be displayed even when the app opens and starts working seemingly normally.
    % Make sure there is no warning when opening an app.

    function PassingTest_1(testcase)
      % Calling the command without any arguments opens the app with sample data.
      % This is to help users see the app.
      testcase.App = FileListApp;  % !test-target
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target(), "FileListApp:EmptyStringForFileList")
      function test_target()
        testcase.App = FileListApp("");  % !test-target
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target(), "FileListApp:EmptyTableForFileList")
      function test_target()
        testcase.App = FileListApp(table.empty);  % !test-target
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @() test_target(), "FileListApp:MissingFilePathColumn")
      function test_target()
        data = ["1" "2"];
        t = table(data);
        testcase.App = FileListApp(t);  % !test-target
      end  % nested function
    end  % function

    function Test_error_4(testcase)
      verifyError(testcase, @() test_target(), "MATLAB:validators:mustBeFolder")
      function test_target()
        testcase.App = FileListApp("file1.m", TopFolder="test_test_test");  % !test-target
      end  % nested function
    end  % function

    %% Other tests

    function PassingTest_1_1(testcase)
      file_list = "file1.m";
      testcase.App = FileListApp(file_list);
    end  % function

    function PassingTest_1_2(testcase)
      file_list = ["file1.m", "file2.m", "file3.m"];
      testcase.App = FileListApp(file_list);
    end  % function

    function PassingTest_2_1(testcase)
      FilePath = "file1.m";
      file_list_table = table(FilePath);
      testcase.App = FileListApp(file_list_table);
    end  % function

    function PassingTest_2_2(testcase)
      FilePath = ["file1.m"; "file2.m"; "file3.m"];
      file_list_table = table(FilePath);
      testcase.App = FileListApp(file_list_table);
    end  % function

    function PassingTest_3_1(testcase)
      % Test the TopFolder option.
      file_list = "file1.m";
      testcase.App = FileListApp(file_list, TopFolder=matlabroot);
    end  % function

  end  % methods
end  % classdef
