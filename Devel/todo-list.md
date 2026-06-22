# To-do list

## Signal Design App

Add support for a struct variable in the base workspace.

## Rotational Friction Torque App

Add a section in the description file to show the usages of the `plot` function.

Add support for the angle-based Friction Torque block.

- The existing app should support it.

Add support for the Disc Brake block (Driveline).

- A new app would be necessary because the Disc Brake block parameters are not
  exactly the same as the rotational friction torque block, but
  it still shares underlying code with the existing friction troque app.

## Vehicle 1D Force App

Add a section in the description file to show the usages of the `plot` function.

Write a section in the description file about how to determine vehicle specs.

## Text Search App

Are multiple instances `TextSearchApp` properly isolated?

## Error handling for UI components and DataSet in AppMain code

Relevant components

- `PhysicalValueWithUnitDropDown`
- `PhysicalValueWithUnitLabel`

In AppMain code, assigning the above UI component's property (such as SimscapeValue)
to a DataSet property needs exception handling because of constraints defined for
DataSet properties.

## Needs investigation

Test failures during CI

- [Test job for Devel-folder in MATLAB R2024b on Linux summary][permalink_1]
- [Test job for Devel-folder in MATLAB R2026a on Linux summary][permalink_2]

[permalink_1]: https://github.com/isaacito12/modutil-simscape/actions/runs/27937224774/attempts/1#summary-82661711467
[permalink_2]: https://github.com/isaacito12/modutil-simscape/actions/runs/27937224746/attempts/1#summary-82661711368

### Opening the Variables window (a.k.a. Variables Editor) in CI

Failed in 24b and 26b.

Error ID: `MATLAB:services:MissingRequiredCapability`

- Test class: `uiTest_BaseWorkspaceStructParameterUI`
- Test function: `Gesture_2_1`
- Failure at the line with a comment `!attention: locally works, but can fail in CI.`
  (line 102 as of this writing.)

### Opening the Editor in CI, 1

Passed in 24b. Failed in 26b.

Error ID: `MATLAB:uix:unxdebug:UnknownService`

- Test class: `uiTest_BaseWorkspaceStructParameterUI`
- Test function: `Gesture_2_2`
- Failure at the line with a comment `!attention: locally works, but can fail in CI.`
  (line 127 as of this writing.)

### Opening the Editor in CI, 2

Passed in 24b. Failed in 26b.

Error ID: `MATLAB:uix:unxdebug:UnknownService`

- Test class: `uitest_WindowHeader`
- Test function: `Gesture_1`
- Failure at the line with a comment `!attention: locally works, but can fail in CI.`
  (line 90 as of this writing.)

### Opening the Editor in CI, 3

Passed in 24b. Failed in 26b.

Error ID: `MATLAB:uix:unxdebug:UnknownService`

- Test class: `unittest_openWithLink`
- Test function: `PassingTest_1`
- Failure at the line with a comment `!attention: locally works, but can fail in CI.`
  (line 90 as of this writing.)
