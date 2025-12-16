%[text] # Test summary
assert(isfolder("ModelingUtilityForSimscape"))
if not(isfile(fullfile(pwd, "test-result", "test-result.xml")))
  disp("Test result file was not found.")

  return

end  % if

disp("UTC " + string(datetime("now", TimeZone="UTC", Format="yyyy-MM-dd HH:mm:ss"))) %[output:2dc15c54]
disp(matlabRelease) %[output:6c33f58d]
addpath("ModelingUtilityForSimscape")
summary_table = TestUtil1.summarizeTestResult(fullfile(pwd, "test-result", "test-result.xml"));
rmpath("ModelingUtilityForSimscape")
disp(summary_table.Properties.CustomProperties) %[output:858e00c9]
disp(summary_table) %[output:7f62f9d0]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:2dc15c54]
%   data: {"dataType":"text","outputData":{"text":"UTC 2025-12-16 13:12:31\n","truncated":false}}
%---
%[output:6c33f58d]
%   data: {"dataType":"text","outputData":{"text":"  <a href=\"matlab:helpPopup('matlabRelease')\" style=\"font-weight:bold\">matlabRelease<\/a> with properties:\n\n    Release: \"R2025b\"\n      Stage: \"release\"\n     Update: 2\n       Date: 16-Oct-2025\n\n","truncated":false}}
%---
%[output:858e00c9]
%   data: {"dataType":"text","outputData":{"text":"<a href=\"matlab:helpPopup('matlab.tabular.CustomProperties')\" style=\"font-weight:bold\">CustomProperties<\/a> with properties:\n\n              NumberOfTests: 15\n     TotalTestTimeInSeconds: 289.4968\n      MeanTestTimeInSeconds: 19.2998\n    MedianTestTimeInSeconds: 0.3908\n\n","truncated":false}}
%---
%[output:7f62f9d0]
%   data: {"dataType":"text","outputData":{"text":"               <strong>TestClass<\/strong>                           <strong>TestFunction<\/strong>                <strong>TestTimeInSeconds<\/strong>\n    <strong>________________________________<\/strong>    <strong>___________________________________<\/strong>    <strong>_________________<\/strong>\n\n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_8\"             71.538    \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_2_1\"           70.731    \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_2_2\"           70.421    \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_3\"              68.01    \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_7\"             3.3797    \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_6\"             2.3259    \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_1\"             1.7637    \n    \"PassingTestsForModelingUtility\"    \"PassingTest_3\"                              0.39078    \n    \"PassingTestsForModelingUtility\"    \"PassingTest_1\"                              0.34632    \n    \"PassingTestsForModelingUtility\"    \"PassingTest_2\"                              0.18612    \n    \"test_summary\"                      \"test_summary\"                               0.13445    \n    \"PassingTestsForModelingUtility\"    \"PassingTest_4\"                              0.11563    \n    \"PassingTestsForModelingUtility\"    \"PassingTest_6\"                             0.096336    \n    \"PassingTestsForModelingUtility\"    \"PassingTest_7\"                             0.051617    \n    \"PassingTestsForModelingUtility\"    \"PassingTest_5\"                            0.0053014    \n\n","truncated":false}}
%---
