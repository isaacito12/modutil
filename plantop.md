# Plan: Consolidate `buildfile_24b.m` into `buildfile.m`

**Goal:** Each component's `buildfile.m` adopts the `buildfile_24b.m` structure (R2024b-compatible: no `SupportingFiles`, no `localfunctions`), with output folder `test-result/`. Then delete `buildfile_24b.m`.

## Key differences between the two variants

| Feature | `buildfile.m` (current) | `buildfile_24b.m` |
|---------|------------------------|-------------------|
| `CodeIssues` task | Present in 4/5 (missing in AppUtil) | Present in all 5 |
| `SupportingFiles` on TestTask | Used in CodeUtil, FileUtil, TestUtil (R2025a+) | Never used |
| `DefaultTasks` | `"CodeIssues"` in 4, `"Test"` in AppUtil | `"CodeIssues"` in all |
| Test `Dependencies` | `"CodeIssues"` in 4, none in AppUtil | `"CodeIssues"` in all |
| Output folder | `test-result/` | `test-result-24b/` |
| Help text | "In the Editor, use Run Build..." | "If Devel is the current folder, buildtool -buildFile ..." |

## What each `buildfile.m` will become

The new content follows the `buildfile_24b.m` pattern but with `test-result/` as the output folder and function name `buildfile`:

```matlab
function plan = buildfile
% Define tasks for the buildtool to check code and run tests.
%
% If the Devel folder is the current folder,
% start tests as follows.
%   buildtool -buildFile <Component>\buildfile.m -verbosity Verbose Test

% Copyright <year-range> The MathWorks, Inc.

plan = buildplan();
plan.DefaultTasks = "CodeIssues";

plan("CodeIssues") = matlab.buildtool.tasks.CodeIssuesTask( ...
  WarningThreshold = Inf, ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  Results = [ ...
  "test-result/code-issues.mat"
  "test-result/code-issues.sarif"
  ]);

plan("Test") = matlab.buildtool.tasks.TestTask( ...
  Dependencies = "CodeIssues", ...
  SourceFiles = ["**/*.m", "**/*.mlx"], ...
  TestResults = [ ...
  "test-result/test-result.pdf"
  "test-result/test-result.xml"
  ], ...
  CodeCoverageResults = [ ...
  "test-result/code-coverage.html"
  "test-result/code-coverage.xml"
  ] );

end  % function
```

## Per-file actions

| # | File | Action |
|---|------|--------|
| 1 | `Devel\AppUtil\buildfile.m` | **Rewrite** -- currently missing `CodeIssues` task; adopt `buildfile_24b.m` structure with `test-result/` |
| 2 | `Devel\AppUtil\buildfile_24b.m` | **Delete** |
| 3 | `Devel\CodeUtil\buildfile.m` | **Rewrite** -- remove `SupportingFiles`; adopt `buildfile_24b.m` structure with `test-result/` |
| 4 | `Devel\CodeUtil\buildfile_24b.m` | **Delete** |
| 5 | `Devel\FileUtil\buildfile.m` | **Rewrite** -- remove `SupportingFiles`; adopt `buildfile_24b.m` structure with `test-result/` |
| 6 | `Devel\FileUtil\buildfile_24b.m` | **Delete** |
| 7 | `Devel\SignalUtil\buildfile.m` | **Rewrite** -- remove `SupportingFiles`; adopt `buildfile_24b.m` structure with `test-result/` |
| 8 | `Devel\SignalUtil\buildfile_24b.m` | **Delete** |
| 9 | `Devel\TestUtil\buildfile.m` | **Rewrite** -- remove `SupportingFiles`; adopt `buildfile_24b.m` structure with `test-result/` |
| 10 | `Devel\TestUtil\buildfile_24b.m` | **Delete** |

## What's removed from current `buildfile.m` files

- `SupportingFiles` property (R2025a-only feature, not compatible with R2024b)
- References to `localfunctions` or `Run Build from Toolstrip` comments (keep just the standard doc links)

## What's preserved

- Function name stays `buildfile` (not `buildfile_24b`)
- Output folder stays `test-result/` (not `test-result-24b/`)
- Copyright year ranges from the `buildfile_24b.m` originals (wider range)

## Help text in each file

The usage comment will reference the component's own path:
- AppUtil: `buildtool -buildFile AppUtil\buildfile.m -verbosity Verbose Test`
- CodeUtil: `buildtool -buildFile CodeUtil\buildfile.m -verbosity Verbose Test`
- FileUtil: `buildtool -buildFile FileUtil\buildfile.m -verbosity Verbose Test`
- SignalUtil: `buildtool -buildFile SignalUtil\buildfile.m -verbosity Verbose Test`
- TestUtil: `buildtool -buildFile TestUtil\buildfile.m -verbosity Verbose Test`
