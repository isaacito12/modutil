% Copy all target files and folders from the Devel folder to the Release folder.

% Copyright 2025-2026 The MathWorks, Inc.

dry_run_tf = false;
% dry_run_tf = true;

copyAPIFromDevToRelease(DryRun=dry_run_tf)

copyComponent_additional_files_ModelUtil(DryRun=dry_run_tf)
copyComponent_additional_files_mus_icons(DryRun=dry_run_tf)

copyComponent_BasicApps(DryRun=dry_run_tf)

copyComponent_AppsForModeling_SignalDesign(DryRun=dry_run_tf)
copyComponent_AppsForModeling_TraceGenerator(DryRun=dry_run_tf)

copyComponent_AppsForPhysicalSystems_AbstractMotorEfficiency(DryRun=dry_run_tf)
copyComponent_AppsForPhysicalSystems_RotationalFrictionTorque(DryRun=dry_run_tf)
copyComponent_AppsForPhysicalSystems_Vehicle1DForce(DryRun=dry_run_tf)
