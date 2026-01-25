# Development repository of the Modeling Utility for Simscape™

[![MATLAB](https://github.com/isaacito12/modutil/actions/workflows/linux-test-devel.yml/badge.svg)](https://github.com/isaacito12/modutil/actions/workflows/linux-test-devel.yml)
[![MATLAB](https://github.com/isaacito12/modutil/actions/workflows/linux-test-release.yml/badge.svg)](https://github.com/isaacito12/modutil/actions/workflows/linux-test-release.yml)

This is a development repository of the Modeling Utility for Simscape.

- Development is made under the `Devel` folder.
- The `Release` folder is used to create a release.

For a general introduction, see [`README.md`](Release/README.md) in the `Release` folder.

## Development and local testing

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

## Remote test automation

This repository uses GitHub Actions for remote test automation.
See `.github/workflows` for the workflow definitions.

Running the tests in GitHub Actions requires MATLAB.
For more information, visit the MATLAB Actions site in GitHub.

- https://github.com/matlab-actions

## Release automation

This repository uses the "GitHub Action for Creating GitHub Releases".
For information, visit the Action's GitHub page.

- https://github.com/softprops/action-gh-release

For the workflow definition, see the following file.

- [`.github/workflows/release-in-github.yml`](.github/workflows/release-in-github.yml)

_Copyright 2025-2026 The MathWorks, Inc._
