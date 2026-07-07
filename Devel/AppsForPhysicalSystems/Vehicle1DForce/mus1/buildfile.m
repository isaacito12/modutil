function plan = buildfile
% Define tasks for the buildtool to check code and run tests.

% Start the Test task with options as needed.
%{
buildtool Test -verbosity Verbose
buildtool Test -buildFile AppsForPhysicalSystems/Vehicle1DForce/mus1/buildfile.m -verbosity Verbose
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

% Copyright 2026 The MathWorks, Inc.

% Create a build plan.
% https://www.mathworks.com/help/matlab/ref/buildplan.html
plan = buildplan;

plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  WarningThreshold = Inf, ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = "test-result/code-issues.sarif" );

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = "CodeIssues", ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  TestResults = "test-result/test-result.pdf", ...
  CodeCoverageResults = "test-result/code-coverage.html" );

end  % function
