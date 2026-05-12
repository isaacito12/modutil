function runTestForCoverage_PhysicalValue
% Run test and measure code coverage for specified source files.

% Copyright 2026 The MathWorks, Inc.

source_file_1 = fullfile(pwd, "..", "..", "+CodeUtil1", "PhysicalValue.m");
assert(isfile(source_file_1))

source_file_2 = fullfile(pwd, "DemoApp_PhysicalValue_1_workspace.m");
assert(isfile(source_file_2))

source_file_3 = fullfile(pwd, "DemoApp_PhysicalValue_2_listener.m");
assert(isfile(source_file_3))

test_file_1 = fullfile(pwd, "unittest_PhysicalValue.m");
assert(isfile(test_file_1))
test_file_2 = fullfile(pwd, "uiTest_PhysicalValue.m");
assert(isfile(test_file_2))
suite = testsuite([test_file_1, test_file_2]);

% -----------------------------------------------------------------------------

runner = matlab.unittest.TestRunner.withTextOutput( ...
  OutputDetail = matlab.unittest.Verbosity.Detailed);

% matlab.coverage.Result Class (since R2023a)
% https://www.mathworks.com/help/matlab/ref/matlab.coverage.result-class.html
%
% Two or more coverage results can be added for aggregated coverage.
% See the Example: Generate Code Coverage Report Using Two Plugins
% https://www.mathworks.com/help/matlab/ref/matlab.unittest.plugins.codecoverageplugin-class.html

cov_result_1 = matlab.unittest.plugins.codecoverage.CoverageResult;
cov_plugin_1 = matlab.unittest.plugins.CodeCoveragePlugin.forFile( ...
  source_file_1, ...
  Producing = cov_result_1 );
addPlugin(runner, cov_plugin_1)

cov_result_2 = matlab.unittest.plugins.codecoverage.CoverageResult;
cov_plugin_2 = matlab.unittest.plugins.CodeCoveragePlugin.forFile( ...
  source_file_2, ...
  Producing = cov_result_2 );
addPlugin(runner, cov_plugin_2)

cov_result_3 = matlab.unittest.plugins.codecoverage.CoverageResult;
cov_plugin_3 = matlab.unittest.plugins.CodeCoveragePlugin.forFile( ...
  source_file_3, ...
  Producing = cov_result_3 );
addPlugin(runner, cov_plugin_3)

results = run(runner, suite);
assertSuccess(results)

disp(cov_result_1.Result)
disp(cov_result_2.Result)
disp(cov_result_3.Result)

aggregate_results = cov_result_1.Result + cov_result_2.Result + cov_result_3.Result;

% Assigning the return value prevents the HTML report window from showing up.
% https://www.mathworks.com/help/matlab-test/ref/matlab.coverage.result.generatestandalonereport.html
% Since R2024a
p = generateStandaloneReport(aggregate_results, ...
  fullfile(pwd, "code-coverage-report.html"), ...
  MetricLevel = "statement");  %#ok<NASGU> % decision, condition do not work.

% Unlike the HTML generators, this does not return the path to the generated report.
% https://www.mathworks.com/help/matlab/ref/matlab.coverage.result.generatecoberturareport.html
% Since R2023a
generateCoberturaReport(aggregate_results, ...
  fullfile(pwd, "code-coverage.xml"))

%{
destination_fullpath = fullfile(pwd, "code-coverage");
if isfolder(destination_fullpath)
  rmdir(destination_fullpath, "s")
end  % if
mkdir(destination_fullpath);

% https://www.mathworks.com/help/matlab/ref/matlab.coverage.result.generatehtmlreport.html
% Since R2023a
p = generateHTMLReport(aggregate_results, ...
  fullfile(destination_fullpath), ...
  MainFile = "code-coverage.html", ...
  MetricLevel = "decision");
disp(p)
%}

end  % function
