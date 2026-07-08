%[text] # checkRefSubInCallbackButton demo
%[text] This script uses a model saved in R2024b.
model_name = "checkRefSubInCallbackButton_SampleModel_24b";
result = mus1.ModelUtil.checkRefSubInCallbackButton(model_name, DisplayInfo=true); %[output:21874aca]
disp(result) %[output:9172b517]
%[text] *Copyright 2025-2026 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline","rightPanelPercent":40}
%---
%[output:21874aca]
%   data: {"dataType":"text","outputData":{"text":"Checking Callback Button [1]: checkRefSubInCallbackButton_SampleModel_24b\/Select 1\nChecking Callback Button [2]: checkRefSubInCallbackButton_SampleModel_24b\/Select 2\nChecking Callback Button [3]: checkRefSubInCallbackButton_SampleModel_24b\/Select 3\nChecking Callback Button [4]: checkRefSubInCallbackButton_SampleModel_24b\/Select 4\nChecking Callback Button [5]: checkRefSubInCallbackButton_SampleModel_24b\/Select 5\nChecking Callback Button [6]: checkRefSubInCallbackButton_SampleModel_24b\/Select 6\nChecking Callback Button [7]: checkRefSubInCallbackButton_SampleModel_24b\/Subsystem\/Select 7\nChecking Callback Button [8]: checkRefSubInCallbackButton_SampleModel_24b\/Subsystem\/Select 8\n","truncated":false}}
%---
%[output:9172b517]
%   data: {"dataType":"text","outputData":{"text":"    <strong>BlockPath<\/strong>    <strong>FileName<\/strong>    <strong>Found<\/strong>    <strong>IsRefSub<\/strong>\n    <strong>_________<\/strong>    <strong>________<\/strong>    <strong>_____<\/strong>    <strong>________<\/strong>\n\n\n","truncated":false}}
%---
