%[text] # buildReplaceCommandText demo
%[text] Build the list of files to pass to the `buildReplaceCommandText` function.
% Find paths to the "sample*.txt" files.
file_paths = matlab.buildtool.io.FileCollection.fromPaths(fullfile(pwd, "**", "sample*.txt")).paths';

% Remove paths that are out side of the "SearchUtil > Test > buildReplaceCommandText" folder.
logical_index = contains(file_paths, ("/"|"\") + "SearchUtil" + ("/"|"\") + "Test" + ("/"|"\") + "buildReplaceCommandText");
file_paths = file_paths(logical_index);

assert(numel(file_paths) > 0) %[output:8f2b5a94]

file_paths = extractAfter(file_paths, pwd + ("/"|"\"));

disp(file_paths)
% FYI
type(file_paths(1))
%[text] Run the `buildReplaceCommandText` function. The `TextPattern` option can take a pattern to search and match text. (The corresponding apps can take normal text only, i.e., they do not suport pattern.)
command_text = SearchUtil1.buildReplaceCommandText( ...
  FilePaths = file_paths, ...
  TextPattern = alphanumericBoundary + ("cat"|"night") + alphanumericBoundary, ...
  IgnoreCase = true, ...
  MatchWholeWord = false, ...
  NewText = "NewText");

disp(command_text)
%[text] The generated command text can be evaluated to run it. In this demo, run it in the dry run mode to avoid actually performing text replacement.
sp = optionalPattern(whitespacePattern);
assert(contains(command_text, "DryRun" +sp+ "=" +sp+ "true" +sp+ ","))
evalin("base", command_text)
disp(result_table)
%[text] 0 in the `NumLines` column indicates that there were no lines containing the specified text pattern.
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[output:8f2b5a94]
%   data: {"dataType":"error","outputData":{"errorType":"runtime","text":"Error using <a href=\"matlab:matlab.lang.internal.introspective.errorDocCallback('assert')\" style=\"font-weight:bold\">assert<\/a>\nAssertion failed."}}
%---
