%[text] # DoubleValue demo 2
%[text] ## Link with the base workspace
%[text] `DoubleValue` objects can be linked with base workspace variables. Once linked, a change in a base workspace variable is detected by the `DoubleValue` object. As an example, first define a variable in the base workspace.
evalin("base", "bwv = struct;")
evalin("base", "bwv.S1 = [1 2];")
disp(bwv.S1) %[output:34bab304]
%[text] Create a `DoubleValue` object.
a = CodeUtil1.DoubleValue;
%[text] Set the base workspace variable to the `DoubleValue` object's `ValueText`.
a.ValueText = "bwv.S1";
disp(a) %[output:24b909b6]
%[text] Change the base workspace variable.
evalin("base", "bwv.S1 = [3 4];")
disp(bwv.S1) %[output:0b3646c7]
%[text] `MainDoubleValue` of the linked `DoubleValue` object has been updated too.
disp(a.MainDoubleValue) %[output:5fb7d824]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:34bab304]
%   data: {"dataType":"text","outputData":{"text":"     1     2\n\n","truncated":false}}
%---
%[output:24b909b6]
%   data: {"dataType":"text","outputData":{"text":"  <a href=\"matlab:helpPopup('CodeUtil1.DoubleValue')\" style=\"font-weight:bold\">DoubleValue<\/a> with properties:\n\n          ValueText: \"bwv.S1\"\n    MainDoubleValue: [1 2]\n\n","truncated":false}}
%---
%[output:0b3646c7]
%   data: {"dataType":"text","outputData":{"text":"     3     4\n\n","truncated":false}}
%---
%[output:5fb7d824]
%   data: {"dataType":"text","outputData":{"text":"     3     4\n\n","truncated":false}}
%---
