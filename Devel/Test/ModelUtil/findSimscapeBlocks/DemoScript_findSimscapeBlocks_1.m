%% Demo script
% Run this script to see what the target function returns.

% Copyright 2026 The MathWorks, Inc.

block_paths = mus1.ModelUtil.findSimscapeBlocks("DemoModel_findSimscapeBlocks_1_24b", "Mass");
disp(block_paths)

block_paths = mus1.ModelUtil.findSimscapeBlocks("DemoModel_findSimscapeBlocks_1_24b", ["Mass", "PS Ramp"]);
disp(block_paths)

block_paths = mus1.ModelUtil.findSimscapeBlocks("DemoModel_findSimscapeBlocks_1_24b", ["Mass", "PS Ramp", "Demo component"]);
disp(block_paths)
