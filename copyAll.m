% Copy all target files and folders from the Devel folder to the Release folder.

% Copyright 2025-2026 The MathWorks, Inc.

% dry_run_tf = false;
dry_run_tf = true;

copyAPIFromDevToRelease(DryRun=dry_run_tf)

copyComponent_additional_files(DryRun=dry_run_tf)

copyComponent_additional_files_AppUtil(DryRun=dry_run_tf)
copyComponent_additional_files_ModelUtil(DryRun=dry_run_tf)
copyComponent_additional_files_mus_icons(DryRun=dry_run_tf)
copyComponent_additional_files_SearchUtil(DryRun=dry_run_tf)
copyComponent_additional_files_SignalUtil(DryRun=dry_run_tf)
copyComponent_additional_files_TestUtil(DryRun=dry_run_tf)

copyComponent_AppsForPhysicalSystems_AbstractMotor(DryRun=dry_run_tf)
copyComponent_AppsForPhysicalSystems_RotationalFriction(DryRun=dry_run_tf)
copyComponent_AppsForPhysicalSystems_Vehicle1D(DryRun=dry_run_tf)
