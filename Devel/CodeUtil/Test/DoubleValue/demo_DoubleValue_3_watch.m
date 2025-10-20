%[text] # DoubleValue demo 3
%[text] ## Watch DoubleValue objects
Length = CodeUtil1.DoubleValue(ValueText="1");
Area = CodeUtil1.DoubleValue(ValueText="1");
%[text] 
function deriveArea(L, A)
arguments (Input)
  L (1,:) CodeUtil1.DoubleValue
  A (1,:) CodeUtil1.DoubleValue
end
L_dval = L.MainDoubleValue;
A_dval = L_dval.^2;
A.MainDoubleValue = A_dval;
end
%[text] Set up a ***PreGet*** callback for the `Area.MainDoubleValue` as an event listener. The PreGet callback is triggered right before `Area.MainDoubleValue` is read.
addlistener(Area, "MainDoubleValue", "PreGet", @(~,~) deriveArea(Length,Area));
%%
%[text] Currently `Length` and `Area` are defined as follows.
disp(Length.MainDoubleValue) %[output:6498d5a6]
disp(Area.MainDoubleValue) %[output:845ecc88]
%[text] Change `Length`.
Length.ValueText = "2";
disp(Length.MainDoubleValue) %[output:9513580c]
%[text] `Area` has been updated because the PreGet callback has been called.
disp(Area.MainDoubleValue) %[output:90eb6ac8]
%%
%[text] If `Length` is linked with a base workspace variable, `Area` gets updated if the base workspace variable for `Length` is modified.
%[text] For example, link `Length` to `param1.L1`.
param1 = struct;
param1.L1 = 2;
Length.ValueText = "param1.L1";
disp(Area.MainDoubleValue) %[output:9deb691b]
%[text] Change `param.L1` in the workspace.
param1.L1 = 4;
%[text] `Area` has been updated.
disp(Area.MainDoubleValue) %[output:071ba845]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:6498d5a6]
%   data: {"dataType":"text","outputData":{"text":"     1\n\n","truncated":false}}
%---
%[output:845ecc88]
%   data: {"dataType":"text","outputData":{"text":"     1\n\n","truncated":false}}
%---
%[output:9513580c]
%   data: {"dataType":"text","outputData":{"text":"     2\n\n","truncated":false}}
%---
%[output:90eb6ac8]
%   data: {"dataType":"text","outputData":{"text":"     4\n\n","truncated":false}}
%---
%[output:9deb691b]
%   data: {"dataType":"text","outputData":{"text":"     4\n\n","truncated":false}}
%---
%[output:071ba845]
%   data: {"dataType":"text","outputData":{"text":"    16\n\n","truncated":false}}
%---
