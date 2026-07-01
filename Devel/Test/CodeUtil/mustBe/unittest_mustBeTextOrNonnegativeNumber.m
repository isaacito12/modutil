classdef unittest_mustBeTextOrNonnegativeNumber < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2025 The MathWorks, Inc.

  methods (Test)

    function PassingTest_1(~)
      mus1.CodeUtil.mustBeTextOrNonnegativeNumber("test")
    end  % function

    function PassingTest_2(~)
      mus1.CodeUtil.mustBeTextOrNonnegativeNumber(0)
    end  % function

    function PassingTest_3(~)
      mus1.CodeUtil.mustBeTextOrNonnegativeNumber(1.2)
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "mustBeTextOrNonnegativeNumber:NotTextNorNonnegativeNumber")
      function test_target
        mus1.CodeUtil.mustBeTextOrNonnegativeNumber(-1)
      end  % nested function
    end  % function

  end  % methods
end  % classdef
