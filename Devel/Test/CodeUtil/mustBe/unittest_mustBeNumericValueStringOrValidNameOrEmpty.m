classdef unittest_mustBeNumericValueStringOrValidNameOrEmpty < matlab.unittest.TestCase
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
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("0"))
    end  % function

    function Test_2(testcase)
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("a"))
    end  % function

    function Test_3(testcase)
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("p.q"))
    end  % function

    function Test_4(testcase)
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("p.q.r"))
    end  % function

    function Test_value_1(testcase)
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("value(x)"))
    end  % function

    function Test_value_2(testcase)
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("value(x, ""1"")"))
    end  % function

    function Test_value_3(testcase)
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("value(x, '1')"))
    end  % function

    function Test_value_4(testcase)
      % Pass a char array.
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty('value(x, "1")'))
    end  % function

    function Test_value_5(testcase)
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("value(p.q, ""s"")"))
    end  % function

    function Test_value_6(testcase)
      verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("value(p.q.r, ""m/s^2"")"))
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "mustBeNumericValueStringOrValidNameOrEmpty:NotString")
      function test_target
        mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty(0)
      end  % nested function
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() test_target, "mustBeNumericValueStringOrValidNameOrEmpty:NotString")
      function test_target
        mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty(pi)
      end  % nested function
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @() test_target, "mustBeNumericValueStringOrValidNameOrEmpty:ValidationFailed")
      function test_target
        mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("-k")
      end  % nested function
    end  % function

    function Test_error_4(testcase)
      verifyError(testcase, @() test_target, "mustBeNumericValueStringOrValidNameOrEmpty:ValidationFailed")
      function test_target
        verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("p.q.r.s"))
      end  % nested function
    end  % function

    function Test_error_5(testcase)
      verifyError(testcase, @() test_target, "mustBeNumericValueStringOrValidNameOrEmpty:ValidationFailed")
      function test_target
        verifyWarningFree(testcase, @() mus1.CodeUtil.mustBeNumericValueStringOrValidNameOrEmpty("value(p.q.r.s, ""N*m"")"))
      end  % nested function
    end  % function

  end  % methods
end  % classdef
