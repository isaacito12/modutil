# suggest / top

Review of yml files in `.github/workflows/`.

## Issues

### 2. Missing `apt-get update` before `apt-get install` (all 4 test workflows)
The XVFB step runs `sudo apt-get install xvfb` without first running `apt-get update`. If the package index on the runner is stale, this could fail. Additionally, `xvfb` is typically pre-installed on `ubuntu-latest` runners, so the install may be unnecessary. A safer pattern:
```yaml
run: |
  sudo apt-get update && sudo apt-get install -y xvfb
  Xvfb :99 &
  echo "DISPLAY=:99" >> $GITHUB_ENV
```

### 3. Possibly stale artifact path (`linux-test-devel-24b.yml`, line 127)
The "Upload test result folder" step references `Devel/test-result` (no `-24b` suffix). Per CLAUDE.md, the `buildfile_24b` outputs to `test-result-24b/`. If `Devel/test-result` is never created by this workflow, this upload step silently captures nothing. Verify this path is intentional or correct it to `Devel/test-result-24b`.

## Suggestions for Improvement

### 4. Add post-test reporting to R2026a workflows
`linux-test-devel-26a.yml` and `linux-test-release-26a.yml` have no SARIF upload, JUnit report, artifact upload, or coverage reporting — only `linux-test-devel-24b.yml` does. If R2026a tests produce similar artifacts, adding these steps would improve CI visibility. If they don't, a brief comment explaining why would help future maintainers.

### 5. Add `concurrency` to avoid redundant CI runs
None of the workflows define a `concurrency` group. Rapid successive pushes to the same branch will trigger parallel workflow runs. Adding this to each workflow would cancel stale runs and save CI minutes:
```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

### 6. Inconsistent job ID naming
- Devel workflows use `test-job` (kebab-case)
- Release workflows use `TestJob` (PascalCase)

Not functional, but inconsistent. Pick one convention.

### 7. Single-entry matrix strategy (all 4 test workflows)
Each workflow defines a `matrix` with a single configuration. This adds indirection without current benefit. It's fine as a placeholder if you plan to add more configurations (e.g., multiple OS or MATLAB versions), but if not, simplifying to direct variables would reduce noise. Low priority — no functional impact.

## Things That Look Good

- **Branch triggers** are consistent across all test workflows (`R2024b`, `R2024b-devel`).
- **`paths-ignore`** is well-configured — excludes docs/media but correctly does NOT exclude `.yml` files (so workflow changes still trigger CI).
- **R2024b vs R2026a buildfile difference** is handled correctly: R2024b calls `setup_paths` explicitly while R2026a relies on the buildfile's built-in `SetupPaths` dependency.
- **Release workflow** (`release-in-github.yml`) is clean — properly cleans build artifacts before zipping and uses a sensible naming convention.
- **`workflow_dispatch`** is enabled on test workflows for manual triggering.
- **`if: always()`** on reporting steps ensures results are captured even when tests fail.
