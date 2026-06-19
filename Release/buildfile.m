function plan = buildfile
% Define tasks for the buildtool to check code and run tests.
<<<<<<< HEAD
%   buildtool -verbosity Verbose Test
%   buildtool -buildFile Release/buildfile.m -verbosity Verbose Test
=======
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3

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
  Results = "code-issues.sarif" );

% If the following Test plan is enabled, they can run as follows.
%   buildtool -verbosity Verbose Test
%{
plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = "DisplayRelease", ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  TestResults = "test-result/test-result.xml", ...
  CodeCoverageResults = "test-result/code-coverage.xml" );
<<<<<<< HEAD
=======
%}
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3

end  % function

function DisplayReleaseTask(~)
disp(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss"))
disp(matlabRelease)
end  % function
