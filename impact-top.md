# Impact Analysis: Top-Level Files Affected by Devel Folder Restructuring

## Summary of Change

All MATLAB namespace folders previously at `Devel/+ComponentName1/` have been moved under `Devel/+mus1/+ComponentName/`. Additionally, the per-component non-namespace folders (e.g., `Devel/AppUtil/`, `Devel/ModelUtil/`, `Devel/SearchUtil/`, `Devel/SignalUtil/`, `Devel/TestUtil/`) that held app wrapper scripts, screenshots, and other non-API files no longer exist at those paths.

The new structure:
- `Devel/+mus1/+AppUtil/` (was `Devel/+AppUtil1/`)
- `Devel/+mus1/+CodeUtil/` (was `Devel/+CodeUtil1/`)
- `Devel/+mus1/+FileUtil/` (was `Devel/+FileUtil1/`)
- `Devel/+mus1/+ModelUtil/` (was `Devel/+ModelUtil1/`)
- `Devel/+mus1/+ProjectUtil/` (was `Devel/+ProjectUtil1/`)
- `Devel/+mus1/+SearchUtil/` (was `Devel/+SearchUtil1/`)
- `Devel/+mus1/+SignalUtil/` (was `Devel/+SignalUtil1/`)
- `Devel/+mus1/+TestUtil/` (was `Devel/+TestUtil1/`)

---

## Impacted Files

### 1. `copyAPIFromDevToRelease.m` — IMPACTED

**Reason:** Line 38 uses a glob pattern `fullfile(devel_top_folder, "**", "+*Util*")` to find source folders. The pattern will still match the new paths (`Devel/+mus1/+AppUtil`, etc.), but line 39 uses `extractAfter(source_folders, "Util"+("/"|"\"))` to compute target folder names. With the new deeper nesting, the extracted relative paths will differ and the copy destination structure may be wrong.

Additionally, the old structure produced `+AppUtil1/...` under the Release folder. The new namespace names dropped the `1` suffix (e.g., `+AppUtil` instead of `+AppUtil1`), and the parent `+mus1` folder is not accounted for in the copy logic.

---

### 2. `copyComponent_additional_files_AppUtil.m` — IMPACTED

**Reason:** Line 22 references `fullfile(repo_top_folder, "Devel", "AppUtil")`. The folder `Devel/AppUtil` no longer exists. This will fail at the `assert(isfolder(source_folder))` check.

---

### 3. `copyComponent_additional_files_ModelUtil.m` — IMPACTED

**Reason:** Line 22 references `fullfile(repo_top_folder, "Devel", "ModelUtil")`. The folder `Devel/ModelUtil` no longer exists. This will fail at the `assert(isfolder(source_folder))` check.

---

### 4. `copyComponent_additional_files_SearchUtil.m` — IMPACTED

**Reason:** Line 22 references `fullfile(repo_top_folder, "Devel", "SearchUtil")`. The folder `Devel/SearchUtil` no longer exists. This will fail at the `assert(isfolder(source_folder))` check.

---

### 5. `copyComponent_additional_files_SignalUtil.m` — IMPACTED

**Reason:** Line 22 references `fullfile(repo_top_folder, "Devel", "SignalUtil")`. The folder `Devel/SignalUtil` no longer exists. This will fail at the `assert(isfolder(source_folder))` check.

---

### 6. `copyComponent_additional_files_TestUtil.m` — IMPACTED

**Reason:** Line 22 references `fullfile(repo_top_folder, "Devel", "TestUtil")`. The folder `Devel/TestUtil` no longer exists. This will fail at the `assert(isfolder(source_folder))` check.

---

### 7. `unsetDevelPath.m` — POTENTIALLY IMPACTED

**Reason:** This function finds all folders under `Devel` and removes them from the MATLAB path. Line 20 filters out namespace folders (containing `+`). The logic still works structurally since it operates on `Devel/**`, but the set of non-namespace folders has changed (the old per-component folders like `Devel/AppUtil`, `Devel/ModelUtil`, etc. are gone). The function should still operate correctly on the new structure since it dynamically discovers folders, but it will behave differently (fewer folders to remove).

---

### 8. `CLAUDE.md` — IMPACTED (documentation only)

**Reason:** The project documentation references the old folder structure extensively (e.g., `+ComponentName1/` naming, per-component `buildfile.m` locations like `AppUtil\buildfile.m`, the old namespace convention `+ComponentName1`). While not executable code, this documentation will be misleading.

---

## Files NOT Impacted

| File | Reason |
|------|--------|
| `copyAll.m` | Only calls other functions; no direct path references |
| `copyComponent_additional_files.m` | References `Devel/FileListApp.m` which still exists |
| `copyComponent_additional_files_mus_icons.m` | References `Devel/mus-icons` which still exists |
| `copyComponent_AppsForPhysicalSystems_AbstractMotorEfficiency.m` | References `Devel/AppsForPhysicalSystems/AbstractMotorEfficiency` which still exists |
| `copyComponent_AppsForPhysicalSystems_RotationalFrictionTorque.m` | References `Devel/AppsForPhysicalSystems/RotationalFrictionTorque` which still exists |
| `copyComponent_AppsForPhysicalSystems_Vehicle1DForce.m` | References `Devel/AppsForPhysicalSystems/Vehicle1DForce` which still exists |
| `cleanup_Devel_folder.m` | Uses dynamic glob on `Devel/**` for `.buildtool` and `test-result`; still works |
| `cleanup_Release_folder.m` | Operates on `Release/` folder only; not affected by Devel changes |
| `unsetReleasePath.m` | Operates on `Release/` folder only; not affected by Devel changes |
| `replaceTextInTextFiles.m` | Generic utility; no Devel path references |
| `searchForTextInTextFiles.m` | Generic utility; no Devel path references |
| `safe_copyfile.m` | Generic utility; no path references |
| `safe_mkdir.m` | Generic utility; no path references |
