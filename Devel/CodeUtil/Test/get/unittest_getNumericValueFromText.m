classdef unittest_getNumericValueFromText < matlab.unittest.TestCase
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
      x = CodeUtil1.getNumericValueFromText("0");
      verifyEqual(testcase, x, 0)
    end  % function

    function Test_2(testcase)
      x = CodeUtil1.getNumericValueFromText("-1.23");
      verifyTrue(testcase, abs(x + 1.23) < 1e-8)
    end  % function

    function Test_3(testcase)
      % A real value is converted to a string, and thus this must work.
      x = CodeUtil1.getNumericValueFromText(-1.23);
      verifyTrue(testcase, abs(x + 1.23) < 1e-8)
    end  % function

    function Test_workspace_1(testcase)
      evalin("base", "x = 1.2345;")
      x = CodeUtil1.getNumericValueFromText("x");
      verifyTrue(testcase, abs(x - 1.2345) < 1e-8)
      evalin("base", "clearvars x")
    end  % function

    function Test_workspace_2(testcase)
      evalin("base", "s.t = 1.2345;")
      x = CodeUtil1.getNumericValueFromText("s.t");
      verifyTrue(testcase, abs(x - 1.2345) < 1e-8)
      evalin("base", "clearvars s")
    end  % function

    function Test_workspace_3(testcase)
      evalin("base", "p = struct; p.q.r = 1.2345;")
      x = CodeUtil1.getNumericValueFromText("p.q.r");
      verifyTrue(testcase, abs(x - 1.2345) < 1e-8)
      evalin("base", "clearvars p")
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "MATLAB:validation:IncompatibleSize")
      function test_target
        CodeUtil1.getNumericValueFromText([0 1])
      end  % nested function
    end  % function

  end  % methods
end  % classdef
