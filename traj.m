function traj(track,first,last)
%TRAJ plots all the trajectories of track file
%   track=(x,y,frame #,ID)
figure
    for i=first:last
       indices = find(track(:,4)==i);
       trajx=track(indices,1);
       trajy=track(indices,2);
       scatter(trajx,trajy,'.');
       hold on;
    end
end

