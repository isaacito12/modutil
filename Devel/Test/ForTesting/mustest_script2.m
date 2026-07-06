% File for testing

% Copyright 2026 The MathWorks, Inc.

k = [0, 1/2, 1, 3/2, 2];

y = sin(k*pi);

% sinpi - Compute sin(X*pi) accurately
% https://www.mathworks.com/help/matlab/ref/double.sinpi.html
z = sinpi(k);
