function copyComponent_BasicApps(NameValuePair)
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

source_top = fullfile(repo_top_folder, "Devel", "BasicApps");
assert(isfolder(source_top))

dst = fullfile(repo_top_folder, "Release-mus1", "ModelingUtilityForSimscape");
safe_mkdir(dst, NameValuePair.DryRun)

dst_media = fullfile(dst, "media");
safe_mkdir(dst_media, NameValuePair.DryRun)

% -----------------------------------------------------------------------------
% FileList

safe_copyfile(fullfile(source_top, "FileList", "mus1", "mus1_FileListApp.m"), dst, NameValuePair.DryRun)
safe_copyfile(fullfile(source_top, "FileList", "mus1", "media", "screenshot-FileListApp-light.png"), dst_media, NameValuePair.DryRun)

% FileSearch
safe_copyfile(fullfile(source_top, "FileSearch", "mus1", "mus1_FileSearchApp.m"), dst, NameValuePair.DryRun)
safe_copyfile(fullfile(source_top, "FileSearch", "mus1", "media", "screenshot-FileSearchApp-light.png"), dst_media, NameValuePair.DryRun)
safe_copyfile(fullfile(source_top, "FileSearch", "mus1", "media", "screenshot-FileSearchResultApp-light.png"), dst_media, NameValuePair.DryRun)

% FolderSearch
safe_copyfile(fullfile(source_top, "FolderSearch", "mus1", "mus1_FolderSearchApp.m"), dst, NameValuePair.DryRun)
safe_copyfile(fullfile(source_top, "FolderSearch", "mus1", "media", "screenshot-FolderSearchApp-light.png"), dst_media, NameValuePair.DryRun)
safe_copyfile(fullfile(source_top, "FolderSearch", "mus1", "media", "screenshot-FolderSearchResultApp-light.png"), dst_media, NameValuePair.DryRun)

% TextSearch
safe_copyfile(fullfile(source_top, "TextSearch", "mus1", "mus1_TextSearchApp.m"), dst, NameValuePair.DryRun)
safe_copyfile(fullfile(source_top, "TextSearch", "mus1", "mus1_TextSearchResultApp.m"), dst, NameValuePair.DryRun)
safe_copyfile(fullfile(source_top, "TextSearch", "mus1", "media", "screenshot-TextSearchApp-light.png"), dst_media, NameValuePair.DryRun)
safe_copyfile(fullfile(source_top, "TextSearch", "mus1", "media", "screenshot-TextSearchResultApp-light.png"), dst_media, NameValuePair.DryRun)

end  % function
