function traj_frame(track,first,last,dt)
%TRAJ plots all the trajectories of track file
%   track=(x,y,frame #,ID)
figure
    for i=first:dt:last
       indices = find(track(:,3)==i);
       trajx=track(indices,1);
       trajy=track(indices,2);
       scatter(trajx,trajy,'.');
       pause   
    end
end

