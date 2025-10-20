%[text] # searchText demo
%[text] Find `*.m` files containing "Copright" in the current folder.
search_session = SearchUtil1.searchText(...
  "Copyright", ...
  FileTypes = "*.m", ...
  TargetFolder = pwd, ...
  IncludeSubfolders = false );

disp(search_session.Searcher.States.TargetFolder) %[output:228d5540]
disp(height(search_session.Result)) %[output:6d63be20]
disp(search_session.Result) %[output:87d08ff4]
%%
%[text] Do the same search as above, but exclude Live Scripts.
search_session = SearchUtil1.searchText( ...
  "Copyright", ...
  FileTypes = "*.m", ...
  ExcludeLiveScript = true, ...
  TargetFolder = pwd, ...
  IncludeSubfolders = false );

disp(search_session.Searcher.States.TargetFolder) %[output:3370169c]
disp(height(search_session.Result)) %[output:2796c09c]
disp(search_session.Result) %[output:3df8b82b]
%%
%[text] Do the same search as above two cases, but exclude MATLAB code files.
search_session = SearchUtil1.searchText( ...
  "Copyright", ...
  FileTypes = "*.m", ...
  ExcludeMATLABCodeFile = true, ...
  TargetFolder = pwd, ...
  IncludeSubfolders = false );

disp(search_session.Searcher.States.TargetFolder) %[output:3e2009b5]
disp(height(search_session.Result)) %[output:173781eb]
disp(search_session.Result) %[output:9e70ac9a]
%%
%[text] Get the command argument as a string.
search_session = SearchUtil1.searchText( ...
  (lineBoundary|textBoundary("start")) + "Copyright" + textBoundary("end"), ...
  FileTypes = ["sample*.m", "sample*.mdl"]);

argtext = getCommandArgumentText(search_session.Searcher);
disp(argtext) %[output:8e9aa1a7]
%%
%[text] If the `FileTypes` option is specified, other options to specify file types are ignored. In the following case, the `CustomFileTypes` option is specified but ignored.
search_session = SearchUtil1.searchText( ...
  "Copyright", ...
  FileTypes = ["sample*.m", "sample*.mdl"], ...
  CustomFileTypes = "*.md", ... This is ignored due to FileTypes.
  TargetFolder = pwd, ...
  IncludeSubfolders = true );

assert(not(isempty(search_session.Result)), "No match.")
disp(search_session.Searcher.States.TargetFolder) %[output:9ee52986]
disp(height(search_session.Result)) %[output:3aab07fd]
disp(search_session.Result(:, ["FilePath", "LineNumber"])) %[output:7413d005]
%%
%[text] Unlike the above case which uses the `FileTypes` option, the follwoing case uses the `CustomFileTypes` option. In this case, the SearchMarkdown option takes effect.
search_session = SearchUtil1.searchText( ...
  "Copyright 2025", ...
  SearchMarkdown = true, ...
  CustomFileTypes = ["sample*.m", "sample*.mdl"], ...
  TargetFolder = pwd, ...
  IncludeSubfolders = true );

assert(not(isempty(search_session.Result)), "No match.")
disp(search_session.Searcher.States.TargetFolder) %[output:68bf8b8e]
disp(height(search_session.Result)) %[output:1ba7d804]
disp(search_session.Result(:, ["FilePath", "LineNumber"])) %[output:6192d71c]
%%
search_session = SearchUtil1.searchText( ...
  "test various aspects", ...
  IgnoreCase = true, ...
  SearchMATLAB = true, ...
  SearchMarkdown = true, ...
  TargetFolder = pwd, ...
  IncludeSubfolders = true );

