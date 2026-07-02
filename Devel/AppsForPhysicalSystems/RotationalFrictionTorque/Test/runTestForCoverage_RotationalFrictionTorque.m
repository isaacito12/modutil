function runTestForCoverage_RotationalFrictionTorque
% Run test and measure code coverage for specified source files.
%
% To run this function, change the folder to where this file is stored.

% Copyright 2026 The MathWorks, Inc.

% Files to generate.
result_html_file = fullfile(pwd, "code-coverage-report_RotationalFrictionTorque.html");
result_xml_file = fullfile(pwd, "code-coverage_RotationalFrictionTorque.xml");

% Files to measure code coverage.
coverage_target_namespace_1 = "mus1.app.RotationalFrictionTorque";

% Files that implements tests. They must exist.
test_files = [
  "uiTest_RotationalFrictionTorque.m"
  "uiUptodateTest_RotationalFrictionTorque.m"
  "unittest_RotationalFrictionTorque.m"
  "unittest_RotationalFrictionTorque_settings.m"
  "uptodateTest_RotationalFrictionTorque.m"
  ];
test_files = fullfile(pwd, test_files);
for k = 1 : numel(test_files)
  assert(isfile(test_files(k)))
end  % for
suite = testsuite(test_files);

% -----------------------------------------------------------------------------
cov_result_1 = matlab.unittest.plugins.codecoverage.CoverageResult;

cov_plugin_1 = matlab.unittest.plugins.CodeCoveragePlugin.forNamespace( ...
  coverage_target_namespace_1, ...
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
p = generateStandaloneReport(all_results, result_html_file, MetricLevel="statement");  %#ok<NASGU>
% Decision, condition do not work.

% Unlike the HTML generators, this does not return the path to the generated report.
% https://www.mathworks.com/help/matlab/ref/matlab.coverage.result.generatecoberturareport.html
% Since R2023a
generateCoberturaReport(all_results, result_xml_file);

end  % function
