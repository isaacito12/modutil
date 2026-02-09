function plan = buildfile
% Define tasks for the buildtool to check code and run tests.
%
% buildtool -verbosity Verbose Test

% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% Run Build from Toolstrip
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html
%
% matlab.buildtool.tasks.TestTask Class
% "SupportingFiles" property is supported from R2025a.
% https://www.mathworks.com/help/releases/R2026a/matlab/ref/matlab.buildtool.tasks.testtask-class.html

% Copyright 2023-2026 The MathWorks, Inc.

plan = buildplan(localfunctions);

plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  ... The "DisplayRelease" plan is defined by the DisplayReleaseTask local function.
  Dependencies = "DisplayRelease", ...
  ...
  WarningThreshold = Inf, ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = "test-result-24b/code-issues.sarif" );

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = "DisplayRelease", ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  TestResults = "test-result-24b/test-result.xml", ...
  CodeCoverageResults = "test-result-24b/code-coverage.xml" );

end  % function

function DisplayReleaseTask(~)
disp(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss"))
disp(matlabRelease)
end  % function
