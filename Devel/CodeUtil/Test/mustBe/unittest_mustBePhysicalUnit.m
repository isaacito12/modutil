classdef unittest_mustBePhysicalUnit < matlab.unittest.TestCase
  % Class-based unit test

  % Author Class-Based Unit Tests in MATLAB
  % https://www.mathworks.com/help/matlab/matlab_prog/author-class-based-unit-tests-in-matlab.html
  %
  % matlab.unittest.TestCase Class
  % https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html
  %
  % Test Browser
  % https://www.mathworks.com/help/matlab/ref/testbrowser-app.html

  % Copyright 2026 The MathWorks, Inc.

  methods (Test)

    function Test_1(testcase)
      verifyWarningFree(testcase, @() CodeUtil1.mustBePhysicalUnit("1"))
    end  % function

    function Test_2(testcase)
      verifyWarningFree(testcase, @() CodeUtil1.mustBePhysicalUnit("s"))
    end  % function

    function Test_3(testcase)
      verifyWarningFree(testcase, @() CodeUtil1.mustBePhysicalUnit(["s", "m", "kg", "N*m/rpm"]))
    end  % function

    function Test_error_1(testcase)
      verifyError(testcase, @() CodeUtil1.mustBePhysicalUnit(), ...
        "MATLAB:minrhs")
    end  % function

    function Test_error_2(testcase)
      verifyError(testcase, @() CodeUtil1.mustBePhysicalUnit("-"), ...
        "physmod:common:units:core:parse:UnitSyntaxError")
    end  % function

    function Test_error_3(testcase)
      verifyError(testcase, @() CodeUtil1.mustBePhysicalUnit(["m", "*"]), ...
        "physmod:common:units:core:parse:UnitSyntaxError")
    end  % function

  end  % methods
end  % classdef
