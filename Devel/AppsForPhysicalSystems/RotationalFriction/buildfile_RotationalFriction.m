function plan = buildfile_RotationalFriction
% Define tasks for the buildtool to check code and run tests.

% R2024b or newer
%{
buildtool -buildFile buildfile_RotationalFriction.m -verbosity Verbose Test
%}

% R2025a or newer
%
% If the name of this file is buildfile.m, the Editor provides
% the "Run Build" button to start a task.

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
  "test-result/code-issues.mat"
  "test-result/code-issues.sarif"
  ]);

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  ... SupportingFiles option is not supported in R2024b.
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
