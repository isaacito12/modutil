classdef unittest_findAllSimscapeBlocks < matlab.unittest.TestCase
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
      verifyError(testcase, @test_target, "findAllSimscapeBlocks:ModelNotSpecified")
      function test_target()
        ModelUtil1.findAllSimscapeBlocks
      end  % nested function
    end  % function

    %% Other tests

    function Test_1(testcase)
      result = ModelUtil1.findAllSimscapeBlocks("samplemodel_findAllSimscapeBlocks_test1_epmty");
      verifyTrue(testcase, isempty(result))
    end  % function

    function Test_2(testcase)
      model_name = "samplemodel_findAllSimscapeBlocks_test2";
      result = ModelUtil1.findAllSimscapeBlocks(model_name);

      paths = [
        "/Mass"
        "/Mass1"
        "/PS Ramp"
        "/PS Ramp1"
        "/Rotational Damper"
        "/Rotational Damper1"
        "/Subsystem/Mass2"
        "/Subsystem/PS Ramp2"
        "/Subsystem/Rotational Damper2"
        "/Simscape" + newline + "Component"
        ];
      block_paths = model_name + paths;
      verifyEqual(testcase, result.BlockPath, block_paths)

      verifyTrue(testcase, all(result.BlockType(1:end-1) == "SimscapeBlock"))
      verifyTrue(testcase, result.BlockType(end) == "SimscapeComponentBlock")

      types = [
        "Mass"
        "Mass"
        "PS Ramp"
        "PS Ramp"
        "Rotational Damper"
        "Rotational Damper"
        "Mass"
        "PS Ramp"
        "Rotational Damper"
        "samplecomponent_findAllSimscapeBlocks"
        ];
      verifyEqual(testcase, result.MaskType, types)
    end  % function

  end  % methods
end  % classdef
