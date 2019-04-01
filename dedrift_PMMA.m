function out =  dedrift_PMMA(track,driftx,drifty)
%If there is no drift, put 'false'
out = track;
Tn = unique(track(:,4));

while driftx == 'false'
       driftx=zeros(track(end,3),1);
end

while drifty == 'false'
       drifty=zeros(track(end,3),1);
end
  
for i=1:length(Tn)
        indice = find(track(:,4)==Tn(i));
        frame = track(indice,3);
   
        out(indice,1)= out(indice,1)-(driftx(frame)-driftx(frame(1)));
        out(indice,2)= out(indice,2)-(drifty(frame)-drifty(frame(1)));
end
 

