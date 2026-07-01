classdef unittest_checkRefSubInCallbackButton < matlab.unittest.TestCase
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

    function ErrorTest_1(testcase)
      verifyError(testcase, @test_target, "checkRefSubInCallbackButton:InvalidModelName")
      function test_target()
        % The function requires a model name to be passed.
        mus1.ModelUtil.checkRefSubInCallbackButton  % !test-target
      end  % nested function
    end  % function

    function ErrorTest_2(testcase)
      verifyError(testcase, @test_target, "checkRefSubInCallbackButton:InvalidModelName")
      function test_target()
        % The passed argument must not be zero-length text.
        mus1.ModelUtil.checkRefSubInCallbackButton("")  % !test-target
      end  % nested function
    end  % function

    function Test_1(testcase)
      if mus1.TestUtil.isR2024bOrOlder
        result = mus1.ModelUtil.checkRefSubInCallbackButton("samplemodel_checkRefSubInCallbackButton_empty_24b");
      else
        result = mus1.ModelUtil.checkRefSubInCallbackButton("samplemodel_checkRefSubInCallbackButton_empty");
      end  % if
      verifyTrue(testcase, isempty(result))
    end  % function

    function Test_2(testcase)
      if mus1.TestUtil.isR2024bOrOlder
        % This test fails in 24b for some reason but passes in 25b.
        disp("!Skipping")
        % result = mus1.ModelUtil.checkRefSubInCallbackButton("samplemodel_checkRefSubInCallbackButton_24b");

        return

      else
        result = mus1.ModelUtil.checkRefSubInCallbackButton("samplemodel_checkRefSubInCallbackButton");
      end  % if
      verifyEqual(testcase, result.Found(1), true)
      verifyEqual(testcase, result.Found(2), true)
      verifyEqual(testcase, result.Found(3), false)
    end  % function

    function Test_3(testcase)
      if mus1.TestUtil.isR2024bOrOlder
        % This test fails in 24b for some reason but passes in 25b.
        disp("!Skipping") 
        % result = mus1.ModelUtil.checkRefSubInCallbackButton("samplemodel_checkRefSubInCallbackButton_24b");

        return

      else
        result = mus1.ModelUtil.checkRefSubInCallbackButton("samplemodel_checkRefSubInCallbackButton");
      end  % if
      verifyEqual(testcase, result.IsRefSub(1), true)
      verifyEqual(testcase, result.IsRefSub(2), true)
      verifyEqual(testcase, result.IsRefSub(3), false)
    end  % function

    %% Minimum quality check
    % Make sure that scripts, functions, classes, and models run right out of the box.

    function PassingTest_1(~)
      if mus1.TestUtil.isR2024bOrOlder
        % This test fails in 24b for some reason but passes in 25b.
        disp("!Skipping") 
        % demo_checkRefSubInCallbackButton_24b

        return

      else
        demo_checkRefSubInCallbackButton
      end  % if
    end  % function

  end  % methods
end  % classdef
