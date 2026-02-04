function plan = buildfile_24b
% Define tasks for the buildtool to check code and run tests.
%
% If the Devel folder is the current folder,
% start tests as follows.
%   buildtool -buildFile SignalUtil\buildfile_24b.m -verbosity Verbose Test

% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% Run Build from Toolstrip
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html

% Copyright 2024-2025 The MathWorks, Inc.

plan = buildplan();
plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  WarningThreshold = Inf, ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = [ ...
  "test-result-24b/code-issues.mat"
  "test-result-24b/code-issues.sarif"
  ]);

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = "CodeIssues", ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  TestResults = [ ...
  "test-result-24b/test-result.pdf"
  "test-result-24b/test-result.xml"
  ], ...
  CodeCoverageResults = [ ...
  "test-result-24b/code-coverage.html"
  "test-result-24b/code-coverage.xml"
  ] );

end  % function
