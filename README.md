# Development repository of the Modeling Utility for Simscape™

This is a development repository of the Modeling Utility for Simscape.

- Development is made under the `Devel` folder.
- The `Release` folder is used to create a release.

For a general introduction, see `README.md` in the `Release` folder.

## Development and testing

In MATLAB®, cd to the `Devel` folder and run `setup_paths` to set up MATLAB path.

To run tests in the `Devel` folder:

1. Make sure that MATLAB path does not include the `Release` folder and its subfolders.
   Use `unsetReleasePath.m` to remove the path if necessary.
2. Use `buildfile.m` in the `Devel` folder.

To run tests in the `Release` folder:

1. Make sure that MATLAB path does not include the `Devel` folder and its subfolders.
2. Copy target files and folders from `Devel` to `Release`
   using `copyAll.m` or other `copy*.m` files.
3. Use `buildfile.m` in the `Release` folder.

`cleanup*.m` can delete files and folders that are safe to delete.
Such files and folders include `.buildtool` folders created by the Build Tool,
`test-result` folders created to store test results,
and those in `Release` that were copied from `Devel`.

## Test Automation

This repository uses GitHub Actions for test automation.
See `.github/workflows` for the workflow definitions.

Running the tests in GitHub Actions requires MATLAB,
for which the repository in GitHub must be public.
For more information, visit the MATLAB Actions site in GitHub.

- https://github.com/matlab-actions

_Copyright 2025-2026 The MathWorks, Inc._
