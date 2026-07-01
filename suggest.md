# Suggested Plan to Update Impacted Top-Level Files

## Context

The `Devel` folder was restructured:

| Before | After |
|--------|-------|
| `Devel/AppUtil/+AppUtil1/` | `Devel/+mus1/+AppUtil/` |
| `Devel/CodeUtil/+CodeUtil1/` | `Devel/+mus1/+CodeUtil/` |
| `Devel/FileUtil/+FileUtil1/` | `Devel/+mus1/+FileUtil/` |
| `Devel/ModelUtil/+ModelUtil1/` | `Devel/+mus1/+ModelUtil/` |
| `Devel/ProjectUtil/+ProjectUtil1/` | `Devel/+mus1/+ProjectUtil/` |
| `Devel/SearchUtil/+SearchUtil1/` | `Devel/+mus1/+SearchUtil/` |
| `Devel/SignalUtil/+SignalUtil1/` | `Devel/+mus1/+SignalUtil/` |
| `Devel/TestUtil/+TestUtil1/` | `Devel/+mus1/+TestUtil/` |
| `Devel/AppUtil/` (non-API files) | `Devel/Test/AppUtil/` |
| `Devel/ModelUtil/` (non-API files) | `Devel/Test/ModelUtil/` |
| `Devel/SearchUtil/` (non-API files) | `Devel/Test/SearchUtil/` |
| `Devel/SignalUtil/` (non-API files) | `Devel/Test/SignalUtil/` |
| `Devel/TestUtil/` (non-API files) | `Devel/Test/TestUtil/` |

Previously each component had its own folder (e.g., `Devel/AppUtil/`) containing both the namespace package (`+AppUtil1/`) and non-API files (app wrappers, screenshots, sample models, tests).

Now:
- All namespace packages are consolidated under `Devel/+mus1/` (renamed without the `1` suffix).
- Non-API files (app wrappers, screenshots, HTML descriptions, sample models) moved to `Devel/Test/<Component>/`.
- The per-component folders (`Devel/AppUtil/`, `Devel/SearchUtil/`, etc.) no longer exist.

---

## File-by-File Update Plan

### 1. `copyAPIFromDevToRelease.m`

**Problem:** Two issues with the current glob+extract logic:

1. The glob `fullfile(devel_top_folder, "**", "+*Util*")` finds the new paths (e.g., `Devel/+mus1/+AppUtil`, `Devel/+mus1/+AppUtil/+Component`), but the leaf folders like `+AppUtil` end with "Util" without a following path separator, so `extractAfter(source_folders, "Util"+("/"|"\"))` will return empty or fail for those entries.

2. For folders that *do* have subfolder content (e.g., `Devel/+mus1/+AppUtil/+Component`), the `extractAfter` matches the first "Util/" and returns just `+Component` — losing the parent `+AppUtil` context. The resulting copy destination would be `Release/ModelingUtilityForSimscape/+Component` instead of the correct nested path.

Previously this worked because the old structure was `Devel/AppUtil/+AppUtil1/+Component`, and `extractAfter("...AppUtil/+AppUtil1/+Component", "Util"+("/"|"\"))` matched "Util/" in "AppUtil/" and returned `+AppUtil1/+Component` — producing the correct flat destination `Release/ModelingUtilityForSimscape/+AppUtil1/+Component`.

**Suggested fix:**
Replace the dynamic glob+extract approach with a direct copy of the `+mus1` folder tree:

```matlab
source_folder = fullfile(devel_top_folder, "+mus1");
assert(isfolder(source_folder))

destination_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
if not(NameValuePair.DryRun)
  if isfolder(destination_folder)
    rmdir(destination_folder, "s")
  end
  mkdir(destination_folder)
end

% Copy the entire +mus1 namespace tree
dst = fullfile(destination_folder, "+mus1");
cmd = "copyfile(""" + source_folder + """, """ + dst + """)";
if NameValuePair.DryRun
  disp("Dry run: " + cmd)
else
  disp(cmd)
  eval(cmd)
end
```

This copies `Devel/+mus1/` to `Release/ModelingUtilityForSimscape/+mus1/`, preserving the exact namespace structure so that `mus1.AppUtil.*`, `mus1.CodeUtil.*` etc. work from the Release folder.

**Impact on Release consumers:** Users of the Release folder will need to call `mus1.AppUtil.functionName` instead of `AppUtil1.functionName`. This is consistent with the Devel-side change.

---

### 2. `copyComponent_additional_files_AppUtil.m`

**Problem:** References `fullfile(repo_top_folder, "Devel", "AppUtil")` which no longer exists.

**Fix:** Change the source folder to point to `Devel/Test/AppUtil` where `ContourQuiverApp.m` now lives:

```matlab
% Old:
source_folder = fullfile(repo_top_folder, "Devel", "AppUtil");

% New:
source_folder = fullfile(repo_top_folder, "Devel", "Test", "AppUtil");
```

The file `ContourQuiverApp.m` is confirmed at `Devel/Test/AppUtil/ContourQuiverApp.m`.

---

### 3. `copyComponent_additional_files_ModelUtil.m`

**Problem:** References `fullfile(repo_top_folder, "Devel", "ModelUtil")` which no longer exists.

**Fix:** Change the source folder to `Devel/Test/ModelUtil`:

```matlab
% Old:
source_folder = fullfile(repo_top_folder, "Devel", "ModelUtil");

% New:
source_folder = fullfile(repo_top_folder, "Devel", "Test", "ModelUtil");
```

