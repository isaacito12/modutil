function safe_copyfile(SourceFilename, DestinationFolder, DryRun)
% Copy the specified file to the specified folder, with dry run by default.

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Input)
  SourceFilename (1,1) string
  DestinationFolder (1,1) string
  DryRun (1,1) logical = true
end  % arguments

cmd = "copyfile(""" + SourceFilename + """, """ + DestinationFolder + """)";

if not(isfile(SourceFilename))
  warning("Source file was not found: " + SourceFilename)
end  %if

if DryRun
  disp("Dry run: " + cmd)

  return

end  % if

if not(isfolder(DestinationFolder))
  mkdir(DestinationFolder)
end  % if

disp(cmd)
eval(cmd)

end  % function
