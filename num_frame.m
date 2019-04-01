function out = num_frame(track,type)
% give you particle number at each frame
% poslist type = 1
% track   type = 2

if type == 1
    n = 6;
elseif type == 2
    n = 3;
end

L=track(end,n);
out=zeros(L,2);
out(:,1)=(1:L)';
parfor i=1:L
      indice = find(track(:,n)==i);
      out(i,2) = numel(indice);
end

% plot(out(:,1),out(:,2))

end

