# Suggestion: Adapting `runTestForCoverage_RotationalFrictionTorque.m` to the New Namespace

Using `runTestForCoverage_AbstractMotorEfficiency.m` as the reference, make these changes:

## 2. Declare output file paths at the top

Add named variables for the result files (with app-specific suffixes), matching the reference pattern:

```matlab
result_html_file = fullfile(pwd, "code-coverage-report_RotationalFrictionTorque.html");
result_xml_file = fullfile(pwd, "code-coverage_RotationalFrictionTorque.xml");
```

## 3. Update namespace for coverage target

| Old | New |
|-----|-----|
| `namespace_1 = "RotationalFrictionTorque1";` | `coverage_target_namespace_1 = "mus1.app.RotationalFrictionTorque";` |

## 4. Restructure test file listing

Replace the individual `test_file_1`, `test_file_2` variables with a single string array and a `for` loop to assert existence, matching the reference style:

```matlab
test_files = [
 "uiTest_RotationalFrictionTorque.m"
 "unittest_RotationalFrictionTorque.m"
 "unittest_RotationalFrictionTorque_settings.m"
 "uptodateTest_RotationalFrictionTorque.m"
  ];
test_files = fullfile(pwd, test_files);
for k = 1 : numel(test_files)
  assert(isfile(test_files(k)))
end  % for
suite = testsuite(test_files);
```

## 5. Reorder runner/plugin creation to match reference

In the reference, `cov_result_1` and `cov_plugin_1` are created before the runner. Move them above `TestRunner.withTextOutput(...)`.

## 6. Update variable name in `forNamespace`

| Old | New |
|-----|-----|
| `namespace_1` | `coverage_target_namespace_1` |

Also remove the commented-out `... source_in_namespace_1, ...` line.

## 7. Update report generation calls to use the named variables

| Old | New |
|-----|-----|
| `fullfile(pwd, "code-coverage-report.html")` | `result_html_file` |
| `fullfile(pwd, "code-coverage.xml")` | `result_xml_file` |

Also add a semicolon at the end of `generateCoberturaReport(...)` and adjust comment formatting to match the reference (`% Decision, condition do not work.` on its own line).
