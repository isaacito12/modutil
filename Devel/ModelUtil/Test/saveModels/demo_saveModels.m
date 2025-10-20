%[text] # saveModels demo
%[text] 
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
%   data: {"dataType":"text","outputData":{"text":"This is MATLAB R2025b.\nNumber of model files found: 15\nThis is dry run.\nAll model files were already saved in this MATLAB release.\n","truncated":false}}
%---
%[output:08dacc67]
%   data: {"dataType":"text","outputData":{"text":"     0\n\n","truncated":false}}
%---
%[output:9e2de35e]
%   data: {"dataType":"text","outputData":{"text":"    <strong>to_be_saved<\/strong>                                     <strong>modelfiles_relpath<\/strong>                                 \n    <strong>___________<\/strong>    <strong>____________________________________________________________________________________<\/strong>\n\n       false       \"Test\\checkEditInCallbackButton\\testmodel_checkEditInCallbackButton.mdl\"            \n       false       \"Test\\checkEditInCallbackButton\\testmodel_checkEditInCallbackButton_emptycode.mdl\"  \n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton.mdl\"        \n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton_empty.mdl\"  \n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton_refsub1.mdl\"\n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton_refsub2.mdl\"\n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton_refsub3.mdl\"\n       false       \"Test\\checkRefSubInSetParam\\testmodel_checkRefSubInSetParam.mdl\"                    \n\n","truncated":false}}
%---
%[output:5cb688bb]
%   data: {"dataType":"text","outputData":{"text":"     0\n\n","truncated":false}}
%---
%[output:4c495a35]
%   data: {"dataType":"text","outputData":{"text":"    <strong>to_be_saved<\/strong>                                     <strong>modelfiles_relpath<\/strong>                                 \n    <strong>___________<\/strong>    <strong>____________________________________________________________________________________<\/strong>\n\n       false       \"Test\\checkEditInCallbackButton\\testmodel_checkEditInCallbackButton.mdl\"            \n       false       \"Test\\checkEditInCallbackButton\\testmodel_checkEditInCallbackButton_emptycode.mdl\"  \n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton.mdl\"        \n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton_empty.mdl\"  \n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton_refsub1.mdl\"\n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton_refsub2.mdl\"\n       false       \"Test\\checkRefSubInCallbackButton\\testmodel_checkRefSubInCallbackButton_refsub3.mdl\"\n       false       \"Test\\checkRefSubInSetParam\\testmodel_checkRefSubInSetParam.mdl\"                    \n\n","truncated":false}}
%---
