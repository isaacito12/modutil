function copyAPIFromDevToRelease(NameValuePair)
%% Copy the utility source files to the "Release > ModelingUtilityForSimscape" folder.
% This function copies all "+*Util" folders under the Devel folder to
% the destination "Release > ModelingUtilityForSimscape" folder.
% This function deletes the ModelingUtilityForSimscape folder if it already exists before copying.

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  NameValuePair.RepoTopFolder (1,1) string {mustBeFolder} = "C:\local\modutil\modeling-utility"
  NameValuePair.DryRun (1,1) logical = true
end  % arguments

assert(pwd == NameValuePair.RepoTopFolder)

devel_top_folder = fullfile(NameValuePair.RepoTopFolder, "Devel");
assert(isfolder(devel_top_folder))

destination_folder = fullfile(NameValuePair.RepoTopFolder, "Release", "ModelingUtilityForSimscape");
if isfolder(destination_folder)
  rmdir(destination_folder, "s")
end  % if
mkdir(destination_folder)

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
