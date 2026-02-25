function App = AppTest_SignalDesignAppMain()
% This is a testing version of the SignalDesignApp.
% BlockPath option is used to link the app to the specified block.

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Output)
  App SignalUtil1.SignalDesignAppMain {mustBeScalarOrEmpty}
end  % arguments

if isMATLABReleaseOlderThan("R2025a")
  block_path = "SampleModel_SignalDesignAppMain_24b/PS Lookup Table (1D)";
else
  block_path = "SampleModel_SignalDesignAppMain/PS Lookup Table (1D)";
end  % if

app_main = SignalUtil1.SignalDesignAppMain(BlockPath=block_path);

app_main.Window.HeaderUI.AppSourceName = mfilename;

if nargout > 0
  App = app_main;
end  % if
end  % function
