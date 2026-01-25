function plan = buildfile
% Define tasks for the buildtool to check code and run tests.

% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% Run Build from Toolstrip
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html
%
% matlab.buildtool.tasks.TestTask Class
% "SupportingFiles" property is supported from R2025a.
% https://www.mathworks.com/help/releases/R2026a/matlab/ref/matlab.buildtool.tasks.testtask-class.html

% Copyright 2023-2025 The MathWorks, Inc.

plan = buildplan(localfunctions);

plan.DefaultTasks = "CodeIssues";

plan("TestAndReport").Dependencies = "Test";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  Dependencies = "DisplayRelease", ...
  ...
  WarningThreshold = Inf, ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = [
  "test-result/code-issues.mat"
  "test-result/code-issues.sarif"
  ]);

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = "DisplayRelease", ...
  ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  TestResults = [
  "test-result/test-result.pdf"
  "test-result/test-result.xml"
  ] );

end  % function

function DisplayReleaseTask(~)
disp(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss"))
disp(matlabRelease)
end  % function

function TestAndReportTask(~)
% This function itself does the final reporting only.
% Set a dependency on the Test task so that the tests are performed before this function.
disp("UTC " + string(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss")))

target_file = "reportTestResult.m";
assert(isfile(target_file))

generatedfile_fullpath = export(target_file, HideCode=true, Run=true, Format="markdown", IncludeOutputs=true);

disp("Generated: <a href=""" + generatedfile_fullpath + """>" + generatedfile_fullpath + "</a>")

disp("UTC " + string(datetime("now", TimeZone="UTC", Format="uuuu-MM-dd HH:mm:ss")))
end  % function
