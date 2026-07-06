function runTestForReleaseCodeCoverage
% Run test and measure code coverage for specified source files.

% Copyright 2026 The MathWorks, Inc.

source_folder_1 = fullfile(pwd, "ModelingUtilityForSimscape");
assert(isfolder(source_folder_1))

test_file_1 = fullfile(pwd, "PassingTests.m");
assert(isfile(test_file_1))
suite = testsuite(test_file_1);

% -----------------------------------------------------------------------------

runner = matlab.unittest.TestRunner.withTextOutput( ...
  OutputDetail = matlab.unittest.Verbosity.Detailed);

cov_result_1 = matlab.unittest.plugins.codecoverage.CoverageResult;
cov_plugin_1 = matlab.unittest.plugins.CodeCoveragePlugin.forFolder( ...
  source_folder_1, ...
  Producing = cov_result_1 );
addPlugin(runner, cov_plugin_1)

results = run(runner, suite);
assertSuccess(results)

disp(cov_result_1.Result)

end  % function
