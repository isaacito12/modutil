function plan = buildfile_24b
% Define tasks for the buildtool to check code and run tests.
% If the Devel folder is the current folder, start tests as follows.
%   buildtool -buildFile buildfile_24b.m -verbosity Verbose Test

% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% Run Build from Toolstrip
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html
%
% matlab.buildtool.tasks.TestTask Class
% "SupportingFiles" property is supported from R2025a, i.e., R2024b does not support it.
% https://www.mathworks.com/help/releases/R2026a/matlab/ref/matlab.buildtool.tasks.testtask-class.html

% Copyright 2023-2025 The MathWorks, Inc.

% Passing the handles of local functions to buildplan makes them available as build tasks.
plan = buildplan(localfunctions);

plan.DefaultTasks = "CodeIssues";

% The "TestAndReport" task is defined by the TestAndReportTask local function.
plan("TestAndReport").Dependencies = ["SetupPaths", "Test"];

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  ... The "DisplayRelease" plan is defined by the DisplayReleaseTask local function.
  Dependencies = ["SetupPaths", "DisplayRelease"], ...
  ...
  WarningThreshold = Inf, ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = [
  "test-result/code-issues.mat"
  "test-result/code-issues.sarif"
  ]);

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = ["SetupPaths", "DisplayRelease"], ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  TestResults = [
  "test-result/test-result.pdf"
  "test-result/test-result.xml"
  ], ...
  CodeCoverageResults = [
  "test-result/code-coverage.html"
  "test-result/code-coverage.xml"
  ] );

end  % function

function SetupPathsTask(~)
% This function is available as "SetupPaths" for the build plan.
setup_paths
end  % local function

function DisplayReleaseTask(~)
% This function is available as "DisplayRelease" for the build plan.
disp(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss"))
disp(matlabRelease)
end  % local function

function TestAndReportTask(~)
% Generate a Markdown file containing test summary and code coverage.
%
% This function is available as "TestAndReport" task for the build plan.
% This function itself does not run tests.
% Set a dependency on the Test task so that the tests are performed before this task.

ReportTask

%{
target_file = "reportTestAndCoverage.m";
assert(isfile(target_file))

disp(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss"))

generatedfile_fullpath_html = export(target_file, HideCode=true, Run=true, Format="html", IncludeOutputs=true);
disp(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss"))
disp("Generated: <a href=""" + generatedfile_fullpath_html + """>" + generatedfile_fullpath_html + "</a>")

generatedfile_fullpath_markdown = export(target_file, HideCode=true, Run=true, Format="markdown", IncludeOutputs=true);
disp(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss"))
disp("Generated: <a href=""" + generatedfile_fullpath_markdown + """>" + generatedfile_fullpath_markdownk + "</a>")
%}

end  % local function

function ReportTask(~)
% Generate an HTML file and a Markdown file containing test summary and code coverage.
%
% This function is available as "Report" task for the build plan.

target_file = "reportTestAndCoverage.m";
assert(isfile(target_file))

disp(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss"))

% !fyi: The IncludeOutputs option works with Format="markdown" or Format="Jupyter" only.
% !fyi: The IncludeOutputs option does not works with Format="html".
% !fyi: To export to HTML with outputs, manually run the script in the editor, save it, and then export.
generatedfile_fullpath_markdown = export(target_file, HideCode=true, Run=true, Format="markdown", IncludeOutputs=true);

disp(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss"))

disp("Generated: <a href=""" + generatedfile_fullpath_markdown + """>" + generatedfile_fullpath_markdown + "</a>")

end  % local function
