function copyAPIFromDevToRelease(NameValuePair)
% Copy the utility API source files to the "Release > ModelingUtilityForSimscape" folder.
%
% This function assumes that the source files are version-managed with git.
%
% This function copies all "+*Util" folders under the Devel folder to
% the destination "Release > ModelingUtilityForSimscape" folder.
% This function deletes the ModelingUtilityForSimscape folder if it already exists before copying.

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Input)
  NameValuePair.DryRun (1,1) logical = true
end  % arguments

try
  repo = gitrepo;
catch exception

  rethrow(exception)

end  % try, catch
repo_top_folder = repo.WorkingFolder;

devel_top_folder = fullfile(repo_top_folder, "Devel");
assert(isfolder(devel_top_folder))

destination_folder = fullfile(repo_top_folder, "Release", "ModelingUtilityForSimscape");
if not(NameValuePair.DryRun)
  if isfolder(destination_folder)

    rmdir(destination_folder, "s")

  end  % if
  mkdir(destination_folder)
end  % if

source_folders = matlab.buildtool.io.FileCollection.fromPaths(fullfile(devel_top_folder, "**", "+*Util*")).paths';
target_folders = extractAfter(source_folders, "Util"+("/"|"\"));
command_texts = strings(numel(target_folders), 1);
for ii = 1 : numel(target_folders)
  src = source_folders(ii);
  dst = fullfile(destination_folder, target_folders(ii));
  command_texts(ii) = "copyfile(""" + src + """, """ + dst + """)";
end  % for

if NameValuePair.DryRun
  joined_text = join("Dry run: " + command_texts, newline);
  disp(joined_text)

  return

end  % if

for ii = 1 : numel(command_texts)
  disp(command_texts(ii))
  eval(command_texts(ii))
end  % for

end  % function
