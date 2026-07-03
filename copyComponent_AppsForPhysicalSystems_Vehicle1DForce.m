function copyComponent_AppsForPhysicalSystems_Vehicle1DForce(NameValuePair)
% Copy files from the Devel folder to the Release folder.
%
% This function assumes that the source files are version-managed with git.
% The API files are copied separately.

% Copyright 2026 The MathWorks, Inc.

arguments (Input)
  NameValuePair.DryRun (1,1) logical = true
end  % arguments

try
  repo = gitrepo;
catch exception

  rethrow(exception)

end  % try, catch
repo_top_folder = repo.WorkingFolder;

source_folder = fullfile(repo_top_folder, "Devel", "AppsForPhysicalSystems", "Vehicle1DForce");
assert(isfolder(source_folder))

destination_top_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
safe_mkdir(destination_top_folder, NameValuePair.DryRun)

destination_media_folder = fullfile(destination_top_folder, "media");
safe_mkdir(destination_media_folder, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% Copy releasing files.

safe_copyfile(fullfile(source_folder, "media", "screenshot-Vehicle1DForceApp-light.png"), destination_media_folder, NameValuePair.DryRun)

% Description media folder
src_desc_media = fullfile(source_folder, "media", "Vehicle1DForceApp_Description_mus1_media");
dst_desc_media = fullfile(destination_top_folder, "Vehicle1DForceApp_Description_mus1_media");
safe_mkdir(dst_desc_media, NameValuePair.DryRun)
safe_copyfile(fullfile(src_desc_media, "image_0.png"), dst_desc_media, NameValuePair.DryRun)
safe_copyfile(fullfile(src_desc_media, "figure_0.png"), dst_desc_media, NameValuePair.DryRun)
safe_copyfile(fullfile(src_desc_media, "figure_1.png"), dst_desc_media, NameValuePair.DryRun)

% ---

safe_copyfile(fullfile(source_folder, "mus1_Vehicle1DForceApp.m"), destination_top_folder, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "Vehicle1DForceApp_Description_mus1.html"), destination_top_folder, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "SampleModel_Vehicle1DForce_refsub_24b.mdl"), destination_top_folder, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "Vehicle1DForce_SampleParams1.m"), destination_top_folder, NameValuePair.DryRun)
safe_copyfile(fullfile(source_folder, "Vehicle1DForce_SampleParams2.m"), destination_top_folder, NameValuePair.DryRun)

end  % function
