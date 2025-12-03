%[text] # saveModels demo
[num_files_to_be_saved, tbl] = ModelUtil1.saveModels( DryRun = true ); %[output:98e53862]
disp(num_files_to_be_saved) %[output:08dacc67]
head(tbl) %[output:9e2de35e]
%%
[num_files_to_be_saved, tbl] = ModelUtil1.saveModels( ...
  DryRun = true, ...
  DisplayInfo = false, ...
  Target = "FolderTree", ...
  SpecifyTopFolder = true, ...
  TopFolder = pwd );

disp(num_files_to_be_saved) %[output:5cb688bb]
head(tbl) %[output:4c495a35]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:98e53862]
%   data: {"dataType":"text","outputData":{"text":"This is MATLAB R2025b.\nNumber of model files found: 42\nThis is dry run.\n[1\/15] AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_1_fric_24b.mdl\n[2\/15] AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_2_fric2_24b.mdl\n[3\/15] AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_3_motor_24b.mdl\n[4\/15] AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_4_lut_24b.mdl\n[5\/15] AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_5_mix_24b.mdl\n[6\/15] AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_6_invalid_24b.mdl\n[7\/15] FileUtil\\Test\\isModelFile\\sample folder\\samplemodel_isModelFile_1.mdl\n[8\/15] FileUtil\\Test\\isModelFile\\sample folder\\subfolder 1\\samplemodel_isModelFile_11.mdl\n[9\/15] FileUtil\\Test\\isModelFile\\sample folder\\subfolder 2\\samplemodel_isModelFile_21.mdl\n[10\/15] SignalUtil\\Test\\SignalDesignApp\\samplemodel_SignalDesignApp.mdl\n[11\/15] SignalUtil\\Test\\SignalDesignApp\\samplemodel_SignalDesignApp_24b.mdl\n[12\/15] SignalUtil\\Test\\getTimetableFromLoggedSignal\\testmodel_getTimetableFromLoggedSignal.mdl\n[13\/15] FileUtil\\Test\\isModelFile\\sample folder\\samplemodel_isModelFile_2.slx\n[14\/15] FileUtil\\Test\\isModelFile\\sample folder\\subfolder 1\\samplemodel_isModelFile_12.slx\n[15\/15] FileUtil\\Test\\isModelFile\\sample folder\\subfolder 2\\samplemodel_isModelFile_22.slx\n","truncated":false}}
%---
%[output:08dacc67]
%   data: {"dataType":"text","outputData":{"text":"    15\n\n","truncated":false}}
%---
%[output:9e2de35e]
%   data: {"dataType":"text","outputData":{"text":"    <strong>to_be_saved<\/strong>                                  <strong>modelfiles_relpath<\/strong>                               \n    <strong>___________<\/strong>    <strong>_______________________________________________________________________________<\/strong>\n\n       false       \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_1_fric.mdl\"     \n       true        \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_1_fric_24b.mdl\" \n       false       \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_2_fric2.mdl\"    \n       true        \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_2_fric2_24b.mdl\"\n       false       \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_3_motor.mdl\"    \n       true        \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_3_motor_24b.mdl\"\n       false       \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_4_lut.mdl\"      \n       true        \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_4_lut_24b.mdl\"  \n\n","truncated":false}}
%---
%[output:5cb688bb]
%   data: {"dataType":"text","outputData":{"text":"    15\n\n","truncated":false}}
%---
%[output:4c495a35]
%   data: {"dataType":"text","outputData":{"text":"    <strong>to_be_saved<\/strong>                                  <strong>modelfiles_relpath<\/strong>                               \n    <strong>___________<\/strong>    <strong>_______________________________________________________________________________<\/strong>\n\n       false       \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_1_fric.mdl\"     \n       true        \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_1_fric_24b.mdl\" \n       false       \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_2_fric2.mdl\"    \n       true        \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_2_fric2_24b.mdl\"\n       false       \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_3_motor.mdl\"    \n       true        \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_3_motor_24b.mdl\"\n       false       \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_4_lut.mdl\"      \n       true        \"AppUtil\\Test\\BlockSelectorUI\\samplemodel_BlockSelectorUI_test_4_lut_24b.mdl\"  \n\n","truncated":false}}
%---
