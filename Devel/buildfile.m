function plan = buildfile
% Define tasks for the buildtool to check code and run tests.

% If the Devel folder is the current folder, start tests as follows.
%   buildtool -verbosity Verbose Test
%
% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% matlab.buildtool.tasks.TestTask Class
% "SupportingFiles" property is supported from R2025a, i.e., R2024b does not support it.
% https://www.mathworks.com/help/releases/R2026a/matlab/ref/matlab.buildtool.tasks.testtask-class.html
%
% Run Build from Toolstrip (R2025a or newer)
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html

% Copyright 2023-2026 The MathWorks, Inc.

% Passing the handles of local functions to buildplan makes them available as build tasks.
plan = buildplan(localfunctions);

plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  ... The "DisplayRelease" plan is defined by the DisplayReleaseTask local function.
  Dependencies = ["SetupPaths", "DisplayRelease", "CleanupRefsub"], ...
  ...
  WarningThreshold = Inf, ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = [
  "test-result/code-issues.mat"
  "test-result/code-issues.sarif"
  ]);

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = ["SetupPaths", "DisplayRelease", "CleanupRefsub"], ...
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

function CleanupRefsubTask(~)
% This function is available as "CleanupRefsub" for the build plan.
%
% Delete default_refsub.mdl (or default_refsub.slx) files from the folder tree before
% starting a test process. These files must be deleted to prevent shadowing.
target = "default_refsub";
files = mus1.FileUtil.getFileFullPath(target, ReturnMultipleMatches=true, ReturnIfNotFound=true);
if isscalar(files) && (files == "")

  return

end
disp("Cleaning " + numel(files) + target + " file(s).")
for k = 1:numel(files)
  delete(files{k});
end  % for
end  % local function
