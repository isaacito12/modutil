function copyAPIFromDevToRelease(NameValuePair)
% Copy the utility API source files to the "Release > ModelingUtilityForSimscape" folder.
%
% This function assumes that the source files are version-managed with git.
%
% This function copies the "+mus1" namespace folder under the Devel folder to
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

source_folder = fullfile(devel_top_folder, "+mus1");
assert(isfolder(source_folder))

destination_folder = fullfile(repo_top_folder, "Release-mus1", "ModelingUtilityForSimscape");
if not(NameValuePair.DryRun)
  if isfolder(destination_folder)

    rmdir(destination_folder, "s")

  end  % if
  mkdir(destination_folder)
end  % if

dst = fullfile(destination_folder, "+mus1");
cmd = "copyfile(""" + source_folder + """, """ + dst + """)";

if NameValuePair.DryRun
  disp("Dry run: " + cmd)

  return

end  % if

disp(cmd)
eval(cmd)

end  % function
