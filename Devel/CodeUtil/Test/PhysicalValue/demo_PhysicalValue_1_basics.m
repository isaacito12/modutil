%[text] # PhysicalValue demo 1
%[text] ## Basics
%[text] Create a default `PhysicalValue` object. The default unit of a `PhysicalValue` object is "1", which cannot be changed later.
a = CodeUtil1.PhysicalValue;
disp(a)
%[text] Default `SimscapeValue` property is NaN (1). FYI, default `simscape.Value` object is \[\] (1).
disp(simscape.Value)
%[text] Set a text representing numeric data to `ValueText`, and `SimscapeValue` is updated.
a.ValueText = "[3 2 1]";
disp(a)
%[text] Use `UnitAlias` to add additional information about the unit. `UnitAlias` works if `UnitText` is 1.
a.UnitAlias = "%";
disp(a)
%[text] To use unit other than 1, use the `UnitText` option.
physval_v = CodeUtil1.PhysicalValue(UnitText="m/s");
disp(physval_v)
%[text] The unit can be changed to a commensurate unit.
physval_v.UnitText = "mph";
disp(physval_v)
%[text] Use `SimscapeValue` to set a simscape.Value object.
physval_v = CodeUtil1.PhysicalValue(UnitText="m/s");
physval_v.SimscapeValue = simscape.Value([1 2], "mph");
disp(physval_v)
%[text] Notice the difference between `SimscapeValue` and `ValueText`.
physval_v.ValueText = "simscape.Value([1 2], ""mph"")";
disp(physval_v)
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
