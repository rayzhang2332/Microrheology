function out = Ibcheck(image,sigma,lnoise,size)
%IBCHECK Summary of this function goes here
%   Detailed explanation goes here

Ig = imgaussfilt(image,sigma);
out = bpass(Ig,lnoise,size);
figure;
colormap('gray'), imagesc(out);set(gca,'YDir','normal');

end

