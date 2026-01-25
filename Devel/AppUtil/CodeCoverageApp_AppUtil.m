function App = CodeCoverageApp_AppUtil(TopFolder)

arguments (Input)
  TopFolder (1,1) string = "C:\local\modutil\modeling-utility"
end  % arguments

arguments (Output)
  App
end  % arguments

coverage_file_fullpath = fullfile(TopFolder, "Devel", "AppUtil", "test-result", "code-coverage.xml");

coverage_app = CodeCoverageApp(coverage_file_fullpath);

if nargout > 0
  App = coverage_app;
end  % if
end  % function
