function image3D = Load3D_im(filehead,digit,first,last,filetail)
%LOAD3D images Summary of this function goes here
%   Detailed explanation goes here
%
% 
image3D=[];
for frame=first:last
    
    images{frame} = imread([filehead, num2str(frame,digit),filetail]);
    image3D = cat(3, image3D, images{frame});
end

end

