function App = CodeCoverageApp_AppsForPhysicalSystems
% Open the code coverage app with the AppsForPhysicalSystems's code coverage result.

% Copyright 2026 The MathWorks, Inc.

arguments (Output)
  App
end  % arguments

result = matlab.buildtool.io.FileCollection.fromPaths("**/code-coverage.xml").paths';

if isempty(result)
  disp("Code coverage file was not found.")

  return

end  % if

logical_index_24b = contains(result, "AppsForPhysicalSystems") & contains(result, "test-result-24b");
logical_index_25a_or_newer = contains(result, "AppsForPhysicalSystems") & contains(result, "test-result" + ("/"|"\"));

if any(logical_index_24b) && TestUtil1.isR2024bOrOlder
  % R2024b
  target_file = result(logical_index_24b);

elseif any(logical_index_25a_or_newer) && not(TestUtil1.isR2024bOrOlder)
  % R2025a or newer
  target_file = result(logical_index_25a_or_newer);

else
  disp("Code coverage file for AppsForPhysicalSystems was not found.")

  return

end  % if

coverage_app = CodeCoverageApp(target_file(1));

if nargout > 0
  App = coverage_app;
end  % if
end  % function
