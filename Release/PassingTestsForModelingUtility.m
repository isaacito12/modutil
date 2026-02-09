classdef PassingTestsForModelingUtility < matlab.uitest.TestCase
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

    function PassingTest_CodeCoverageApp_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        CodeCoverageApp  % !test-target
      end  % nested function
    end  % function

    function PassingTest_FileListApp_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        FileListApp  % !test-target
      end  % nested function
    end  % function

    function PassingTest_LookupTable1DBlockPlotApp_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        LookupTable1DBlockPlotApp  % !test-target
      end  % nested function
    end  % function

    function PassingTest_RotationalFriction_Description_html(testcase)
      % Check that there is only one target file.
      target_file = SearchUtil1.searchFiles("RotationalFriction_Description.html");  % !test-target
      verifyTrue(testcase, isscalar(target_file))
    end  % function

    function PassingTest_RotationalFrictionApp_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        RotationalFrictionApp  % !test-target
      end  % nested function
    end  % function

    function PassingTest_RotationalFrictionCustomApp1_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        RotationalFrictionCustomApp1  % !test-target
      end  % nested function
    end  % function

    function PassingTest_samplemodel_LookupTable1DBlockPlotApp_24b_1(~)
      load_system("samplemodel_LookupTable1DBlockPlotApp_24b")  % !test-target
    end  % function

    function PassingTest_SampleModel_RotationalFriction_refsub_24b_1(~)
      load_system("SampleModel_RotationalFriction_refsub_24b")  % !test-target
    end  % function

    function PassingTest_SampleParams_RotationalFriction_1(testcase)
      % Check that the expected parameter "friction" is loaded in the base workspace.
      if TestUtil1.isNonLocal(testcase.LocalTopFolder)
        % !todo: Eval'ing an M script in a CI pipeline fails for some reason.
        disp("!Skipping")

        return

      end  % if
      evalin("base", "clear friction")  % Pre-clean up the base workspace.
      evalin("base", "SampleParams_RotationalFriction")  % !test-target
      vars = evalin("base", "whos");
      varnames = string({vars.name});
      verifyTrue(testcase, ismember("friction", varnames))
      evalin("base", "clear friction")  % Post-clean up the base workspace.
    end  % function

    function PassingTest_SignalDesignApp_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        SignalDesignApp  % !test-target
      end  % nested function
    end  % function

    function PassingTest_SignalDesignApp_Description_html(testcase)
      % Check that there is only one target file.
      target_file = SearchUtil1.searchFiles("SignalDesignApp_Description.html");  % !test-target
      verifyTrue(testcase, isscalar(target_file))
    end  % function

    function PassingTest_TestResultApp_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        TestResultApp  % !test-target
      end  % nested function
    end  % function

    function PassingTest_TextSearchApp_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        TextSearchApp  % !test-target
      end  % nested function
    end  % function

    function PassingTest_TextSearchResultApp_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        TextSearchResultApp  % !test-target
      end  % nested function
    end  % function

    function PassingTest_TraceGeneratorApp_1(testcase)
      verifyWarningFree(testcase, @() test_target)
      function test_target
        TraceGeneratorApp  % !test-target
      end  % nested function
    end  % function

    function PassingTest_TraceGeneratorApp_Description_html(testcase)
      % Check that there is only one target file.
      target_file = SearchUtil1.searchFiles("TraceGeneratorApp_Description.html");  % !test-target
      verifyTrue(testcase, isscalar(target_file))
    end  % function

  end  % methods
end  % classdef
