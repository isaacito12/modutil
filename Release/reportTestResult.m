%[text] # Report test result
assert(isfolder("ModelingUtilityForSimscape"))
assert(isfile(fullfile(pwd, "test-result", "test-result.xml")))
disp("UTC " + string(datetime("now", TimeZone="UTC", Format="yyyy-MM-dd HH:mm:ss"))) %[output:5f9fa7d2]
disp(matlabRelease) %[output:08eaa916]

matlab_paths = split(string(path), ";");
if not(any(endsWith(matlab_paths, "ModelingUtilityForSimscape")))
  addpath("ModelingUtilityForSimscape")
end  % if

summary_table = TestUtil1.summarizeTestResult(fullfile(pwd, "test-result", "test-result.xml")); %[output:27ab1c96]

disp(summary_table.Properties.CustomProperties)
disp(summary_table)
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:5f9fa7d2]
%   data: {"dataType":"text","outputData":{"text":"UTC 2026-01-05 11:03:28\n","truncated":false}}
%---
%[output:08eaa916]
%   data: {"dataType":"text","outputData":{"text":"  <a href=\"matlab:helpPopup('matlabRelease')\" style=\"font-weight:bold\">matlabRelease<\/a> with properties:\n\n    Release: \"R2026a\"\n      Stage: \"prerelease\"\n     Update: 1\n       Date: 2025-11-19\n\n","truncated":false}}
%---
%[output:27ab1c96]
%   data: {"dataType":"error","outputData":{"errorType":"runtime","text":"Error using <a href=\"matlab:matlab.lang.internal.introspective.errorDocCallback('tabular\/dotListLength', 'C:\\Program Files\\MATLAB\\R2026aPR1\\toolbox\\matlab\\datatypes\\tabular\\@tabular\\dotListLength.m', 73)\" style=\"font-weight:bold\">indexing<\/a> (<a href=\"matlab: opentoline('C:\\Program Files\\MATLAB\\R2026aPR1\\toolbox\\matlab\\datatypes\\tabular\\@tabular\\dotListLength.m',73,0)\">line 73<\/a>)\nBrace indexing is not supported for variables of type struct.\n\nError in <a href=\"matlab:matlab.lang.internal.introspective.errorDocCallback('TestUtil1.summarizeTestResult', 'C:\\local\\modutil\\modeling-utility\\Release\\ModelingUtilityForSimscape\\+TestUtil1\\summarizeTestResult.m', 25)\" style=\"font-weight:bold\">TestUtil1.summarizeTestResult<\/a> (<a href=\"matlab: opentoline('C:\\local\\modutil\\modeling-utility\\Release\\ModelingUtilityForSimscape\\+TestUtil1\\summarizeTestResult.m',25,0)\">line 25<\/a>)\n  subresult_table = struct2table(result_table.testcase{ii});"}}
%---
