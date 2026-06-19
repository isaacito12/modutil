function App = FolderSearchApp(NameValuePair)
% App for searching a folder tree for the specified folder name.
%
% Open the app without any options and the app uses the default values.
%
%   FolderSearchApp
%
% Use search options to customize the app's initial states.
<<<<<<< HEAD
% Example:
%
%   FolderSearchApp(SearchFolderName="test-result", TopFolder=pwd)
=======
% See the NameValuePair options in the code below for available options.
% Example:
%
%   FolderSearchApp(SearchFolderName=".buildtool", TopFolder=pwd)
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3

% Copyright 2026 The MathWorks, Inc.

arguments (Input)
<<<<<<< HEAD
  NameValuePair.SearchFolderName (1,1) string = "test-result"
=======
  NameValuePair.SearchFolderName (1,1) string = ".buildtool"
>>>>>>> 49b1b055ff90fc90884c7bbae6cf7b0543850ed3
  NameValuePair.TopFolder (1,1) string {mustBeFolder} = pwd
end  % arguments

arguments (Output)
  App SearchUtil1.FolderSearchAppMain {mustBeScalarOrEmpty}
end  % arguments

app_main = SearchUtil1.FolderSearchAppMain( ...
  SearchFolderName = NameValuePair.SearchFolderName, ...
  TopFolder = NameValuePair.TopFolder );

app_main.Window.HeaderUI.AppSourceName = mfilename;

if nargout > 0
  App = app_main;
end  % if
end  % function