Files confirmed at new locations:
- `Devel/Test/ModelUtil/screenshot-LookupTable1DBlockPlotApp-light.png`
- `Devel/Test/ModelUtil/LookupTable1DBlockPlotApp.m`
- `Devel/Test/ModelUtil/LookupTable1DBlockPlotApp_SampleModel_24b.mdl`

---

### 4. `copyComponent_additional_files_SearchUtil.m`

**Problem:** References `fullfile(repo_top_folder, "Devel", "SearchUtil")` which no longer exists.

**Fix:** Change the source folder to `Devel/Test/SearchUtil`:

```matlab
% Old:
source_folder = fullfile(repo_top_folder, "Devel", "SearchUtil");

% New:
source_folder = fullfile(repo_top_folder, "Devel", "Test", "SearchUtil");
```

Files confirmed at new locations:
- `Devel/Test/SearchUtil/screenshot-FileSearchApp-light.png`
- `Devel/Test/SearchUtil/screenshot-FileSearchResultApp-light.png`
- `Devel/Test/SearchUtil/screenshot-FolderSearchApp-light.png`
- `Devel/Test/SearchUtil/screenshot-FolderSearchResultApp-light.png`
- `Devel/Test/SearchUtil/screenshot-TextSearchApp-light.png`
- `Devel/Test/SearchUtil/screenshot-TextSearchResultApp-light.png`
- `Devel/Test/SearchUtil/FileSearchApp.m`
- `Devel/Test/SearchUtil/FolderSearchApp.m`
- `Devel/Test/SearchUtil/TextSearchApp.m`
- `Devel/Test/SearchUtil/TextSearchResultApp.m`

---

### 5. `copyComponent_additional_files_SignalUtil.m`

**Problem:** References `fullfile(repo_top_folder, "Devel", "SignalUtil")` which no longer exists.

**Fix:** Change the source folder to `Devel/Test/SignalUtil`:

```matlab
% Old:
source_folder = fullfile(repo_top_folder, "Devel", "SignalUtil");

% New:
source_folder = fullfile(repo_top_folder, "Devel", "Test", "SignalUtil");
```

Files confirmed at new locations:
- `Devel/Test/SignalUtil/screenshot-SignalDesignApp-light.png`
- `Devel/Test/SignalUtil/screenshot-TraceGeneratorApp-light.png`
- `Devel/Test/SignalUtil/SignalDesignApp_Description.html`
- `Devel/Test/SignalUtil/SignalDesignApp.m`
- `Devel/Test/SignalUtil/TraceGeneratorApp_Description.html`
- `Devel/Test/SignalUtil/TraceGeneratorApp.m`

---

### 6. `copyComponent_additional_files_TestUtil.m`

**Problem:** References `fullfile(repo_top_folder, "Devel", "TestUtil")` which no longer exists.

**Fix:** Change the source folder to `Devel/Test/TestUtil`:

```matlab
% Old:
source_folder = fullfile(repo_top_folder, "Devel", "TestUtil");

% New:
source_folder = fullfile(repo_top_folder, "Devel", "Test", "TestUtil");
```

Files confirmed at new locations:
- `Devel/Test/TestUtil/screenshot-TestResultApp-light.png` (note: the glob `**` + filename pattern will still find it)
- `Devel/Test/TestUtil/CodeCoverageApp.m`
- `Devel/Test/TestUtil/TestResultApp.m`

---

## Execution Order

1. **First** — update `copyAPIFromDevToRelease.m` (item 1). This is the most significant change since it alters the Release folder's namespace structure.

2. **Second** — update the 5 `copyComponent_additional_files_*.m` scripts (items 2-6). These are straightforward path changes from `"Devel", "<Component>"` to `"Devel", "Test", "<Component>"`.

3. **Third** — run `copyAll.m` with `DryRun=true` to verify all source paths resolve correctly before doing an actual copy.

4. **Fourth** — update `CLAUDE.md` documentation to reflect the new folder structure.

---

## Risks and Considerations

- The `copyComponent_additional_files_*.m` functions use `matlab.buildtool.io.FileCollection.fromPaths(fullfile(source_folder, "**", "screenshot-*.png"))` to locate screenshots. Since these use `**` glob patterns, they will work as long as the `source_folder` root is correct. The fix (changing the root) is sufficient.

- The `AppsForPhysicalSystems` copy scripts (`copyComponent_AppsForPhysicalSystems_*.m`) are NOT impacted because `Devel/AppsForPhysicalSystems/` still exists with its original substructure (`+AbstractMotorEfficiency1/`, `+RotationalFrictionTorque1/`, `+Vehicle1DForce1/` remain in place).

- The `unsetDevelPath.m` script is functionally correct but may now remove fewer paths (since the old per-component folders no longer exist). No code change needed.

- The Release folder structure changes from having `+AppUtil1`, `+CodeUtil1`, etc. at top level to having `+mus1` with sub-namespaces. Any external code (GitHub Actions tests, user scripts) that references the old Release namespace (`AppUtil1.functionName`) will need to migrate to `mus1.AppUtil.functionName`.

- The `copyComponent_additional_files_TestUtil.m` uses a `**` glob to find `screenshot-TestResultApp-light.png`. In the new structure, there are two matches under `Devel/Test/TestUtil/`:
  - `Devel/Test/TestUtil/screenshot-TestResultApp-light.png`
  - `Devel/Test/TestUtil/media/screenshot-TestResultApp-light-1.png` (different name, won't match)
  
  The existing code takes `files(1)` which will work correctly.
