function mustBeSimscapeValuePositive(x)

% Copyright 2024-2025 The MathWorks, Inc.

% To avoid a confluence of error messages, custom validation functions
% must avoid using function argument validation.

if value(x) <= 0
  id = "mustBeSimscapeValuePositive:NotPositive";
  msg = CodeUtil1.i18n("Value must be positive.");

  throw(MException(id, msg))

end  % if
end  % function
