function App = mus1_FolderSearchApp(NameValuePair)
% App for searching a folder tree for the specified folder name.
%
% Open the app without any options and the app uses the default values.
%
%   mus1_FolderSearchApp
%
% Use search options to customize the app's initial states.
% Example:
%
%   mus1_FolderSearchApp(SearchFolderName="test-result", TopFolder=pwd)

% Copyright 2026 The MathWorks, Inc.

arguments (Input)
  NameValuePair.SearchFolderName (1,1) string = "test-result"
  NameValuePair.TopFolder (1,1) string {mustBeFolder} = pwd
end  % arguments

arguments (Output)
  App mus1.SearchUtil.FolderSearchAppMain {mustBeScalarOrEmpty}
end  % arguments

app_main = mus1.SearchUtil.FolderSearchAppMain( ...
  SearchFolderName = NameValuePair.SearchFolderName, ...
  TopFolder = NameValuePair.TopFolder );

app_main.Window.HeaderUI.AppSourceName = mfilename;

if nargout > 0
  App = app_main;
end  % if
end  % function
