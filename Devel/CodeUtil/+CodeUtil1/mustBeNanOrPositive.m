function mustBeNanOrPositive(a)

% Copyright 2026 The MathWorks, Inc.

% Calling ismatrix after isvector ensures that the value is not a vector.
if ~isscalar(a) && ~isvector(a) && ~ismatrix(a)
  % "Value" is used because mustBePositive and mustBeNonNan use it.
  id = "mustBeNanOrPositive:InvalidSize";
  msg = CodeUtil1.i18n("Value must be scalar, vector, or matrix.");

  throw(MException(id, msg))

end  % if

condition = isnan(a) | (a > 0);

% Calling ismatrix after isvector ensures that the value is not a vector.
if (isscalar(a) && ~condition) ...
    || (isvector(a) && ~all(condition)) ...
    || (ismatrix(a) && ~all(all(condition)))
  % "Value" is used because mustBePositive and mustBeNonNan use it.
  id = "mustBeNanOrPositive:InvalidValue";
  msg = CodeUtil1.i18n("Value must be nan or positive.");

  throw(MException(id, msg))

end  % if
end  % function
