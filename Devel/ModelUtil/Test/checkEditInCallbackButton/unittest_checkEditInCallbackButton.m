classdef unittest_checkEditInCallbackButton < matlab.unittest.TestCase
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

    function ErrorCase_1(testcase)
      verifyError(testcase, @test_target, "checkEditInCallbackButton:InvalidModelName")
      function test_target()
        % The function requires a model name to be passed.
        ModelUtil1.checkEditInCallbackButton  % !test-target
      end  % nested function
    end  % function

    function ErrorCase_2(testcase)
      verifyError(testcase, @test_target, "checkEditInCallbackButton:InvalidModelName")
      function test_target()
        % The passed argument must not be zero-length text.
        ModelUtil1.checkEditInCallbackButton("")  % !test-target
      end  % nested function
    end  % function

    function ErrorCase_3(testcase)
      verifyError(testcase, @test_target, "checkEditInCallbackButton:InvalidCode")
      function test_target()
        % The ClickFcn callback must not be an empty.
        ModelUtil1.checkEditInCallbackButton("samplemodel_checkEditInCallbackButton_emptycode_24b")  % !test-target
      end  % nested function
    end  % function

    function Test_1_with_pause(testcase)

      % !todo: Ideally these two lines should be unnecessary because checkEditInCallbackButton loads
      % the specified model. However, there seems to be a timing issue in R2024b where
      % the test proceeds before the model is fully loaded, resulting in a test failure.
      open_system("samplemodel_checkEditInCallbackButton_24b")
      pause(2)

      result = ModelUtil1.checkEditInCallbackButton("samplemodel_checkEditInCallbackButton_24b");
      verifyEqual(testcase, result.Found(1), true)
      verifyEqual(testcase, result.Found(2), true)
    end  % function

    %% Minimum quality check
    % Make sure that scripts, functions, classes, and models run right out of the box.

    function PassingTest_1_R2025a_or_newer(~)
      if isMATLABReleaseOlderThan("R2025a")
        % R2024b or older

        return

      end  % if
      demo_checkEditInCallbackButton
    end  % function

  end  % methods
end  % classdef
