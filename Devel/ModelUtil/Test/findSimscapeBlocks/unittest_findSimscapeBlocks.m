classdef unittest_findSimscapeBlocks < matlab.unittest.TestCase
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
    % Functions in this "Test" section are the tests.
    % Before each function in this section runs, functions defined in the TestMethodSetup section run.

    %% Minimum quality check
    % Check that models, scripts, functions, and classes run right out of the box.

    function PassingTest_1(~)
      DemoScript_findSimscapeBlocks_1  % !test-target
    end  % function

    % -------------------------------------------------------------------------
    % Error cases

    function Error_1(testcase)
      verifyError(testcase, @test_target, "findSimscapeBlocks:InvalidModelName")
      function test_target
        ModelUtil1.findSimscapeBlocks  % !test-target
      end  % nested function
    end  % function

    function Error_2(testcase)
      verifyError(testcase, @test_target, "Simulink:Commands:OpenSystemUnknownSystem")
      function test_target
        ModelUtil1.findSimscapeBlocks("dummy")  % !test-target
      end  % nested function
    end  % function

    function Error_3(testcase)
      verifyError(testcase, @test_target, "findSimscapeBlocks:SimscapeBlockNotFound")
      function test_target
        ModelUtil1.findSimscapeBlocks("EmptyModel_findSimscapeBlocks_24b", "Mass")  % !test-target
      end  % nested function
    end  % function

    function Error_4(testcase)
      verifyError(testcase, @test_target, "findSimscapeBlocks:TargetBlockNotFound")
      function test_target
        ModelUtil1.findSimscapeBlocks("DemoModel_findSimscapeBlocks_1_24b", "Inertia")  % !test-target
      end  % nested function
    end  % function

    %% Other tests

    function Test_1(testcase)
      model_name = "DemoModel_findSimscapeBlocks_1_24b";

      actual_block_paths = ModelUtil1.findSimscapeBlocks(model_name, "Mass");  % !test-target

      expected_block_paths = model_name + ["/Mass"; "/Mass1"; "/Subsystem/Mass2"];
      verifyEqual(testcase, actual_block_paths, expected_block_paths)
    end  % function

    function Test_2(testcase)
      model_name = "DemoModel_findSimscapeBlocks_1_24b";

      actual_block_paths = ModelUtil1.findSimscapeBlocks(model_name, ["Mass", "Demo component"]);  % !test-target

      expected_block_paths = model_name + [
        "/Mass"
        "/Mass1"
        "/Subsystem/Mass2"
        "/Simscape" + newline + "Component"
        "/Subsystem/Simscape" + newline + "Component"
        "/Subsystem/Simscape" + newline + "Component1"
        ];
      verifyEqual(testcase, actual_block_paths, expected_block_paths)
    end  % function

  end  % methods
end  % classdef
