function runTestForCoverage_AbstractMotorEfficiencyModelParameters
% Run test and measure code coverage for specified source files.

% Copyright 2026 The MathWorks, Inc.

target_file = fullfile(pwd, "..", "+AbstractMotorEfficiency1", "AbstractMotorEfficiencyModelParameters.m");
test_file = fullfile(pwd, "unittest_AbstractMotorEfficiencyModelParameters.m");
report_file = fullfile(pwd, "code-coverage-report_AbstractMotorEfficiencyModelParameters.html");

% This assertion requires that the current folder is where this file exists.
assert(isfile(test_file))

suite = testsuite(test_file);

% -----------------------------------------------------------------------------
cov_result = matlab.unittest.plugins.codecoverage.CoverageResult;
cov_plugin = matlab.unittest.plugins.CodeCoveragePlugin.forFile(target_file, Producing=cov_result);

runner = matlab.unittest.TestRunner.withTextOutput(OutputDetail=matlab.unittest.Verbosity.Detailed);
addPlugin(runner, cov_plugin)

results = run(runner, suite);
assertSuccess(results)

disp(cov_result.Result)

% Assigning the return value prevents the HTML report window from showing up.
% https://www.mathworks.com/help/matlab-test/ref/matlab.coverage.result.generatestandalonereport.html
% Since R2024a
p = generateStandaloneReport(cov_result.Result, report_file, MetricLevel="statement");  %#ok<NASGU>
% MetricLevel="decision" and MetricLevel="condition" do not work.

end  % function
