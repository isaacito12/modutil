# Suggestion: Adapting Vehicle1DForce Test Files to the New Namespace

The `+Vehicle1DForce1` namespace has moved to `+mus1/+app/+Vehicle1DForce`.
The wrapper function has been renamed from `Vehicle1DForceApp` to `mus1_Vehicle1DForceApp`.

Using the AbstractMotorEfficiency and RotationalFrictionTorque test folders as references.

---

## File: `runTestForCoverage_Vehicle1DForce.m`

Same pattern as the updated `runTestForCoverage_RotationalFrictionTorque.m`:

| Aspect | Old | New |
|--------|-----|-----|
| Namespace variable | `namespace_1 = "Vehicle1DForce1"` | `coverage_target_namespace_1 = "mus1.app.Vehicle1DForce"` |
| Test file listing | Two individual `test_file_1`, `test_file_2` variables | Single `test_files` string array with `for` loop assert |
| Output file names | `"code-coverage-report.html"`, `"code-coverage.xml"` | `"code-coverage-report_Vehicle1DForce.html"`, `"code-coverage_Vehicle1DForce.xml"` declared as named variables at top |
| Plugin/runner order | Runner first, then plugin | Plugin first, then runner (matching reference) |
| Remove | `... source_in_namespace_1, ...` commented line | (delete it) |
| Report generation | Inline `fullfile(pwd, ...)` | Use named variables; add semicolons; `% Decision, condition do not work.` on own line |

Include all test files:

```matlab
test_files = [
  "uiTest_Vehicle1DForce.m"
  "uiUptodateTest_Vehicle1DForce.m"
  "unittest_Vehicle1DForce.m"
  "unittest_Vehicle1DForce_settings.m"
  "uptodateTest_Vehicle1DForce.m"
  ];
```

---

## File: `uiUptodateTest_Vehicle1DForce.m`

Same pattern as the updated `uiUptodateTest_RotationalFrictionTorque.m`:

### Section: `app_screenshot_1_dark` and `app_screenshot_1_light` (AppMain tests)

| Aspect | Old | New |
|--------|-----|-----|
| `getFileFullPath` argument | `"Vehicle1DForce1.Vehicle1DForceAppMain"` | `"mus1.app.Vehicle1DForce.Vehicle1DForceAppMain"` |
| `destination_folder` derivation | `fileparts` + `extractBefore(..., "+Vehicle1DForce1")` + append `"media"` | `extractBefore(source_fullpath, ("/"\|"\") + "Devel")` then `fullfile(..., "Devel", "AppsForPhysicalSystems", "Vehicle1DForce", "media")` |
| App instantiation | `Vehicle1DForce1.Vehicle1DForceAppMain` | `mus1.app.Vehicle1DForce.Vehicle1DForceAppMain` |
| `mkdir` comment | `% Assign return value to suppress warning.` | `% Assign return values to suppress warning.` |

### Section: `app_screenshot_2_dark` and `app_screenshot_2_light` (wrapper app tests)

| Aspect | Old | New |
|--------|-----|-----|
| `getFileFullPath` argument | `"Vehicle1DForceApp"` | `"mus1_Vehicle1DForceApp"` |
| `destination_folder` derivation | `fileparts(source_fullpath)` + append `"media"` | `extractBefore(source_fullpath, ("/"\|"\") + "Devel")` then `fullfile(..., "Devel", "AppsForPhysicalSystems", "Vehicle1DForce", "media")` |
| App instantiation | `Vehicle1DForceApp` | `mus1_Vehicle1DForceApp` |
| `mkdir` comment | `% Assign return value to suppress warning.` | `% Assign return values to suppress warning.` |

---

## File: `uiTest_Vehicle1DForce.m`

Replace all occurrences of the old namespace:

| Old | New |
|-----|-----|
| `Vehicle1DForce1.Vehicle1DForceAppMain` | `mus1.app.Vehicle1DForce.Vehicle1DForceAppMain` |
| `@Vehicle1DForceApp` | `@mus1_Vehicle1DForceApp` |

This affects: `clean_launch_1`, `clean_launch_2`, `Test_error_1`, `Gesture_1` through `Gesture_figure_window_2`, `option_ModelName_1`, `option_BlockPath_1`, `option_BlockPath_2`, `set_parameter_to_block_1`, all error path tests, `loadParametersFromBaseWorkspace` tests, `updateApp` tests, and `invalid_data` tests.

---

## File: `unittest_Vehicle1DForce.m`

Replace all occurrences of the old namespace:

| Old | New |
|-----|-----|
| `Vehicle1DForce1.Vehicle1DForceModelParameters` | `mus1.app.Vehicle1DForce.Vehicle1DForceModelParameters` |
| `Vehicle1DForce1.Vehicle1DForceDataSet` | `mus1.app.Vehicle1DForce.Vehicle1DForceDataSet` |
| `Vehicle1DForce1.Vehicle1DForcePresets` | `mus1.app.Vehicle1DForce.Vehicle1DForcePresets` |
| `Vehicle1DForce1.plotVehicle1DForce` | `mus1.app.Vehicle1DForce.plotVehicle1DForce` |

---

## File: `unittest_Vehicle1DForce_settings.m`

No namespace changes needed (references `Simulink.MDLInfo` on a model file, not the namespace).

---

## File: `uptodateTest_Vehicle1DForce.m`

Replace the old wrapper function reference:

| Old | New |
|-----|-----|
| `Vehicle1DForceApp_Description` (line 32) | `mus1_Vehicle1DForceApp_Description` (if renamed) |
| `"Vehicle1DForceApp_Description.mlx"` | `"mus1_Vehicle1DForceApp_Description.mlx"` (if renamed) |

**Note:** Verify whether the description Live Script was actually renamed. If `Vehicle1DForceApp_Description.mlx` still exists under its original name, no change is needed in this file.
