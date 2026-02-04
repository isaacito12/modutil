function plan = buildfile_R2024b
% Define tasks for the buildtool to check code and run tests.
%
% R2025a or newer: In the Editor, use the "Run Build" button to start a task.
% R2024b: buildtool -buildFile buildfile_R2024b.m -verbosity Verbose Test

% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% Run Build from Toolstrip
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html

% Copyright 2024-2026 The MathWorks, Inc.

plan = buildplan();
plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  WarningThreshold = Inf, ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = [ ...
  "test-result-24b/code-issues.mat"
  "test-result-24b/code-issues.sarif"
  ]);


% SupportingFiles option is not supported in R2024b.
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
