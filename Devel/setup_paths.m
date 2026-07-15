function setup_paths(keyword)
% Set up MATLAB path for developing Modeling Utility for Simscape.
%
% Usage:
%   setup_paths           % loads mus1 (default)
%   setup_paths("mus2")   % loads mus2

% Copyright 2025-2026 The MathWorks, Inc.

arguments
  keyword (1,1) string = "mus1"
end

% This folder must be added so that the namespace folder continues to be accessible
% even when the working folder is not this folder.
% Running unit test can change the working folder, and it needs this settings.
addpath(".")

addpath(genpath("AppsForModeling"))
addpath(genpath("AppsForPhysicalSystems"))
addpath(genpath("BasicApps"))
addpath("mus-icons")
addpath(genpath("Test"))

end  % function
