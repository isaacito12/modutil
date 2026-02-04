function App = CodeCoverageApp_AppsForPhysicalSystems

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App
end  % arguments

result = matlab.buildtool.io.FileCollection.fromPaths("**/code-coverage.xml").paths';

if isempty(result)
  target_file = "sample-code-coverage-AppsForPhysicalSystems.xml";
  assert(isfile(target_file), "A sample code coverage file was not found.")
  disp("Using a sample file for the code coverage result.")

else
  if TestUtil1.isR2024bOrOlder && contains(result, "test-result-24b")
    if contains(result, "AppsForPhysicalSystems")
      logical_index = contains(result, "AppsForPhysicalSystems") & contains(result, "test-result-24b");
      target_file = result(logical_index);
    else
      logical_index = contains(result, "test-result-24b");
      target_file = result(logical_index);
    end  % if
  else
    % !todo: "R2024b without test-result-24b folder" comes into this branch, but it should not.
    if contains(result, "AppsForPhysicalSystems")
      logical_index = contains(result, "AppsForPhysicalSystems") & contains(result, "test-result");
      target_file = result(logical_index);
    else
      logical_index = contains(result, "test-result");
      target_file = result(logical_index);
    end  % if
  end  % if
end  % if

coverage_app = CodeCoverageApp(target_file(1));

if nargout > 0
  App = coverage_app;
end  % if
end  % function
