function s = rsqd_RZ(w,h)
% produce a parabolic mask
% if n_params() eq 1 then h = w
%  s = zeros(w,h);
% I believe that the origial code made a mistake on column and row
% the IDL code is r2=fltarr(w,h), which w is column, and h is row.
% so, in matlab should be zeros(h,w)

s  = zeros(h,w);
xc = (w-1)/2;
yc = (h-1)/2;
x = (-xc:xc);
x = x.^2;
y = (-yc:yc);
y = y.^2;

% for j = 0, h-1 do begin  ** switched array start to 1
for j = 1:h,
	s(j,:) = x + y(j);
end
