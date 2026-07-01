classdef unittest_mustBeTextOrPositiveInteger < matlab.unittest.TestCase
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

    function Test_1(~)
      mus1.CodeUtil.mustBeTextOrPositiveInteger("test")
    end  % function

    function Test_2(~)
      mus1.CodeUtil.mustBeTextOrPositiveInteger(1)
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "mustBeTextOrPositiveInteger:NotTextNorPositiveInteger")
      function test_target
        mus1.CodeUtil.mustBeTextOrPositiveInteger(0)
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target, "mustBeTextOrPositiveInteger:NotTextNorPositiveInteger")
      function test_target
        mus1.CodeUtil.mustBeTextOrPositiveInteger(0.999)
      end  % nested function
    end  % function

  end  % methods
end  % classdef
