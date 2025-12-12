%[text] # Test summary
assert(isfolder("ModelingUtilityForSimscape"))
assert(isfile(fullfile(pwd, "test-result", "test-result.xml")))
disp("UTC " + string(datetime("now", TimeZone="UTC", Format="yyyy-MM-dd HH:mm:ss"))) %[output:5f9fa7d2]
disp(matlabRelease) %[output:08eaa916]
addpath("ModelingUtilityForSimscape")
summary_table = TestUtil1.summarizeTestResult(fullfile(pwd, "test-result", "test-result.xml"));
rmpath("ModelingUtilityForSimscape")
disp(summary_table.Properties.CustomProperties) %[output:1a2e6c41]
disp(summary_table) %[output:8cc0c360]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:5f9fa7d2]
%   data: {"dataType":"text","outputData":{"text":"UTC 2025-12-12 13:41:12\n","truncated":false}}
%---
%[output:08eaa916]
%   data: {"dataType":"text","outputData":{"text":"  <a href=\"matlab:helpPopup('matlabRelease')\" style=\"font-weight:bold\">matlabRelease<\/a> with properties:\n\n    Release: \"R2025b\"\n      Stage: \"release\"\n     Update: 2\n       Date: 16-Oct-2025\n\n","truncated":false}}
%---
%[output:1a2e6c41]
%   data: {"dataType":"text","outputData":{"text":"<a href=\"matlab:helpPopup('matlab.tabular.CustomProperties')\" style=\"font-weight:bold\">CustomProperties<\/a> with properties:\n\n          NumTests: 14\n     TotalTestTime: 282.1296\n      MeanTestTime: 20.1521\n    MedianTestTime: 0.9987\n\n","truncated":false}}
%---
%[output:8cc0c360]
%   data: {"dataType":"text","outputData":{"text":"               <strong>TestClass<\/strong>                           <strong>TestFunction<\/strong>                <strong>TestTime<\/strong> \n    <strong>________________________________<\/strong>    <strong>___________________________________<\/strong>    <strong>_________<\/strong>\n\n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_2_1\"       70.336\n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_8\"          69.65\n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_2_2\"       68.302\n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_3\"         67.035\n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_7\"         2.4406\n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_6\"         1.7859\n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_1\"         1.5972\n    \"PassingTestsForModelingUtility\"    \"PassingTest_1\"                           0.4002\n    \"PassingTestsForModelingUtility\"    \"PassingTest_3\"                          0.29058\n    \"PassingTestsForModelingUtility\"    \"PassingTest_2\"                          0.14026\n    \"PassingTestsForModelingUtility\"    \"PassingTest_4\"                         0.075642\n    \"PassingTestsForModelingUtility\"    \"PassingTest_7\"                          0.03709\n    \"PassingTestsForModelingUtility\"    \"PassingTest_6\"                         0.033139\n    \"PassingTestsForModelingUtility\"    \"PassingTest_5\"                        0.0059624\n\n","truncated":false}}
%---
