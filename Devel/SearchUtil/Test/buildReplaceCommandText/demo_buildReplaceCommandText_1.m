%[text] # buildReplaceCommandText\_1 demo
%[text] Build the list of files to pass to the `buildReplaceCommandText` function.
% Find paths to the "sample*.txt" files.
file_paths = matlab.buildtool.io.FileCollection.fromPaths(fullfile(pwd, "**", "sample*.txt")).paths';

% Remove paths that are out side of the "SearchUtil > Test > buildReplaceCommandText" folder.
logical_index = contains(file_paths, ("/"|"\") + "SearchUtil" + ("/"|"\") + "Test" + ("/"|"\") + "buildReplaceCommandText");
file_paths = file_paths(logical_index);

assert(numel(file_paths) > 0)

file_paths = extractAfter(file_paths, pwd + ("/"|"\"));

disp(file_paths) %[output:26300a5f]
% FYI
type(file_paths(1)) %[output:456812fd]
%[text] Run the `buildReplaceCommandText` function. The `TextPattern` option can take a pattern to search and match text. (The corresponding apps can take normal text only, i.e., they do not suport pattern.)
command_text = SearchUtil1.buildReplaceCommandText( ...
  FilePaths = file_paths, ...
  TextPattern = alphanumericBoundary + ("cat"|"night") + alphanumericBoundary, ...
  IgnoreCase = true, ...
  MatchWholeWord = false, ...
  NewText = "NewText");

disp(command_text) %[output:5d82864d]
%[text] The generated command text can be evaluated to run it. In this demo, run it in the dry run mode to avoid actually performing text replacement.
sp = optionalPattern(whitespacePattern);
assert(contains(command_text, "DryRun" +sp+ "=" +sp+ "true" +sp+ ","))
evalin("base", command_text) %[output:122249eb]
disp(result_table) %[output:8af9ae98]
%[text] 0 in the `NumLines` column indicates that there were no lines containing the specified text pattern.
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:26300a5f]
%   data: {"dataType":"text","outputData":{"text":"    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\sample file 1.txt\"\n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\sample file 2.txt\"\n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 1\\sample file 11.txt\"\n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 1\\sample file 12.txt\"\n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 2\\sample-file-21.txt\"\n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 2\\sample-file-22.txt\"\n\n","truncated":false}}
%---
%[output:456812fd]
%   data: {"dataType":"text","outputData":{"text":"\nThis is a sample file for testing.\nThe contents of this file may be modified programmatically.\n\nrandom words... dog, cat, bird, fish\n","truncated":false}}
%---
%[output:5d82864d]
%   data: {"dataType":"text","outputData":{"text":"% Target files for text replacement\nfile_paths = [\n  \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\sample file 1.txt\"\n  \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\sample file 2.txt\"\n  \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 1\\sample file 11.txt\"\n  \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 1\\sample file 12.txt\"\n  \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 2\\sample-file-21.txt\"\n  \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 2\\sample-file-22.txt\"\n  ];\n\n% By default, running the command below does not do text replacement\n% because of the DryRun=true option.\n% The returned table contains a list of potential replacements for each file.\n% Use DryRun=false for performing text replacement.\nresult_table = SearchUtil1.replaceText( ...\n  file_paths, ...\n  DryRun = true, ...\n  TextPattern = (alphanumericBoundary + (\"cat\" | \"night\") + alphanumericBoundary), ...\n  IgnoreCase = true, ...\n  MatchWholeWord = false, ...\n  NewText = \"NewText\");\n\ndisp(result_table)\n","truncated":false}}
%---
%[output:122249eb]
%   data: {"dataType":"text","outputData":{"text":"replaceText: dry run\n                                          <strong>FilePaths<\/strong>                                           <strong>NumLines<\/strong>\n    <strong>______________________________________________________________________________________<\/strong>    <strong>________<\/strong>\n\n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\sample file 1.txt\"                    1    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\sample file 2.txt\"                    0    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 1\\sample file 11.txt\"       0    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 1\\sample file 12.txt\"       0    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 2\\sample-file-21.txt\"       0    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 2\\sample-file-22.txt\"       1    \n\n","truncated":false}}
%---
%[output:8af9ae98]
%   data: {"dataType":"text","outputData":{"text":"                                          <strong>FilePaths<\/strong>                                           <strong>NumLines<\/strong>\n    <strong>______________________________________________________________________________________<\/strong>    <strong>________<\/strong>\n\n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\sample file 1.txt\"                    1    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\sample file 2.txt\"                    0    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 1\\sample file 11.txt\"       0    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 1\\sample file 12.txt\"       0    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 2\\sample-file-21.txt\"       0    \n    \"SearchUtil\\Test\\buildReplaceCommandText\\sample folder\\subfolder 2\\sample-file-22.txt\"       1    \n\n","truncated":false}}
%---
