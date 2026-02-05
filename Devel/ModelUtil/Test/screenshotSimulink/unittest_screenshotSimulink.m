classdef unittest_screenshotSimulink < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2023-2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in this section always run before each test defined in the Test section runs.

    function test_method_setup_1(testcase)
      function closeAll
        close all
        bdclose all
      end  % nested function
      closeAll
      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @closeAll)
    end  % function

  end  % methods

  methods (Test)

    function PassingTest_1(~)
      ModelUtil1.screenshotSimulink( ...
        StandaloneTest = true, ...
        PaddingHorizontal_px = 10, ...
        PaddingVertical_px = 10)

      delete("screenshot-untitled.png")
    end  % function

    function PassingTest_2(~)
      if TestUtil1.isR2024bOrOlder
        model_name = "testmodel_screenshotSimulink_24b";
        output_name = "test-result-screenshotSimulink-1-24b.png";
      else
        model_name = "testmodel_screenshotSimulink";
        output_name = "test-result-screenshotSimulink-1.png";
      end  % if
      load_system(model_name)

      % To show the Unit information overlay, the model must be updated.
      set_param(model_name, SimulationCommand = "update")

      ModelUtil1.screenshotSimulink( ...
        OutputFileName = output_name, ...
        SimulinkModelName = model_name, ...
        SaveFolder = pwd );
    end  % function

    function PassingTest_3(~)
      if TestUtil1.isR2024bOrOlder
        model_name = "testmodel_screenshotSimulink_24b";
        output_name = "test-result-screenshotSimulink-2-subsystem-without-padding-24b.png";
      else
        model_name = "testmodel_screenshotSimulink";
        output_name = "test-result-screenshotSimulink-2-subsystem-without-padding.png";
      end  % if

      load_system(model_name)

      % To show the Unit information overlay, the model must be updated.
      set_param(model_name, SimulationCommand = "update")

      ModelUtil1.screenshotSimulink( ...
        OutputFileName = output_name, ...
        SimulinkModelName = model_name, ...
        SubsystemPath = "/Subsystem1", ...
        PaddingHorizontal_px = 0, ...
        PaddingVertical_px = 0, ...
        PaddingColorRGB = [1, 1, 0], ...
        SaveFolder = pwd );
    end  % function

    function PassingTest_4(~)
      if TestUtil1.isR2024bOrOlder
        model_name = "testmodel_screenshotSimulink_24b";
        output_name = "test-result-screenshotSimulink-3-subsystem-with-padding-vertical-20px-24b.png";
      else
        model_name = "testmodel_screenshotSimulink";
        output_name = "test-result-screenshotSimulink-3-subsystem-with-padding-vertical-20px.png";
      end  % if

      load_system(model_name)

      % To show the Unit information overlay, the model must be updated.
      set_param(model_name, SimulationCommand = "update")

      ModelUtil1.screenshotSimulink( ...
        OutputFileName = output_name, ...
        SimulinkModelName = model_name, ...
        SubsystemPath = "/Subsystem1", ...
        PaddingHorizontal_px = 0, ...
        PaddingVertical_px = 20, ...
        PaddingColorRGB = [1, 1, 0], ...
        SaveFolder = pwd );
    end  % function

    function PassingTest_5(~)
      if TestUtil1.isR2024bOrOlder
        model_name = "testmodel_screenshotSimulink_24b";
        output_name = "test-result-screenshotSimulink-4-subsystem-with-padding-horizontal-20px-24b.png";
      else
        model_name = "testmodel_screenshotSimulink";
        output_name = "test-result-screenshotSimulink-4-subsystem-with-padding-horizontal-20px.png";
      end  % if

      load_system(model_name)

      % To show the Unit information overlay, the model must be updated.
      set_param(model_name, SimulationCommand = "update")

      ModelUtil1.screenshotSimulink( ...
        OutputFileName = output_name, ...
        SimulinkModelName = model_name, ...
        SubsystemPath = "/Subsystem1", ...
        PaddingHorizontal_px = 20, ...
        PaddingVertical_px = 0, ...
        PaddingColorRGB = [1, 1, 0], ...
        SaveFolder = pwd );
    end  % function

    function PassingTest_6(~)
      if TestUtil1.isR2024bOrOlder
        setupLogging_testmodel_screenshotSimulink_24b
      else
        setupLogging_testmodel_screenshotSimulink
      end  % if
    end  % function

    function PassingTest_7(~)
      if TestUtil1.isR2024bOrOlder
        setupProbe_testmodel_screenshotSimulink_24b
      else
        setupProbe_testmodel_screenshotSimulink
      end  % if
    end  % function

  end  % methods
end  % classdef
