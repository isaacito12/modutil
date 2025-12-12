function plan = buildfile
% Define tasks for the buildtool to check code and run tests.
% In the Editor, use the "Run Build" button to start a task.

% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% Run Build from Toolstrip
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html
%
% matlab.buildtool.tasks.TestTask Class
% "SupportingFiles" property is supported from R2025a.
% https://www.mathworks.com/help/releases/R2026a/matlab/ref/matlab.buildtool.tasks.testtask-class.html

% Copyright 2023-2025 The MathWorks, Inc.

plan = buildplan(localfunctions);
plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  WarningThreshold = Inf, ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = [
  "test-result/code-issues.mat"
  "test-result/code-issues.sarif"
  ]);

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  ... Dependencies = "CodeIssues", ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  SupportingFiles = [
  "**/buildfile.m"
  "**/sample folder/**"
  ], ...
  TestResults = [
  "test-result/test-result.pdf"
  "test-result/test-result.xml"
  ], ...
  CodeCoverageResults = [
  "test-result/code-coverage.html"
  "test-result/code-coverage.xml"
  ] );

plan("CodeIssues").Dependencies = "DisplayRelease";
plan("Test").Dependencies = "DisplayRelease";
plan("TestAndReport").Dependencies = "Test";

end  % function

function DisplayReleaseTask(~)
matlabRelease
end  % function

function TestAndReportTask(~)
% This function itself does the final reporting only.
% Set a dependency on the Test task so that the tests are performed before this function.
generatedfile_fullpath = export("test_summary", HideCode=true, Run=true, Format="markdown", IncludeOutputs=true);
disp("Generated: " + generatedfile_fullpath)
end  % function
