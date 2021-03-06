function [fitresult, gof] = createFit(t, x3)
%CREATEFIT(T,X3)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : t
%      Y Output: x3
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 31-Jul-2018 09:34:39


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( t, x3 );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 1;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );



