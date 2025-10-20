%[text] # PhysicalValue demo 2
%[text] ## Link with the base workspace
%[text] `PhysicalValue` objects can be linked with base workspace variables. Once linked, a change in a base workspace variable is detected by the `PhysicalValue` object. As an example, first define a variable in the base workspace.
evalin("base", "bwv = struct;")
evalin("base", "bwv.S1 = simscape.Value([1 2], ""ft^2"");")
disp(bwv.S1) %[output:34bab304]
%[text] Create a `PhysicalValue` object.
a = CodeUtil1.PhysicalValue(UnitText="m^2");
%[text] Set the base workspace variable to the `PhysicalValue` object's `ValueText`.
a.ValueText = "bwv.S1";
disp(a) %[output:24b909b6]
%[text] Change the base workspace variable.
evalin("base", "bwv.S1 = simscape.Value([3 4], ""m^2"");")
disp(bwv.S1) %[output:0b3646c7]
%[text] `SimscapeValue` of the linked `PhysicalValue` object has been updated too.
disp(a.SimscapeValue) %[output:5fb7d824]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:34bab304]
%   data: {"dataType":"text","outputData":{"text":"     1     2\n\n    (ft^2)\n\n","truncated":false}}
%---
%[output:24b909b6]
%   data: {"dataType":"text","outputData":{"text":"  PhysicalValue with properties:\n\n        ValueText: \"bwv.S1\"\n         UnitText: \"ft^2\"\n        UnitAlias: \"\"\n    SimscapeValue: [1 2] (ft^2)\n\n","truncated":false}}
%---
%[output:0b3646c7]
%   data: {"dataType":"text","outputData":{"text":"     3     4\n\n    (m^2)\n\n","truncated":false}}
%---
%[output:5fb7d824]
%   data: {"dataType":"text","outputData":{"text":"     3     4\n\n    (m^2)\n\n","truncated":false}}
%---
