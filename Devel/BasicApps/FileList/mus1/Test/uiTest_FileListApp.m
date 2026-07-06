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
      evalin("base", "clearvars")

      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAllAfterTest)
      function closeAllAfterTest
        % Close/delete all figure windows. This closes/deletes not only the test targets but also
        % all the other figure windows too to provide clean state for the next test.
        figs = findall(0, Type="Figure");
        if not(any(isempty(figs)))
          disp("Deleting figures (" + numel(figs) + ")")
          delete(figs)
        end  % if

        bdclose all

        % Do not clear variables in the base workspace at the end of a test
        % to make it easy to debug after test if necessary.

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

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @mus1_FileListApp)
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @test_target, "FileListApp:EmptyStringForFileList")
      function test_target
        mus1_FileListApp("")  % !test-target
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @test_target, "FileListApp:EmptyTableForFileList")
      function test_target
        mus1_FileListApp(table.empty)  % !test-target
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @test_target, "FileListApp:MissingFilePathColumn")
      function test_target
        data = ["1" "2"];
        t = table(data);
        mus1_FileListApp(t)  % !test-target
      end  % nested function
    end  % function

    function Test_error_4(testcase)
      verifyError(testcase, @test_target, "MATLAB:validators:mustBeFolder")
      function test_target
        mus1_FileListApp("file1.m", TopFolder="test_test_test")  % !test-target
      end  % nested function
    end  % function

    function Test_error_5(testcase)
      %%
      app = mus1_FileListApp("this_does_not_exist_as_file");

      % The uialert window pops up, but it won't be visible.
      % Ideally, the app's error state should be checked, but it is skipped.
      % This is because the app is a function-based simple app which, by design,
      % does basic error handling only.
      % To see the uialert window, run the above command interactively in
      % Command Window, and then manually double-click the table row in the app.
      choose(testcase, app.TableUI.MainTable, [1 1])

    end  % function

    %% Tests

    function PassingTest_1_1(~)
      file_list = "file1.m";
      mus1_FileListApp(file_list)
    end  % function

    function PassingTest_1_2(~)
      file_list = ["file1.m", "file2.m", "file3.m"];
      mus1_FileListApp(file_list)
    end  % function

    function PassingTest_2_1(~)
      FilePath = "file1.m";
      file_list_table = table(FilePath);
      mus1_FileListApp(file_list_table)
    end  % function

    function PassingTest_2_2(~)
      FilePath = ["file1.m"; "file2.m"; "file3.m"];
      file_list_table = table(FilePath);
      mus1_FileListApp(file_list_table)
    end  % function

    function PassingTest_3_1(testcase)
      %%
      source_fullpath = mus1.FileUtil.getFileFullPath("uiTest_FileListApp.m");

      targetfolder_fullpath = extractBefore(source_fullpath, ("/"|"\") + "Devel");
      targetfolder_fullpath = fullfile(targetfolder_fullpath, "Devel", "Test", "ForTesting");

      file_list = ["mustest_script1.m"; "mustest_script2.m"];

      % Pass a string array of file paths.
      app = mus1_FileListApp(file_list, TopFolder=targetfolder_fullpath);  % !test-target

      verifyEqual(testcase, height(app.TableUI.MainTable.Data), 2)

      % !todo: Programmatically double-click the table row and open the file in the editor.

    end  % function

    function PassingTest_4_1(testcase)
      %%
      source_fullpath = mus1.FileUtil.getFileFullPath("uiTest_FileListApp.m");

      targetfolder_fullpath = extractBefore(source_fullpath, ("/"|"\") + "Devel");
      targetfolder_fullpath = fullfile(targetfolder_fullpath, "Devel", "Test", "ForTesting");

      FilePath = ["mustest_script1.m"; "mustest_script2.m"];
      LineNumber = [3; 5];
      target_table = table(FilePath, LineNumber);

      % Pass a table with specified line numbers.
      app = mus1_FileListApp(target_table, TopFolder=targetfolder_fullpath);  % !test-target

      verifyEqual(testcase, height(app.TableUI.MainTable.Data), 2)

      % !todo: Programmatically double-click the table row and open the file in the editor.

    end  % function

  end  % methods
end  % classdef
