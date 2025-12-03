%[text] # getLinkedCommandFromPlainTextLiveScript demo
fullpath = string( which("sampleScript_getLinkedCommandFromPlainTextLiveScript_1"));
FileUtil1.getLinkedCommandFromPlainTextLiveScript(fullpath) %[output:5d9160b8]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:5d9160b8]
%   data: {"dataType":"tabular","outputData":{"columnNames":["Line","LinkText","Command"],"columns":3,"dataTypes":["double","string","string"],"header":"4×3 table","name":"ans","rows":4,"type":"table","value":[["2","\"linked text\"","\"disp(\"test 1\")\""],["2","\"another link\"","\"disp(\"test 2\")\""],["3","\"Yet another linked text\"","\"datetime\""],["3","\"This\"","\"logo\""]]}}
%---
