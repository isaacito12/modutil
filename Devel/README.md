# Notes

To run tests for one utility, specify the `buildfile*.m` file for that utility.
For example, to run tests for the SearchUtil, use the following command:

```matlab
% Assuming that the current folder is the "Devel" folder.
buildtool -buildFile SearchUtil\buildfile_24b.m -verbosity Verbose Test
```

_Copyright 2026 The MathWorks, Inc._
