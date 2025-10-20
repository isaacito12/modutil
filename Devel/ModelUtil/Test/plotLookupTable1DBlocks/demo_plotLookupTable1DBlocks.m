%[text] # plotLookupTable1DBlocks sample script
model_name = "testmodel_plotLookupTable1DBlocks_refsub";
load_system(model_name)
%[text] By default, all lookup table 1D blocks in the specified subsystem path are visualized.
ModelUtil1.plotLookupTable1DBlocks(model_name)
%[text] Use the `Blocks` option to specify the blocks for visualization.
fig = figure;
fig.Position(3:4) = [600 300];  % width height
ModelUtil1.plotLookupTable1DBlocks(model_name+"/Subsystem", Blocks=["PS smooth1" "SL smooth1"], ParentAxes=axes(fig))
%[text] Use the `SearchDepth` option to specify how many layers to search lookup table 1D blocks.
ModelUtil1.plotLookupTable1DBlocks(model_name+"/Subsystem/Subsystem A", SearchDepth=2)
%[text] *Copyright 2025 The MathWorks, Inc.*

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
