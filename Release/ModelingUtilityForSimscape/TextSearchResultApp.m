function App = TextSearchResultApp(Searcher, NameValuePair)
% App for viewing the result of text search.
%
% TextSearchApp uses this app to show the search result. You can also open this app
% programmatically. The app takes a TextSearcher object and optionally a search result.
%
% To programmatically open the app, use the mus1.SearchUtil.searchText to do a text search.
%
%   session = mus1.SearchUtil.searchText("Copyright", FileTypes="*.m", TargetFolder=pwd);
%
% Then, pass the return value from the search to the app as follows.
%
%   TextSearchResultApp(session.Searcher, SearchResult = session.Result)
%
% If the SearchResult option is not used, the app first runs a search using
% the provided searcher and shows the result.
%
% Running this app without any arguments sets up a default searcher, runs a search,
% and shows the result.

% Copyright 2025-2026 The MathWorks, Inc.

arguments (Input)
  Searcher mus1.SearchUtil.TextSearcher = mus1.SearchUtil.TextSearcher(Initialization="default")
  NameValuePair.SearchResult table
end  % arguments

arguments (Output)
  App mus1.SearchUtil.TextSearchResultAppMain {mustBeScalarOrEmpty}
end  % arguments

if isfield(NameValuePair, "SearchResult")
  result = NameValuePair.SearchResult;
else
  result = runSearch(Searcher);
end  % if

app_main = mus1.SearchUtil.TextSearchResultAppMain(Searcher, SearchResult = result);

app_main.Window.HeaderUI.AppSourceName = mfilename;

if nargout > 0
  App = app_main;
end  % if
end  % function
