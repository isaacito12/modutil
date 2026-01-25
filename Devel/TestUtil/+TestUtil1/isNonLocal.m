function TrueOrFalse = isNonLocal(top_folder)
% Check if the current folder is outside of the specified folder.

% Copyright 2026 The MathWorks, Inc.

arguments (Input)
  top_folder (1,1) string {mustBeFolder}
end  % arguments

arguments (Output)
  TrueOrFalse (1,1) logical
end  % arguments

if startsWith(pwd, top_folder)
  % Test is running within the specified folder.
  TrueOrFalse = false;

  return

end  % if

% Test is running outside of the specified folder.
TrueOrFalse = true;

end  % function
