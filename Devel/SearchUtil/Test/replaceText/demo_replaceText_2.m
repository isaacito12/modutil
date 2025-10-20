%[text] # replaceText demo 2
%[text] This is a demo working with multiple files. This uses the files prepared for testing.
targetfiles_fullpath = matlab.buildtool.io.FileCollection.fromPaths(fullfile(pwd, "**", "sample*.txt")).paths';
logical_index = contains(targetfiles_fullpath, ("/"|"\") + "SearchUtil" + ("/"|"\") + "Test" + ("/"|"\") + "replaceText");
targetfiles_fullpath = targetfiles_fullpath(logical_index);

assert(numel(targetfiles_fullpath) > 0)

type(targetfiles_fullpath(1)) %[output:4cd22bb8]

result = SearchUtil1.replaceText(targetfiles_fullpath, DryRun=true, TextPattern="testing", NewText="testing"); %[output:667e289f]
disp(result) %[output:969e4c4b]
%%
%[text] Do actual replacement.
%[text] First replacement
result = SearchUtil1.replaceText(targetfiles_fullpath, DryRun=false, TextPattern="testing", NewText="checking");
disp(result) %[output:86560efe]
type(targetfiles_fullpath(end)) %[output:1825160f]
%[text] Second replacement to revert the first one.
result = SearchUtil1.replaceText(targetfiles_fullpath, DryRun=false, TextPattern="checking", NewText="testing");
disp(result) %[output:56825760]
type(targetfiles_fullpath(end)) %[output:35e88a01]
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:4cd22bb8]
%   data: {"dataType":"text","outputData":{"text":"\nThis is a sample file for testing.\nThe contents of this file may be modified programmatically.\n\nrandom words... dog, cat, bird, fish\n","truncated":false}}
%---
%[output:667e289f]
%   data: {"dataType":"text","outputData":{"text":"replaceText: dry run\n","truncated":false}}
%---
%[output:969e4c4b]
%   data: {"dataType":"text","outputData":{"text":"                                                  <strong>FilePaths<\/strong>                                                   <strong>NumLines<\/strong>\n    <strong>______________________________________________________________________________________________________<\/strong>    <strong>________<\/strong>\n\n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\sample file 1.txt\"                    1    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\sample file 2.txt\"                    2    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 1\\sample file 11.txt\"       1    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 1\\sample file 12.txt\"       2    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 2\\samplefile 21.txt\"        1    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 2\\samplefile 22.txt\"        2    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\samplefile_replaceText.txt\"                         1    \n\n","truncated":false}}
%---
%[output:86560efe]
%   data: {"dataType":"text","outputData":{"text":"                                                  <strong>FilePaths<\/strong>                                                   <strong>NumLines<\/strong>\n    <strong>______________________________________________________________________________________________________<\/strong>    <strong>________<\/strong>\n\n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\sample file 1.txt\"                    1    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\sample file 2.txt\"                    2    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 1\\sample file 11.txt\"       1    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 1\\sample file 12.txt\"       2    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 2\\samplefile 21.txt\"        1    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 2\\samplefile 22.txt\"        2    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\samplefile_replaceText.txt\"                         1    \n\n","truncated":false}}
%---
%[output:1825160f]
%   data: {"dataType":"text","outputData":{"text":"\nThis file is part of the Search Tool.\nThe contents of this file is modified programatically for checking.\n","truncated":false}}
%---
%[output:56825760]
%   data: {"dataType":"text","outputData":{"text":"                                                  <strong>FilePaths<\/strong>                                                   <strong>NumLines<\/strong>\n    <strong>______________________________________________________________________________________________________<\/strong>    <strong>________<\/strong>\n\n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\sample file 1.txt\"                    1    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\sample file 2.txt\"                    2    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 1\\sample file 11.txt\"       1    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 1\\sample file 12.txt\"       2    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 2\\samplefile 21.txt\"        1    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\sample folder\\subfolder 2\\samplefile 22.txt\"        2    \n    \"C:\\local\\bev\\bev25b\\Utility\\SearchUtil\\Test\\replaceText\\samplefile_replaceText.txt\"                         1    \n\n","truncated":false}}
%---
%[output:35e88a01]
%   data: {"dataType":"text","outputData":{"text":"\nThis file is part of the Search Tool.\nThe contents of this file is modified programatically for testing.\n","truncated":false}}
%---
