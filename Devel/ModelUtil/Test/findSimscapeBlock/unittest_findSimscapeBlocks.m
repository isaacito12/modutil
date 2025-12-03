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

  % Copyright 2023-2025 The MathWorks, Inc.

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

    % Error cases

    function Test_error_1(testcase)
      verifyError(testcase, @test_target, "findSimscapeBlock:InvalidModelName")
      function test_target()
        ModelUtil1.findSimscapeBlock
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @test_target, "findSimscapeBlock:InvalidSimscapeBlockName")
      function test_target()
        ModelUtil1.findSimscapeBlock("dummy")
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @test_target, "findSimscapeBlock:SimscapeBlockNotFound")
      function test_target()
        ModelUtil1.findSimscapeBlock("samplemodel_findSimscapeBlocks_test1_epmty", "Mass")
      end  % nested function
    end  % function

    function Test_error_4(testcase)
      verifyError(testcase, @test_target, "findSimscapeBlock:TargetBlockNotFound")
      function test_target()
        ModelUtil1.findSimscapeBlock("samplemodel_findSimscapeBlocks_test2", "Inertia")
      end  % nested function
    end  % function

    %% Other tests

    function Test_1(testcase)
      model_name = "samplemodel_findSimscapeBlocks_test2";
      result = ModelUtil1.findSimscapeBlock(model_name, "Mass");

      paths = ["/Mass"; "/Mass1"; "/Subsystem/Mass2"];
      block_paths = model_name + paths;

      verifyEqual(testcase, result.BlockPath, block_paths)
    end  % function

  end  % methods
end  % classdef
