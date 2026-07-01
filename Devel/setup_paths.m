% Set up MATLAB path for developing Modeling Utility for Simscape.

% Copyright 2025-2026 The MathWorks, Inc.

% This folder must be added so that the namespace folder continues to be accessible
% even when the working folder is not this folder.
% Running unit test can change the working folder, and it needs this settings.
addpath(".")

addpath("mus-icons")

addpath(genpath("Test"))

addpath(genpath("AppsForPhysicalSystems"))
