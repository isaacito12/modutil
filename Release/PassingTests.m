classdef PassingTests < matlab.uitest.TestCase
  % Class-based unit test for app

  % Overview of App Testing Framework
  % https://www.mathworks.com/help/matlab/matlab_prog/overview-of-app-testing-framework.html
  %
  % Table of Verifications, Assertions, and Other Qualifications
  % https://www.mathworks.com/help/matlab/matlab_prog/types-of-qualifications.html
  %
  % Test constraints for qualifications
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints-package.html

  % Copyright 2024-2026 The MathWorks, Inc.

  properties
    % Run the tests only when the working folder is under this folder path.
    LocalTopFolder (1,1) pattern = "C:\local"
  end  % properties

  methods (TestClassSetup)
    function test_class_setup(testcase)
      % Add a specific folder to the MATLAB path at the start of tests in this class.
      % The added folder is removed when the test in this class ends.
      % https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.pathfixture-class.html
      applyFixture(testcase, matlab.unittest.fixtures.PathFixture("ModelingUtilityForSimscape"))
    end  % function
  end  % methods

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
        % Close all figure windows. This closes not only the test targets but also other figure windows.
        figs = findall(0, Type="Figure");
        if ~isempty(figs)
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

    function PassingTest_AbstractMotorEfficiencyApp_1(testcase)
      verifyWarningFree(testcase, @AbstractMotorEfficiencyApp)
    end  % function

    function PassingTest_AbstractMotor_Description_html(testcase)
      % Check that there is only one target file.
      target_file = mus1.SearchUtil.searchFiles("AbstractMotorEfficiencyApp_Description.html");
      verifyTrue(testcase, isscalar(target_file))
    end  % function

    function PassingTest_AbstractMotorEfficiency_SampleModel_refsub_24b_1(~)
      load_system("AbstractMotorEfficiency_SampleModel_refsub_24b")
    end  % function

    function PassingTest_SampleParams_AbstractMotor_1(testcase)
      % Check that the expected parameter "MotorParams" is loaded in the base workspace.
      evalin("base", "clear MotorParams")  % Pre-clean up the base workspace.
      evalin("base", "AbstractMotorEfficiency_SampleParams1")
      vars = evalin("base", "whos");
      varnames = string({vars.name});
      verifyTrue(testcase, ismember("MotorParams", varnames))
      evalin("base", "clear MotorParams")  % Post-clean up the base workspace.
    end  % function

    function PassingTest_SampleParams_AbstractMotor_2(testcase)
      % Check that the expected parameter "Params" is loaded in the base workspace.
      evalin("base", "clear Params")  % Pre-clean up the base workspace.
      evalin("base", "AbstractMotorEfficiency_SampleParams2")
      vars = evalin("base", "whos");
      varnames = string({vars.name});
      verifyTrue(testcase, ismember("Params", varnames))
      evalin("base", "clear Params")  % Post-clean up the base workspace.
    end  % function

    function PassingTest_CodeCoverageApp_1(testcase)
      verifyWarningFree(testcase, @CodeCoverageApp)
    end  % function

    function PassingTest_ContourQuiverApp_1(testcase)
      verifyWarningFree(testcase, @ContourQuiverApp)
    end  % function

    function PassingTest_FileListApp_1(testcase)
      verifyWarningFree(testcase, @FileListApp)
    end  % function

    function PassingTest_FileSearchApp_1(testcase)
      verifyWarningFree(testcase, @FileSearchApp)
    end  % function

    function PassingTest_FolderSearchApp_1(testcase)
      verifyWarningFree(testcase, @FolderSearchApp)
    end  % function

    function PassingTest_LookupTable1DBlockPlotApp_1(testcase)
      verifyWarningFree(testcase, @LookupTable1DBlockPlotApp)
    end  % function

    function PassingTest_SampleModel_1(~)
      load_system("LookupTable1DBlockPlotApp_SampleModel_24b")
    end  % function

    function PassingTest_RotationalFrictionTorqueApp_1(testcase)
      verifyWarningFree(testcase, @RotationalFrictionTorqueApp)
    end  % function

    function PassingTest_RotationalFrictionTorqueApp_Description_html(testcase)
      % Check that there is only one target file.
      target_file = mus1.SearchUtil.searchFiles("RotationalFrictionTorqueApp_Description.html");
      verifyTrue(testcase, isscalar(target_file))
    end  % function

    function PassingTest_RotationalFrictionTorque_SampleModel_refsub_24b_1(~)
      load_system("RotationalFrictionTorque_SampleModel_refsub_24b")
    end  % function

    function PassingTest_RotationalFrictionTorque_SampleParams1_1(testcase)
      % Check that the expected parameter "FrictionParams1" is loaded in the base workspace.
      evalin("base", "clear FrictionParams1")  % Pre-clean up the base workspace.
      evalin("base", "RotationalFrictionTorque_SampleParams1")
      vars = evalin("base", "whos");
      varnames = string({vars.name});
      verifyTrue(testcase, ismember("FrictionParams1", varnames))
      evalin("base", "clear FrictionParams1")  % Post-clean up the base workspace.
    end  % function

    function PassingTest_RotationalFrictionTorque_SampleParams2_1(testcase)
      % Check that the expected parameter "Params" is loaded in the base workspace.
      evalin("base", "clear Params")  % Pre-clean up the base workspace.
      evalin("base", "RotationalFrictionTorque_SampleParams2")
      vars = evalin("base", "whos");
      varnames = string({vars.name});
      verifyTrue(testcase, ismember("Params", varnames))
      evalin("base", "clear Params")  % Post-clean up the base workspace.
    end  % function

    function PassingTest_SignalDesignApp_1(testcase)
      verifyWarningFree(testcase, @SignalDesignApp)
    end  % function

    function PassingTest_SignalDesignApp_Description_html(testcase)
      % Check that there is only one target file.
      target_file = mus1.SearchUtil.searchFiles("SignalDesignApp_Description.html");
      verifyTrue(testcase, isscalar(target_file))
    end  % function

    function PassingTest_TestResultApp_1(testcase)
      verifyWarningFree(testcase, @TestResultApp)
    end  % function

    function PassingTest_TextSearchApp_1(testcase)
      verifyWarningFree(testcase, @TextSearchApp)
    end  % function

    function PassingTest_TextSearchResultApp_1(testcase)
      verifyWarningFree(testcase, @TextSearchResultApp)
    end  % function

    function PassingTest_TraceGeneratorApp_1(testcase)
      verifyWarningFree(testcase, @TraceGeneratorApp)
    end  % function

    function PassingTest_TraceGeneratorApp_Description_html(testcase)
      % Check that there is only one target file.
      target_file = mus1.SearchUtil.searchFiles("TraceGeneratorApp_Description.html");
      verifyTrue(testcase, isscalar(target_file))
    end  % function

    function PassingTest_Vehicle1DForceApp_1(testcase)
      verifyWarningFree(testcase, @Vehicle1DForceApp)
    end  % function

    function PassingTest_Vehicle1DForceApp_Description_html(testcase)
      % Check that there is only one target file.
      target_file = mus1.SearchUtil.searchFiles("Vehicle1DForceApp_Description.html");
      verifyTrue(testcase, isscalar(target_file))
    end  % function

    function PassingTest_Vehicle1DForce_SampleModel_refsub_24b_1(~)
      load_system("Vehicle1DForce_SampleModel_refsub_24b")
    end  % function

    function PassingTest_Vehicle1DForce_SampleParams1_1(testcase)
      % Check that the expected parameter "VehicleParams1" is loaded in the base workspace.
      evalin("base", "clear VehicleParams1")  % Pre-clean up the base workspace.
      evalin("base", "Vehicle1DForce_SampleParams1")
      vars = evalin("base", "whos");
      varnames = string({vars.name});
      verifyTrue(testcase, ismember("VehicleParams1", varnames))
      evalin("base", "clear VehicleParams1")  % Post-clean up the base workspace.
    end  % function

    function PassingTest_Vehicle1DForce_SampleParams2_1(testcase)
      % Check that the expected parameter "Params" is loaded in the base workspace.
      evalin("base", "clear Params")  % Pre-clean up the base workspace.
      evalin("base", "Vehicle1DForce_SampleParams2")
      vars = evalin("base", "whos");
      varnames = string({vars.name});
      verifyTrue(testcase, ismember("Params", varnames))
      evalin("base", "clear Params")  % Post-clean up the base workspace.
    end  % function

  end  % methods
end  % classdef
