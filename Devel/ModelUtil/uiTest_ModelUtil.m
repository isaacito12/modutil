classdef uiTest_ModelUtil < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html

  % Copyright 2024-2026 The MathWorks, Inc.

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

    function PassingTest_App_1(testcase)
      % Check that the app opens without any arguments.
      testcase.App = LookupTable1DBlockPlotApp;
    end  % function

    function PassingTest_App_2(testcase)
      % Check the ModelFilePath option.
      target = which("samplemodel_LookupTable1DBlockPlotApp");
      testcase.App = LookupTable1DBlockPlotApp(ModelFilePath=target);
    end  % function

    function PassingTest_SampleModel_1(~)
      % Check that the Callback Button works.
      model_name = "samplemodel_LookupTable1DBlockPlotApp";
      block_path = model_name + "/LookupTable1DBlockPlotApp";  % !test-target
      load_system(model_name)
      command = string( get_param(block_path, "ClickFcn"));
      % This opens an app. The return value is not available.
      eval(command)
      % Close all figures.
      figs = findall(0, Type="Figure");
      close(figs)
    end  % function

    function PassingTest_SampleModel_2(~)
      % Check that the Callback Button works.
      model_name = "samplemodel_LookupTable1DBlockPlotApp";
      block_path = model_name + "/plotLookupTable1DBlocks";  % !test-target
      load_system(model_name)
      command = string( get_param(block_path, "ClickFcn"));
      % This opens an app. The return value is not available.
      eval(command)
      % Close all figures.
      figs = findall(0, Type="Figure");
      close(figs)
    end  % function

  end  % methods
end  % classdef
