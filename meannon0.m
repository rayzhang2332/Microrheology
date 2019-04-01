function mean = meannon0(A)
% Purpose: calculates the mean of non-zero elements of a matrix. We can use this to calculate
%          average intensity of a bandpass image.

s = sum(A(:));  % calculate the sum of the matrix
num = sum(A(:)~=0); % calculate how many non-zero elements in the matrix.
                    % this is not calculate the sum.
mean = s/num;