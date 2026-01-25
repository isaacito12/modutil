function App = apptest_RotationalFrictionApp_1_simplest

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

app_main = RotationalFrictionApp;

if nargout > 0
  App = app_main;
end  % if
end  % function
