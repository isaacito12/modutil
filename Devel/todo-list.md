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
