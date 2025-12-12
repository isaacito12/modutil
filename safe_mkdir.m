function safe_mkdir(FolderName, DryRun)
%%

% Copyright 2025 The MathWorks, Inc.

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

  return

end  % if

disp(cmd)
eval(cmd)

end  % function
