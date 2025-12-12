function safe_copyfile(SourceFilename, DestinationFolder, DryRun)
%%

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  SourceFilename (1,1) string
  DestinationFolder (1,1) string
  DryRun (1,1) logical = true
end  % arguments

cmd = "copyfile(""" + SourceFilename + """, """ + DestinationFolder + """)";

if DryRun
  disp("Dry run: " + cmd)

  return

end  % if

mustBeFile(SourceFilename)

if not(isfolder(DestinationFolder))
  mkdir(DestinationFolder)
end  % if

disp(cmd)
eval(cmd)

end  % function
