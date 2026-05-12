classdef uiTest_ModelUtil < matlab.uitest.TestCase
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
    % Functions in the TestMethodSetup section always run before
    % each test defined in the Test section runs.

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

    function clean_launch_1(testcase)
      verifyWarningFree(testcase, @LookupTable1DBlockPlotApp)
    end  % function

    %% Passing tests

    function PassingTest_App_1(~)
      % Check the ModelFilePath option.
      if TestUtil1.isR2024bOrOlder
        target = SearchUtil1.searchFiles("SampleModel_LookupTable1DBlockPlotApp_24b.mdl");
      else
        target = SearchUtil1.searchFiles("SampleModel_LookupTable1DBlockPlotApp.mdl");
      end  % if
      LookupTable1DBlockPlotApp(ModelFilePath=target)
    end  % function

    function PassingTest_SampleModel_1(~)
      % Check that the Callback Button works.
      if TestUtil1.isR2024bOrOlder
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
      if TestUtil1.isR2024bOrOlder
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
