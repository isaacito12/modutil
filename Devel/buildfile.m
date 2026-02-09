function plan = buildfile
% Define tasks for the buildtool to check code and run tests.
% If the Devel folder is the current folder, start tests as follows.
%   buildtool -verbosity Verbose Test

% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% Run Build from Toolstrip (R2025a or newer)
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html
%
% matlab.buildtool.tasks.TestTask Class
% "SupportingFiles" property is supported from R2025a, i.e., R2024b does not support it.
% https://www.mathworks.com/help/releases/R2026a/matlab/ref/matlab.buildtool.tasks.testtask-class.html

% Copyright 2023-2026 The MathWorks, Inc.

% Passing the handles of local functions to buildplan makes them available as build tasks.
plan = buildplan(localfunctions);

plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  ... The "DisplayRelease" plan is defined by the DisplayReleaseTask local function.
  Dependencies = ["SetupPaths", "DisplayRelease"], ...
  ...
  WarningThreshold = Inf, ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = [
  "test-result-24b/code-issues.mat"
  "test-result-24b/code-issues.sarif"
  ]);

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = ["SetupPaths", "DisplayRelease"], ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  TestResults = [
  "test-result-24b/test-result.pdf"
  "test-result-24b/test-result.xml"
  ], ...
  CodeCoverageResults = [
  "test-result-24b/code-coverage.html"
  "test-result-24b/code-coverage.xml"
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
