function App = CodeCoverageApp_AppUtil
% Open the code coverage app with the AppUtil's code coverage result.

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App struct
end  % arguments

result = matlab.buildtool.io.FileCollection.fromPaths("**/code-coverage.xml").paths';

if isempty(result)
  target_file = "sample-code-coverage-AppUtil.xml";
  assert(isfile(target_file), "A sample code coverage file was not found.")
  disp("Using a sample file for the code coverage result.")

else
  logical_index = contains(result, "AppUtil") & contains(result, "test-result-24b");
  if TestUtil1.isR2024bOrOlder
    target_file = result(logical_index);
  else
    target_file = result(~logical_index);
  end  % if
end  % if

coverage_app = CodeCoverageApp(target_file(1));

if nargout > 0
  App = coverage_app;
end  % if
end  % function
