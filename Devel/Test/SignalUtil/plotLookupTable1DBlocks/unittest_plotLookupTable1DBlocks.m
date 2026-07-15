classdef unittest_plotLookupTable1DBlocks < matlab.unittest.TestCase
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

    function ErrorCase_1(testcase)
      verifyError(testcase, @mus1.SignalUtil.plotLookupTable1DBlocks, "plotLookupTable1DBlocks:ModelIsNotSpecified")
    end  % function

    function PassingTest_1(~)
      load_system("SampleModel_plotLookupTable1DBlocks_refsub_24b")
    end  % function

    function PassingTest_2(~)
      if isMATLABReleaseOlderThan("R2026a")
        disp("!Skipping: MATLAB is older than R2026a.")
      else
        load_system("SampleModel_plotLookupTable1DBlocks_refsub")
      end  % if
    end  % function

    function PassingTest_3(~)
      evalin("base", "DemoScript_plotLookupTable1DBlocks_24b")
    end  % function

    function PassingTest_4(~)
      if isMATLABReleaseOlderThan("R2026a")
        disp("!Skipping: MATLAB is older than R2026a.")
      else
        evalin("base", "DemoScript_plotLookupTable1DBlocks")
      end  % if
    end  % function

  end  % methods
end  % classdef
