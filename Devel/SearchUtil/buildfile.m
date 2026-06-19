function plan = buildfile
% Define tasks for the buildtool to check code and run tests.
%
% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% If the SearchUtil folder is the current folder, start tests as follows.
%{
buildtool -verbosity Verbose Test
%}
%
% If the Devel folder is the current folder which contains the SearchUtil folder,
% start tests as follows.
%{
buildtool -buildFile SearchUtil/buildfile.m -verbosity Verbose Test
%}
%
% Run Build from Toolstrip (R2025a or newer)
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html

% Copyright 2024-2026 The MathWorks, Inc.

% Create a build plan.
% https://www.mathworks.com/help/matlab/ref/buildplan.html
plan = buildplan;

plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  WarningThreshold = Inf, ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = [ ...
  "test-result/code-issues.mat"
  "test-result/code-issues.sarif"
  ]);

% SupportingFiles option is available from 25a.
% https://www.mathworks.com/help/matlab/ref/matlab.buildtool.tasks.testtask-class.html
%
% !todo: Use SupportingFiles (eventually).
%   SupportingFiles = "**/sample folder/*.m"
plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = "CodeIssues", ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  TestResults = [ ...
  "test-result/test-result.pdf"
  "test-result/test-result.xml"
  ], ...
  CodeCoverageResults = [ ...
  "test-result/code-coverage.html"
  "test-result/code-coverage.xml"
  ] );

end  % function
