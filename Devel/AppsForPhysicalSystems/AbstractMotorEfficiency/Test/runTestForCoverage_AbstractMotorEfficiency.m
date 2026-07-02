function runTestForCoverage_AbstractMotorEfficiency
% Run test and measure code coverage for specified source files.

% Copyright 2026 The MathWorks, Inc.

namespace_1 = "mus1.app.AbstractMotorEfficiency";

test_file_1 = fullfile(pwd, "uiTest_AbstractMotorEfficiency.m");
assert(isfile(test_file_1))

test_file_2 = fullfile(pwd, "unittest_AbstractMotorEfficiency.m");
assert(isfile(test_file_2))

suite = testsuite([test_file_1, test_file_2]);

% -----------------------------------------------------------------------------
cov_result_1 = matlab.unittest.plugins.codecoverage.CoverageResult;
cov_plugin_1 = matlab.unittest.plugins.CodeCoveragePlugin.forNamespace( ...
  namespace_1, ...
  Producing = cov_result_1 );

runner = matlab.unittest.TestRunner.withTextOutput( ...
  OutputDetail = matlab.unittest.Verbosity.Detailed);
addPlugin(runner, cov_plugin_1)

results = run(runner, suite);
assertSuccess(results)

disp(cov_result_1.Result)

all_results = cov_result_1.Result;

% Assigning the return value prevents the HTML report window from showing up.
% https://www.mathworks.com/help/matlab-test/ref/matlab.coverage.result.generatestandalonereport.html
% Since R2024a
p = generateStandaloneReport(all_results, ...
  fullfile(pwd, "code-coverage-report.html"), ...
  MetricLevel = "statement");  %#ok<NASGU> % decision, condition do not work.

% Unlike the HTML generators, this does not return the path to the generated report.
% https://www.mathworks.com/help/matlab/ref/matlab.coverage.result.generatecoberturareport.html
% Since R2023a
generateCoberturaReport(all_results, ...
  fullfile(pwd, "code-coverage.xml"))

end  % function
