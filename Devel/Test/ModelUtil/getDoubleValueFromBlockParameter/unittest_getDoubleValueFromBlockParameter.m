classdef unittest_getDoubleValueFromBlockParameter < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser, testBrowser command
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2026 The MathWorks, Inc.

  methods (TestMethodSetup)
    % Functions in this section always run before each test defined in the Test section runs.

    function test_method_setup_1(testcase)
      function clean_up_all
        close all
        bdclose all
        evalin("base", "clearvars")
      end  % nested function
      clean_up_all
      % addTeardown adds a function which always runs after each test.
      % Even if the execution of a test ends with an error, the teardown function runs.
      addTeardown(testcase, @clean_up_all)
    end  % function

  end  % methods

  methods (Test)

    function ErrorTest_1(testcase)
      verifyError(testcase, @test_target, "getDoubleValueFromBlockParameter:EmptyBlockPath")
      function test_target()
        mus1.ModelUtil.getDoubleValueFromBlockParameter
      end  % nested function
    end  % function

    function ErrorTest_2(testcase)
      verifyError(testcase, @test_target, "getDoubleValueFromBlockParameter:EmptyBlockParameterName")
      function test_target()
        mus1.ModelUtil.getDoubleValueFromBlockParameter("dummy_model_name")
      end  % nested function
    end  % function

    function PassingTest_1(~)
      SampleScript_getDoubleValueFromBlockParameter
    end  % function

    function Test_1(testcase)
      model_name = "SampleModel_getDoubleValueFromBlockParameter_24b";
      load_system(model_name)
      block_path = model_name + "/Constant1";
      actual = mus1.ModelUtil.getDoubleValueFromBlockParameter(block_path, "Value");
      expected = 1.23;
      verifyEqual(testcase, actual, expected)
    end  % function

    function Test_2(testcase)
      model_name = "SampleModel_getDoubleValueFromBlockParameter_24b";
      load_system(model_name)
      block_path = model_name + "/1-D Lookup Table1";

      actual = mus1.ModelUtil.getDoubleValueFromBlockParameter(block_path, "BreakpointsForDimension1");
      expected = -5 : 5;
      verifyEqual(testcase, actual, expected)

      actual = mus1.ModelUtil.getDoubleValueFromBlockParameter(block_path, "Table");
      expected = tanh(-5 : 5);
      verifyEqual(testcase, actual, expected)
    end  % function

    function Test_3(testcase)
      model_name = "SampleModel_getDoubleValueFromBlockParameter_24b";
      load_system(model_name)
      block_path = model_name + "/Motor & Drive (System Level)1";
      actual = mus1.ModelUtil.getDoubleValueFromBlockParameter(block_path, "eff");
      expected = 100;
      verifyEqual(testcase, actual, expected)
    end  % function

  end  % methods
end  % classdef