assert(not(isempty(search_session.Result)), "No match.")
disp(search_session.Searcher.States.TargetFolder) %[output:4f5dab36]
disp(height(search_session.Result)) %[output:975f2974]
disp(search_session.Result(:, ["FilePath", "LineNumber"])) %[output:9d4b0ca4]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:228d5540]
%   data: {"dataType":"text","outputData":{"text":"C:\\local\\gh-isaacito12-bev\\bev25b\n","truncated":false}}
%---
%[output:6d63be20]
%   data: {"dataType":"text","outputData":{"text":"     8\n\n","truncated":false}}
%---
%[output:87d08ff4]
%   data: {"dataType":"text","outputData":{"text":"                <strong>FilePath<\/strong>                <strong>LineNumber<\/strong>                         <strong>LineText<\/strong>                      \n    <strong>________________________________<\/strong>    <strong>__________<\/strong>    <strong>___________________________________________________<\/strong>\n\n    \"BEVProjectNavigationApp.m\"              5        \"% Copyright 2024-2025 The MathWorks, Inc.\"        \n    \"BEVProject_Description.m\"              35        \"%[text] *Copyright 2020-2025 The MathWorks, Inc.*\"\n    \"buildfile.m\"                           12        \"% Copyright 2023-2025 The MathWorks, Inc.\"        \n    \"uitest_BEVProject.m\"                   12        \"  % Copyright 2024-2025 The MathWorks, Inc.\"      \n    \"uiuptodatetest_BEVProject.m\"           12        \"  % Copyright 2024-2025 The MathWorks, Inc.\"      \n    \"unittest_BEVProject.m\"                 13        \"  % Copyright 2021-2025 The MathWorks, Inc.\"      \n    \"unittest_BEVProject_settings.m\"        15        \"  % Copyright 2021-2025 The MathWorks, Inc.\"      \n    \"uptodatetest_BEVProject.m\"             15        \"  % Copyright 2021-2025 The MathWorks, Inc.\"      \n\n","truncated":false}}
%---
%[output:3370169c]
%   data: {"dataType":"text","outputData":{"text":"C:\\local\\gh-isaacito12-bev\\bev25b\n","truncated":false}}
%---
%[output:2796c09c]
%   data: {"dataType":"text","outputData":{"text":"     7\n\n","truncated":false}}
%---
%[output:3df8b82b]
%   data: {"dataType":"text","outputData":{"text":"                <strong>FilePath<\/strong>                <strong>LineNumber<\/strong>                      <strong>LineText<\/strong>                   \n    <strong>________________________________<\/strong>    <strong>__________<\/strong>    <strong>_____________________________________________<\/strong>\n\n    \"BEVProjectNavigationApp.m\"              5        \"% Copyright 2024-2025 The MathWorks, Inc.\"  \n    \"buildfile.m\"                           12        \"% Copyright 2023-2025 The MathWorks, Inc.\"  \n    \"uitest_BEVProject.m\"                   12        \"  % Copyright 2024-2025 The MathWorks, Inc.\"\n    \"uiuptodatetest_BEVProject.m\"           12        \"  % Copyright 2024-2025 The MathWorks, Inc.\"\n    \"unittest_BEVProject.m\"                 13        \"  % Copyright 2021-2025 The MathWorks, Inc.\"\n    \"unittest_BEVProject_settings.m\"        15        \"  % Copyright 2021-2025 The MathWorks, Inc.\"\n    \"uptodatetest_BEVProject.m\"             15        \"  % Copyright 2021-2025 The MathWorks, Inc.\"\n\n","truncated":false}}
%---
%[output:3e2009b5]
%   data: {"dataType":"text","outputData":{"text":"C:\\local\\gh-isaacito12-bev\\bev25b\n","truncated":false}}
%---
%[output:173781eb]
%   data: {"dataType":"text","outputData":{"text":"     1\n\n","truncated":false}}
%---
%[output:9e70ac9a]
%   data: {"dataType":"text","outputData":{"text":"             <strong>FilePath<\/strong>             <strong>LineNumber<\/strong>                         <strong>LineText<\/strong>                      \n    <strong>__________________________<\/strong>    <strong>__________<\/strong>    <strong>___________________________________________________<\/strong>\n\n    \"BEVProject_Description.m\"        35        \"%[text] *Copyright 2020-2025 The MathWorks, Inc.*\"\n\n","truncated":false}}
%---
%[output:8e9aa1a7]
%   data: {"dataType":"text","outputData":{"text":"(lineBoundary | textBoundary(\"start\")) + \"Copyright\" + textBoundary(\"end\"), IgnoreCase = true, MatchWholeWord = false, TargetFolder = \"C:\\local\\gh-isaacito12-bev\\bev25b\", IncludeSubfolders = false, FileTypes = [\"sample*.m\", \"sample*.mdl\"], ExcludeLiveScript = false, ExcludeMATLABCodeFile = false\n","truncated":false}}
%---
%[output:9ee52986]
%   data: {"dataType":"text","outputData":{"text":"C:\\local\\gh-isaacito12-bev\\bev25b\n","truncated":false}}
%---
%[output:3aab07fd]
%   data: {"dataType":"text","outputData":{"text":"    12\n\n","truncated":false}}
%---
%[output:7413d005]
%   data: {"dataType":"text","outputData":{"text":"                                                <strong>FilePath<\/strong>                                                <strong>LineNumber<\/strong>\n    <strong>________________________________________________________________________________________________<\/strong>    <strong>__________<\/strong>\n\n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 1\\samplefunction_11.m\"                       3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 1\\subfolder 11\\samplefunction_111.m\"         3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 2\\samplescript_21.m\"                         3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 3\\samplescript_31.m\"                         3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 3\\samplescript_32.m\"                         3    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder1\\samplefunction_11.m\"                       3    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder2\\samplescript21.m\"                          3    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder3\\samplescript31.m\"                          3    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder3\\samplescript32.m\"                          3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 1\\samplemodel_11a.mdl\"                     990    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 1\\subfolder 11\\samplemodel_111a.mdl\"       990    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder1\\samplemodel_11.mdl\"                      990    \n\n","truncated":false}}
%---
%[output:68bf8b8e]
%   data: {"dataType":"text","outputData":{"text":"C:\\local\\gh-isaacito12-bev\\bev25b\n","truncated":false}}
%---
%[output:1ba7d804]
%   data: {"dataType":"text","outputData":{"text":"    39\n\n","truncated":false}}
%---
%[output:6192d71c]
%   data: {"dataType":"text","outputData":{"text":"                                                              <strong>FilePath<\/strong>                                                              <strong>LineNumber<\/strong>\n    <strong>____________________________________________________________________________________________________________________________<\/strong>    <strong>__________<\/strong>\n\n    \"Components\\BatteryHighVoltage\\ToolTest\\refineOCVData\\markdown\\refineOCVData_sample_script.md\"                                      83    \n    \"Components\\BatteryHighVoltage\\ToolTest\\refineTerminalResistanceData\\markdown\\refineTerminalResistanceData_sample_script.md\"        83    \n    \"Components\\ControllerAndEnvironment\\TestComponents\\markdown\\BuildInputs_CtrlEnv_Vehicle_Simple.md\"                                 82    \n    \"Components\\MotorDriveUnit\\Model-Basic\\README.md\"                                                                                   34    \n    \"Components\\MotorDriveUnit\\Model-SystemThermal\\README.md\"                                                                           39    \n    \"Components\\MotorDriveUnit\\Utility\\README.md\"                                                                                        5    \n    \"Components\\Reducer\\InputsForTesting\\markdown\\BuildInputs_Reducer_AxleSide_Constant.md\"                                             82    \n    \"Components\\Reducer\\InputsForTesting\\markdown\\BuildInputs_Reducer_AxleSide_Flip.md\"                                                 90    \n    \"Components\\Reducer\\InputsForTesting\\markdown\\BuildInputs_Reducer_MotorSide_Constant.md\"                                            82    \n    \"Components\\Reducer\\InputsForTesting\\markdown\\BuildInputs_Reducer_MotorSide_Flip.md\"                                                88    \n    \"Components\\Reducer\\InputsForTesting\\markdown\\setupProbe_Reducer_Inputs.md\"                                                         45    \n    \"Components\\Reducer\\Model-Basic\\SimulationCases\\markdown\\Reducer_Basic_Constant.md\"                                                 57    \n    \"Components\\Reducer\\Model-Basic\\SimulationCases\\markdown\\Reducer_Basic_Flip.md\"                                                     57    \n    \"Components\\Reducer\\Model-Basic\\SimulationCases\\markdown\\profileSim_Reducer_Basic.md\"                                              175    \n    \"Components\\Vehicle1D\\AppFiles-PerformanceDesign\\markdown\\Vehicle1DPerformanceParameters_sample_script.md\"                          84    \n    \"Components\\VehicleSpeedReference\\Model-Constant\\markdown\\VehSpdRef_Constant_sample_script.md\"                                      25    \n    \"Components\\VehicleSpeedReference\\Model-FTP75\\markdown\\VehSpdRef_FTP75_sample_script.md\"                                            26    \n    \"Components\\VehicleSpeedReference\\Model-HighSpeed\\markdown\\BuildSignal_VehSpdRef_HighSpeed.md\"                                      51    \n    \"Components\\VehicleSpeedReference\\Model-HighSpeed\\markdown\\VehSpdRef_HighSpeed_sample_script.md\"                                    25    \n    \"Components\\VehicleSpeedReference\\Model-Simple\\markdown\\VehSpdRef_Simple_sample_script.md\"                                          25    \n    \"FYI\\README.md\"                                                                                                                     37    \n    \"Utility\\FileTool\\Test\\isPlainTextLiveScript\\samplefolder\\README.md\"                                                                 8    \n    \"Utility\\ModelTool\\README.md\"                                                                                                       10    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\README.md\"                                                                         8    \n    \"Utility\\SignalTool\\README.md\"                                                                                                      19    \n    \"Utility\\SignalTool\\Test\\plotDifference\\markdown\\demo_plotDifference.md\"                                                            32    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\README.md\"                                                                        8    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 1\\samplefunction_11.m\"                                                   3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 1\\subfolder 11\\samplefunction_111.m\"                                     3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 2\\samplescript_21.m\"                                                     3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 3\\samplescript_31.m\"                                                     3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 3\\samplescript_32.m\"                                                     3    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder1\\samplefunction_11.m\"                                                   3    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder2\\samplescript21.m\"                                                      3    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder3\\samplescript31.m\"                                                      3    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder3\\samplescript32.m\"                                                      3    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 1\\samplemodel_11a.mdl\"                                                 990    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\subfolder 1\\subfolder 11\\samplemodel_111a.mdl\"                                   990    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\subfolder1\\samplemodel_11.mdl\"                                                  990    \n\n","truncated":false}}
%---
%[output:4f5dab36]
%   data: {"dataType":"text","outputData":{"text":"C:\\local\\gh-isaacito12-bev\\bev25b\n","truncated":false}}
%---
%[output:975f2974]
%   data: {"dataType":"text","outputData":{"text":"     5\n\n","truncated":false}}
%---
%[output:9d4b0ca4]
%   data: {"dataType":"text","outputData":{"text":"                                  <strong>FilePath<\/strong>                                  <strong>LineNumber<\/strong>\n    <strong>____________________________________________________________________<\/strong>    <strong>__________<\/strong>\n\n    \"Utility\\SearchUtil\\Test\\searchText\\demo_searchText.m\"                      72    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\demo_searchText.m\"                  64    \n    \"Utility\\FileTool\\Test\\isPlainTextLiveScript\\samplefolder\\README.md\"         4    \n    \"Utility\\SearchUtil\\Test\\searchText\\sample folder\\README.md\"                 4    \n    \"Utility\\TextSearchUtil\\Test\\searchText\\testfolder\\README.md\"                4    \n\n","truncated":false}}
%---
