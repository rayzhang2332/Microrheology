 function pos_lst=Ftrack(filehead,first,last,feature,threshold)
% out=cntrd(im,mx,sz,interactive)
%
%PURPOSE
%           For each image in a directory
%              Read image file
%                Filter the image
%                Find brightest pixels
%                Find pixel centroids
%                Concatenate positions to pos_lst
%
%INPUT:
%filehead: A string common to the image file names
%          i.e. we assume that the filename is of the form ’framexxxx.tif’
%
%start: First frame to read
% end: Final frame to read
%
%feature: Expected size of the particle (diameter)
%
%NOTES:
%
%OUTPUTS:
%
%CREATED: Eric M. Furst, University of Delaware, July 23, 2013
% Modifications:

if mod(feature,2) == 0
     warning('feature size must be an odd value');
     out=[];
     return;
end

pos_lst=[];
for frame=first:last
    
    if mod(frame,50)==0
        disp(['Frame number: ' num2str(frame)]);
    end
    
    % read in file
    image = double(imread([filehead, num2str(frame,'%03u'),'.tif']));
  
    % Bandpass filter
    imagebp = bpass(image,1,feature);
    
    % Find locations of the brightest pixels Need to change the 'th'
    % (threshold) argument to something that is specified or determined.
    % Current value is 8000. A rough guide is 0.6*max(imagebp(:))
    pk = pkfnd(imagebp,threshold,feature);
    % Refine location estimates using centroid
    cnt = cntrd(imagebp, pk, feature+2);
    % cntrd can also accept "interactive" mode
    % cnt = cntrd(imagebp, pk, feature+2, 1);
    
    % Add frame number to tracking data. Use 0 as the reference frame.
    cnt(:,5) = frame;
    
    % Concatenate the new frame to the existing data
    pos_lst = [pos_lst, cnt'];
    
end

% Format the position list so that we have four columns: x, y, m_0, m_2, frame
pos_lst = pos_lst';

% It’s better to separate the particle tracking from the trajectory
% analysis. Once the particles are located in each frame, we can re-run the
%trajectory anslysis using different parameters.
%
% After generating the unsorted position lists, run track.m to generate the
% particle trajectories. The routine takes the following input:
% For the input data structure (positionlist):
%        (x)       (y)    (t)
% pos = 3.60000 5.00000 0.00000
%       15.1000 22.6000 0.00000
%       4.10000 5.50000 1.00000
%       15.9000 20.7000 2.00000
%       6.20000 4.30000 2.00000
%
%     Use the command:
% trajectories = track([pos_lst(:,1:2),pos_lst(:,5)],10);
