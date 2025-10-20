function copySourceForRelease(NameValuePair)
%% Copy the utility source files to the "Release > ModelingUtilityForSimscape" folder.

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  NameValuePair.DryRun (1,1) logical = true
  NameValuePair.RepoTopFolder (1,1) string {mustBeFolder} = "C:\local\modutil\modeling-utility"
end  % arguments

assert(pwd == NameValuePair.RepoTopFolder)

devel_folder = fullfile(NameValuePair.RepoTopFolder, "Devel");
assert(isfolder(devel_folder))

release_folder = fullfile(NameValuePair.RepoTopFolder, "Release", "ModelingUtilityForSimscape");
assert(isfolder(release_folder))

source_folders = matlab.buildtool.io.FileCollection.fromPaths(fullfile(devel_folder, "**", "+*Util*")).paths';
target_folders = extractAfter(source_folders, "Util"+("/"|"\"));
command_text = strings(numel(target_folders), 1);
for ii = 1 : numel(target_folders)
  source_folder = source_folders(ii);
  destination_folder = fullfile(release_folder, target_folders(ii));
  command_text(ii) = "copyfile(""" + source_folder + """, """ + destination_folder + """)";
end  % for
command_text = join(command_text, newline);

if NameValuePair.DryRun
  disp("Dry run")
  disp(command_text)

  return

end  % if
disp(command_text)
eval(command_text)
end  % function
