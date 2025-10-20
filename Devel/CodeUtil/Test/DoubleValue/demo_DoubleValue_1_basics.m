%[text] # DoubleValue demo 1
%[text] ## Basics
%[text] Create a default `DoubleValue` object.
a = CodeUtil1.DoubleValue;
disp(a) %[output:7dcbaca1]
%[text] Set a text representing numeric data to `ValueText`, and `MainDobuleValue` is updated.
a.ValueText = "[3 2 1]";
disp(a) %[output:77fad892]
%[text] Use `MainDoubleValue` to set a double value.
dval_v = CodeUtil1.DoubleValue;
dval_v.MainDoubleValue = [1 2];
disp(dval_v) %[output:675edd41]
%[text] Notice the difference between `MainDoubleValue` and `ValueText`.
dval_v.ValueText = "[1 2]";
disp(dval_v) %[output:54c0d547]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:7dcbaca1]
%   data: {"dataType":"text","outputData":{"text":"  <a href=\"matlab:helpPopup('CodeUtil1.DoubleValue')\" style=\"font-weight:bold\">DoubleValue<\/a> with properties:\n\n          ValueText: \"\"\n    MainDoubleValue: NaN\n\n","truncated":false}}
%---
%[output:77fad892]
%   data: {"dataType":"text","outputData":{"text":"  <a href=\"matlab:helpPopup('CodeUtil1.DoubleValue')\" style=\"font-weight:bold\">DoubleValue<\/a> with properties:\n\n          ValueText: \"[3 2 1]\"\n    MainDoubleValue: [3 2 1]\n\n","truncated":false}}
%---
%[output:675edd41]
%   data: {"dataType":"text","outputData":{"text":"  <a href=\"matlab:helpPopup('CodeUtil1.DoubleValue')\" style=\"font-weight:bold\">DoubleValue<\/a> with properties:\n\n          ValueText: \"[1, 2]\"\n    MainDoubleValue: [1 2]\n\n","truncated":false}}
%---
%[output:54c0d547]
%   data: {"dataType":"text","outputData":{"text":"  <a href=\"matlab:helpPopup('CodeUtil1.DoubleValue')\" style=\"font-weight:bold\">DoubleValue<\/a> with properties:\n\n          ValueText: \"[1 2]\"\n    MainDoubleValue: [1 2]\n\n","truncated":false}}
%---
