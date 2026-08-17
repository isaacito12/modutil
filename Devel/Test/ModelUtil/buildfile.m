function plan = buildfile
% Define tasks for the buildtool to check code and run tests.

% Start the Test task with options as needed.
%{
buildtool -verbosity Verbose Test
buildtool -buildFile Test/ModelUtil/buildfile.m -verbosity Verbose Test
%}
%
% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% matlab.buildtool.tasks.TestTask Class
% "SupportingFiles" property is supported from R2025a.
% https://www.mathworks.com/help/matlab/ref/matlab.buildtool.tasks.testtask-class.html
%
% Run Build from Toolstrip (R2025a or newer)
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html

% Copyright 2024-2026 The MathWorks, Inc.

collection = matlab.buildtool.io.FileCollection.fromPaths(["**/*.m", "**/*.mlx"]);
collection = select(collection, @(x) not(contains(x, "buildfile" )));
collection = select(collection, @(x) not(contains(x, "markdown" + ("/"|"\") )));
collection = select(collection, @(x) not(contains(x, "ForTesting" + ("/"|"\") )));
collection = select(collection, @(x) not(contains(x, "sample folder" + ("/"|"\") )));
collection = select(collection, @(x) not(contains(x, "resources" + ("/"|"\") )));

% Create a build plan.
% https://www.mathworks.com/help/matlab/ref/buildplan.html
plan = buildplan(localfunctions);

plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  Dependencies = "cleanupRefsub", ...
  WarningThreshold = Inf, ...
  SourceFiles = collection.paths, ...
  Results = [ ...
  "test-result/code-issues.mat"
  "test-result/code-issues.sarif"
  ]);

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = "CodeIssues", ...
  SourceFiles = collection.paths, ...
  TestResults = [ ...
  "test-result/test-result.pdf"
  "test-result/test-result.xml"
  ], ...
  CodeCoverageResults = [ ...
  "test-result/code-coverage.html"
  "test-result/code-coverage.xml"
  ] );

end  % function

function cleanupRefsubTask(~)
% Delete default_refsub.mdl (or default_refsub.slx) files from the folder tree before
% starting test process. This prevents shadowing of "default_refsub" files, which is
% necessary for some tests to properly run.
target = "default_refsub";
files = mus1.FileUtil.getFileFullPath(target, ReturnMultipleMatches=true, ReturnIfNotFound=true);
if isscalar(files) && (files == "")

  return

end
disp("Cleaning " + numel(files) + target + " file(s).")
for k = 1:numel(files)
  delete(files{k});
end  % for
end  % local function
