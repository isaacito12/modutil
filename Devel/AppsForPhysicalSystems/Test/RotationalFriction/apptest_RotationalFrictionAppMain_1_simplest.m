function App = apptest_RotationalFrictionAppMain_1_simplest

% Copyright 2025 The MathWorks, Inc.

arguments (Output)
  App (:,1) struct
end  % arguments

app_main = RotationalFriction1.RotationalFrictionAppMain;

if nargout > 0
  App = app_main;
end  % if
end  % function
