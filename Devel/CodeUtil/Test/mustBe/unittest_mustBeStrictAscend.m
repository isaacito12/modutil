classdef unittest_mustBeStrictAscend < matlab.unittest.TestCase
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

    function Test_1(testcase)
      % A scalar value is valid.
      verifyWarningFree(testcase, @() CodeUtil1.mustBeStrictAscend(0))
    end  % function

    function Test_2(testcase)
      verifyWarningFree(testcase, @() CodeUtil1.mustBeStrictAscend([0.1 0.2]))
    end  % function

    function Test_3(testcase)
      verifyWarningFree(testcase, @() CodeUtil1.mustBeStrictAscend((-4 : 2)))
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "mustBeStrictAscend:InvalidData")
      function test_target
        CodeUtil1.mustBeStrictAscend([2.2 0.1])
      end  % nested function
    end  % function

  end  % methods
end  % classdef
