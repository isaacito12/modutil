classdef unittest_getNumberArrayFromText < matlab.unittest.TestCase
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
      x = CodeUtil1.getNumberArrayFromText("0.1");
      verifyTrue(testcase, abs(x - 0.1) < 1e-10)
    end  % function

    function Test_2(testcase)
      x = CodeUtil1.getNumberArrayFromText("[0 1]");
      verifyTrue(testcase, all(abs(x - [0 1]) < 1e-10))
    end  % function

    function Test_3(testcase)
      x = CodeUtil1.getNumberArrayFromText("[0; 1]");
      verifyTrue(testcase, all(abs(x - [0; 1]) < 1e-10))
    end  % function

    function Test_4(testcase)
      x = CodeUtil1.getNumberArrayFromText(" [ 1, 2 3 ;  4, 5 6 ] ");
      verifyTrue(testcase, all(all(abs(x - [1 2 3; 4 5 6]) < 1e-10)))
    end  % function

    function Test_5(testcase)
      % If the argument can be convertable to a string, it works.
      x = CodeUtil1.getNumberArrayFromText(1.23);
      verifyTrue(testcase, abs(x - 1.23) < 1e-10)
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @() test_target, "MATLAB:validation:IncompatibleSize")
      function test_target
        CodeUtil1.getNumberArrayFromText([0 1])
      end  % nested function
    end  % function

  end  % methods
end  % classdef
