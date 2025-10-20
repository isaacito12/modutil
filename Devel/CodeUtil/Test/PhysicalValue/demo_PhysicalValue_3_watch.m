%[text] # PhysicalValue demo 3
%[text] ## Watch PhysicalValue objects
Length = CodeUtil1.PhysicalValue(ValueText="1", UnitText="m");
Area = CodeUtil1.PhysicalValue(ValueText="1", UnitText="m^2");
%[text] 
function deriveArea(L, A)
arguments (Input)
  L (1,:) CodeUtil1.PhysicalValue
  A (1,:) CodeUtil1.PhysicalValue
end
L_ssc = L.SimscapeValue;
A_ssc = L_ssc.^2;
A.SimscapeValue = A_ssc;
end
%[text] Set up a ***PreGet*** callback for the `Area.SimscapeValue` as an event listener. The PreGet callback is triggered right before `Area.SimscapeValue` is read.
addlistener(Area, "SimscapeValue", "PreGet", @(~,~) deriveArea(Length,Area));
%%
%[text] Currently `Length` and `Area` are defined as follows.
disp(Length.SimscapeValue) %[output:66006bd6]
disp(Area.SimscapeValue) %[output:2dbaa216]
%[text] Change `Length`.
Length.ValueText = "2";
disp(Length.SimscapeValue) %[output:24402353]
%[text] `Area` has been updated because the PreGet callback has been called.
disp(Area.SimscapeValue) %[output:0e0ca67d]
%[text] Change the unit of `Length`.
Length.UnitText = "ft";
disp(Length.SimscapeValue) %[output:1df6ec9e]
%[text] The unit of `Area` has been updated.
disp(Area.SimscapeValue) %[output:72c27f3d]
%%
%[text] If `Length` is linked with a base workspace variable, `Area` gets updated if the base workspace variable for `Length` is modified.
%[text] For example, link `Length` to `param1.L1`.
param1 = struct;
param1.L1 = simscape.Value(2, "in");
Length.ValueText = "param1.L1";
disp(Area.SimscapeValue) %[output:2f1bf599]
%[text] Change `param.L1` in the workspace.
param1.L1 = simscape.Value(4, "in");
%[text] `Area` has been updated.
disp(Area.SimscapeValue) %[output:2bc89fc5]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:66006bd6]
%   data: {"dataType":"text","outputData":{"text":"     1 (m)\n\n","truncated":false}}
%---
%[output:2dbaa216]
%   data: {"dataType":"text","outputData":{"text":"     1 (m^2)\n\n","truncated":false}}
%---
%[output:24402353]
%   data: {"dataType":"text","outputData":{"text":"     2 (m)\n\n","truncated":false}}
%---
%[output:0e0ca67d]
%   data: {"dataType":"text","outputData":{"text":"     4 (m^2)\n\n","truncated":false}}
%---
%[output:1df6ec9e]
%   data: {"dataType":"text","outputData":{"text":"     2 (ft)\n\n","truncated":false}}
%---
%[output:72c27f3d]
%   data: {"dataType":"text","outputData":{"text":"     4 (ft^2)\n\n","truncated":false}}
%---
%[output:2f1bf599]
%   data: {"dataType":"text","outputData":{"text":"     4 (in^2)\n\n","truncated":false}}
%---
%[output:2bc89fc5]
%   data: {"dataType":"text","outputData":{"text":"    16 (in^2)\n\n","truncated":false}}
%---
