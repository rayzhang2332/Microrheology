function out=cntrd_RZ(image,mx,diam)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         This code combines both Blair and Kilfoil's code together
%
%
%
% out=cntrd(im,mx,sz,interactive)
% 
% PURPOSE:  calculates the centroid of bright spots to sub-pixel accuracy.
%  Inspired by Grier & Crocker's feature for IDL, but greatly simplified and optimized
%  for matlab
% 
% INPUT:
% im: image to process, particle should be bright spots on dark background with little noise
%   ofen an bandpass filtered brightfield image or a nice fluorescent image
%
% mx: locations of local maxima to pixel-level accuracy from pkfnd.m
%
% sz: diamter of the window over which to average to calculate the centroid.  
%     should be big enough
%     to capture the whole particle but not so big that it captures others.  
%     if initial guess of center (from pkfnd) is far from the centroid, the
%     window will need to be larger than the particle size.  RECCOMMENDED
%     size is the long lengthscale used in bpass plus 2.
%    
%
% NOTE:
%  - if pkfnd, and cntrd return more then one location per particle then
%  you should try to filter your input more carefully.  If you still get
%  more than one peak for particle, use the optional sz parameter in pkfnd
%  - If you want sub-pixel accuracy, you need to have a lot of pixels in your window (sz>>1). 
%    To check for pixel bias, plot a histogram of the fractional parts of the resulting locations
%  - It is HIGHLY recommended to run in interactive mode to adjust the parameters before you
%    analyze a bunch of images.
%
% OUTPUT:  a N x 5 array containing, x, y and brightness for each feature
%           out(:,1) is the x-coordinates
%           out(:,2) is the y-coordinates
%           out(:,3) is the brightnesses
%           out(:,4) is the sqare of the radius of gyration
%           out(:,5) is the eccentricity
%
% CREATED: Eric R. Dufresne, Yale University, Feb 4 2005
%  5/2005 inputs diamter instead of radius
%  Modifications:
%  D.B. (6/05) Added code from imdist/dist to make this stand alone.
%  ERD (6/05) Increased frame of reject locations around edge to 1.5*sz
%  ERD 6/2005  By popular demand, 1. altered input to be formatted in x,y
%  space instead of row, column space  2. added forth column of output,
%  rg^2
%  ERD 8/05  Outputs had been shifted by [0.5,0.5] pixels.  No more!
%  ERD 8/24/05  Woops!  That last one was a red herring.  The real problem
%  is the "ringing" from the output of bpass.  I fixed bpass (see note),
%  and no longer need this kludge.  Also, made it quite nice if mx=[];
%  ERD 6/06  Added size and brightness output ot interactive mode.  Also 
%   fixed bug in calculation of rg^2
%  JWM 6/07  Small corrections to documentation 

if diam/2 == floor(diam/2)
warning('sz must be odd, like bpass');
end

if isempty(mx)==1
    warning('there were no positions inputted into cntrd. check your pkfnd theshold')
    out=[];
    return;
end


r=(diam-1)/2;
%create mask - window around trial location over which to calculate the centroid
if (mod(diam,2) == 0)
        disp('Requires an odd diameter.  Adding 1...');
        diam = diam + 1;
end
sz = size(image);
nx = sz(2);
ny = sz(1);
% if n_params() eq 2 then sep = extent+1
sep = diam; 


a=image;
% local maxima
logind = (mx(:,2) > 1.5*diam) & (mx(:,2) < ny-1.5*diam);
mx=mx(logind,:);
logind = (mx(:,1) > 1.5*diam) & (mx(:,1) < nx-1.5*diam);
mx=mx(logind,:);

x = mx(:,1);
y = mx(:,2);   % the pixel position of the maximum
nmax = length(x);
m = zeros(nmax,1);
xl = x - fix(diam/2);
xh = xl + diam -1;

% set up some masks
rsq = rsqd_RZ(diam,diam);
t = thetarr_RZ(diam);

mask = le(rsq,(diam/2)^2); %le() less than or equal to 
mask2 = ones(1,diam)'*[1:diam];
mask2 = mask2.*mask;
mask3 = (rsq.*mask) + (1/6);
cen = r+1;
% cmask = vpa(cos(sym('2')*t)).*mask;  
cmask = cos(2*t).*mask;
smask = sin(2*t).*mask;
cmask(cen,cen) = 0.0;
smask(cen,cen) = 0.0;

suba = zeros(diam,diam,nmax);
xmask = mask2;
ymask = mask2';
yl = y -fix(diam/2);
yh = yl + diam -1;
yscale = 1;
ycen = cen;

% Estimate the mass	
for i=1:nmax 
    m(i) = sum(sum(double(a(fix(yl(i)):fix(yh(i)),fix(xl(i)):fix(xh(i)))).*mask)); 
end

if nmax == 0 
    disp('No feature found!');
    out = [];
    return
end

% disp(strcat(num2str(nmax,'%01.0f'),' features found.'));

% Setup some result arrays
xc = zeros(nmax,1);
yc = zeros(nmax,1);
rg = zeros(nmax,1);
e  = zeros(nmax,1);

% Calculate feature centers
for i = 1:nmax
    xc(i) = sum(sum(double(a(fix(yl(i)):fix(yh(i)),fix(xl(i)):fix(xh(i)))).*xmask));  
    yc(i) = sum(sum(double(a(fix(yl(i)):fix(yh(i)),fix(xl(i)):fix(xh(i)))).*ymask));
end
x1 = x;
y1 = y;
%	Correct for the 'offset' of the centroid masks
xc = xc./m - ((diam+1)/2);             
yc =(yc./m - (diam+1)/2)/yscale;
%	Update the positions and correct for the width of the 'border'
x = x + xc - 0*fix(diam/2);
y = ( y + yc - 0*fix(diam/2) ) * yscale;
x2=x;
y2=y;

% Construct the subarray and calculate the mass, squared radius of gyration, eccentricity
 for i=1:nmax
    suba(:,:,i) = fracshift( double(a(fix(yl(i)):fix(yh(i)),fix(xl(i)):fix(xh(i)))), -xc(i) , -yc(i) );
    m(i) = sum(sum(( suba(:,:,i).*mask )));             % mass
    rg(i) = (sum(sum( suba(:,:,i).*mask3 ))) / m(i);    % squared radius of gyration
    tmp = sqrt(( (sum(sum( suba(:,:,i).*cmask )))^2 ) +( (sum(sum( suba(:,:,i).*smask )))^2 )); 
    tmp2 = (m(i)-suba(cen,ycen,i)+1e-6);
    e(i) = tmp/tmp2;                                    % eccentricity
 end

 for i=1:nmax
    xc(i) = sum(sum(double(suba(:,:,i)).*xmask));  
    yc(i) = sum(sum(double(suba(:,:,i)).*ymask));
 end
xc = xc./m - ((diam+1)/2);             
yc = (yc./m - (diam+1)/2)/yscale;  %get mass center
x3 = x2 + xc - 0*fix(diam/2);
y3 = ( y2 + yc - 0*fix(diam/2) ) * yscale;

out = [x3,y3,m,rg,e];

end



