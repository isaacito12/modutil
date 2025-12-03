function ResultTable = findSimscapeBlock(ModelName, SimscapeBlockName)

% Copyright 2025 The MathWorks, Inc.

arguments (Input)
  ModelName (1,1) string = ""
  SimscapeBlockName (1,1) string = ""
end  % arguments

arguments (Output)
  ResultTable table
end  % arguments

errorID = "findSimscapeBlock:";

if ModelName == ""
  id = errorID + "InvalidModelName";
  msg = CodeUtil1.i18n("Model name must be specified.");

  throw(MException(id, msg))

end  % if

if SimscapeBlockName == ""
  id = errorID + "InvalidSimscapeBlockName";
  msg = CodeUtil1.i18n("Simscape block name must be specified.");

  throw(MException(id, msg))

end  % if

result = ModelUtil1.findAllSimscapeBlocks(ModelName);

if isempty(result)
  id = errorID + "SimscapeBlockNotFound";
  msg = CodeUtil1.i18n("Specified model does not have any Simscape blocks.");

  throw(MException(id, msg))

end  % if

if not(ismember(SimscapeBlockName, result.MaskType))
  id = errorID + "TargetBlockNotFound";
  msg = CodeUtil1.i18n("The specified block was not found in the specified model.");

  throw(MException(id, msg))

end  %if

ResultTable = result(result.MaskType==SimscapeBlockName, "BlockPath");

end  % function
