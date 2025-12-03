%[text] # getLinkedCommandFromText demo
target_text = "Example: [text1](matlab:command1), [text2](matlab:command2(name=value))";
FileUtil1.getLinkedCommandFromText(target_text) %[output:0ec17d0b]
%%
target_text = [
  "Some text, followed by [linked text](matlab:command1), and the line continues."
  "Next line: [Another linked text](matlab:command2(arg))"
  ];
FileUtil1.getLinkedCommandFromText(target_text) %[output:51bcdff8]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:0ec17d0b]
%   data: {"dataType":"tabular","outputData":{"columnNames":["Line","LinkText","Command"],"columns":3,"dataTypes":["double","string","string"],"header":"2×3 table","name":"ans","rows":2,"type":"table","value":[["1","\"text1\"","\"command1\""],["1","\"text2\"","\"command2(name=value)\""]]}}
%---
%[output:51bcdff8]
%   data: {"dataType":"tabular","outputData":{"columnNames":["Line","LinkText","Command"],"columns":3,"dataTypes":["double","string","string"],"header":"2×3 table","name":"ans","rows":2,"type":"table","value":[["1","\"linked text\"","\"command1\""],["2","\"Another linked text\"","\"command2(arg)\""]]}}
%---
