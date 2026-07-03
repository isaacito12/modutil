classdef uiTest_LookupTable1DBlockPlotApp < matlab.uitest.TestCase
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
      verifyWarningFree(testcase, @mus1_LookupTable1DBlockPlotApp)
    end  % function

    %% Passing tests

    function PassingTest_App_1(~)
      % Check the ModelFilePath option.
      if mus1.TestUtil.isR2024bOrOlder
        target = mus1.FileUtil.getFileFullPath("SampleModel_LookupTable1DBlockPlotApp_24b.mdl");
      else
        target = mus1.FileUtil.getFileFullPath("SampleModel_LookupTable1DBlockPlotApp.mdl");
      end  % if
      mus1_LookupTable1DBlockPlotApp(ModelFilePath=target)
    end  % function

    function PassingTest_SampleModel_1(~)
      % Check that the Callback Button works.
      if mus1.TestUtil.isR2024bOrOlder
        model_name = "SampleModel_LookupTable1DBlockPlotApp_24b";
      else
        model_name = "SampleModel_LookupTable1DBlockPlotApp";
      end  % if
      block_path = model_name + "/LookupTable1DBlockPlotApp";  % !test-target
      load_system(model_name)
      command = string( get_param(block_path, "ClickFcn"));
      % This opens an app.
      eval(command)
    end  % function

    function PassingTest_SampleModel_2(~)
      % Check that the Callback Button works.
      if mus1.TestUtil.isR2024bOrOlder
        model_name = "SampleModel_LookupTable1DBlockPlotApp_24b";
      else
        model_name = "SampleModel_LookupTable1DBlockPlotApp";
      end  % if
      block_path = model_name + "/plotLookupTable1DBlocks";  % !test-target
      load_system(model_name)
      command = string( get_param(block_path, "ClickFcn"));
      % This opens an app. The return value is not available.
      eval(command)
    end  % function

  end  % methods
end  % classdef
