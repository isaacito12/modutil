%[text] # Report test result
disp("UTC " + string(datetime("now", TimeZone="UTC", Format="yyyy-MM-dd HH:mm:ss"))) %[output:12491b59]
disp(matlabRelease) %[output:0fa1a17d]

assert(isfolder(fullfile(pwd, "ModelingUtilityForSimscape")), "Folder not found: ModelingUtilityForSimscape")
assert(isfolder(fullfile(pwd, "test-result")), "Folder not found: test-result")

test_result_file_fullpath = fullfile(pwd, "test-result", "test-result.xml");
assert(isfile(test_result_file_fullpath), "File not found: test-result.xml")

matlab_paths = split(string(path), ";");
if not(any(endsWith(matlab_paths, "ModelingUtilityForSimscape")))
  addpath("ModelingUtilityForSimscape")
end  % if

test_summary_table = TestUtil1.summarizeTestResult(test_result_file_fullpath);

disp(test_summary_table.Properties.CustomProperties) %[output:0626591a]
disp(test_summary_table) %[output:74cba6b8]
%[text] *Copyright 2025-2026 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:12491b59]
%   data: {"dataType":"text","outputData":{"text":"UTC 2026-01-05 20:07:32\n","truncated":false}}
%---
%[output:0fa1a17d]
%   data: {"dataType":"text","outputData":{"text":"  <a href=\"matlab:helpPopup('matlabRelease')\" style=\"font-weight:bold\">matlabRelease<\/a> with properties:\n\n    Release: \"R2026a\"\n      Stage: \"prerelease\"\n     Update: 1\n       Date: 2025-11-19\n\n","truncated":false}}
%---
%[output:0626591a]
%   data: {"dataType":"text","outputData":{"text":"<a href=\"matlab:helpPopup('matlab.tabular.CustomProperties')\" style=\"font-weight:bold\">CustomProperties<\/a> with properties:\n\n              NumberOfTests: 14\n     TotalTestTimeInSeconds: 231.7459\n      MeanTestTimeInSeconds: 16.5533\n    MedianTestTimeInSeconds: 3.6635\n\n","truncated":false}}
%---
%[output:74cba6b8]
%   data: {"dataType":"text","outputData":{"text":"               <strong>TestClass<\/strong>                           <strong>TestFunction<\/strong>                <strong>TestTimeInSeconds<\/strong>\n    <strong>________________________________<\/strong>    <strong>___________________________________<\/strong>    <strong>_________________<\/strong>\n\n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_3\"            125.17     \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_2_2\"          63.688     \n    \"PassingTestsForModelingUtility\"    \"PassingTest_3\"                              10.438     \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_2_1\"          9.2624     \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_8\"            7.1324     \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_7\"            4.0529     \n    \"PassingTestsForModelingUtility\"    \"PassingTest_2\"                              3.8633     \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_1\"            3.4636     \n    \"PassingTestsForModelingUtility\"    \"PassingTest_1\"                              2.4441     \n    \"PassingTestsForModelingUtility\"    \"app_launches_without_warnings_6\"            1.7858     \n    \"PassingTestsForModelingUtility\"    \"PassingTest_4\"                             0.18094     \n    \"PassingTestsForModelingUtility\"    \"PassingTest_6\"                             0.12681     \n    \"PassingTestsForModelingUtility\"    \"PassingTest_7\"                            0.085887     \n    \"PassingTestsForModelingUtility\"    \"PassingTest_5\"                            0.055466     \n\n","truncated":false}}
%---
