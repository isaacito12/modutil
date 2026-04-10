function plan = buildfile
% Set up the buildtool to run tests in MATLAB R2023b.
%
% In the Command Window, type "buidltool", and tests start.
% This buidlfile is intended for use in MATLAB R2023b.

% Overview of MATLAB Build Tool
% https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html
%
% Run Build from Toolstrip
% https://www.mathworks.com/help/matlab/matlab_prog/run-build-from-toolstrip.html

% Copyright 2023-2026 The MathWorks, Inc.

plan = buildplan();

plan.DefaultTasks = "Test";

plan("Test") = matlab.buildtool.tasks.TestTask( ...
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
