% Copy all target files and folders from Devel to Release.

% Copyright 2025-2026 The MathWorks, Inc.

dry_run_tf = false;

copyAPIFromDevToRelease(DryRun=dry_run_tf)

copyComponent_ModelUtil_additional_files(DryRun=dry_run_tf)
copyComponent_RotationalFrictionApp(DryRun=dry_run_tf)
copyComponent_SearchUtil_additional_files(DryRun=dry_run_tf)
copyComponent_SignalUtil_additional_files(DryRun=dry_run_tf)
copyComponent_TestUtil_additional_files(DryRun=dry_run_tf)
