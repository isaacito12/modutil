function safe_mkdir(FolderName, DryRun)
% Create a folder, with dry run by default.

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Input)
  FolderName (1,1) string
  DryRun (1,1) logical = true
end  % arguments

cmd = "mkdir(""" + FolderName + """)";

if DryRun
  disp("Dry run: " + cmd)

  return

end  % if

if isfolder(FolderName)
  % Return without calling mkdir to avoid warning.

  return

end  % if

disp(cmd)
eval(cmd)

end  % function
