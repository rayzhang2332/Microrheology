function out = cutbead(bead,tr,first,last,dist)
tic
delete=[];
vector = (first:last);

for i = 1:length(vector)
    frame = vector(i);
    ind(i) = find(bead(:,3)==frame);
    ind_tr{i} = find(tr(:,3) == frame);
end


for j = 1:length(ind)
       BX = bead(ind(j),1);
       BY = bead(ind(j),2);  % find bead's location
       Left = BX-dist;
       Right = BX+dist;
       Up = BY+dist;
       Low = BY-dist;      % find cutting area
       
       B = ind_tr{j};   % Beads in this frame
       findX = find(tr(:,1)>Left & tr(:,1)<Right);
       findY = find(tr(:,2)>Low &  tr(:,2)<Up);
       temp = intersect(B,findX);  
       temp = intersect(temp,findY); % cutting points in this frame
       delete = [delete;temp];
end

tr(delete,:)=[];

out = tr;

toc
end

