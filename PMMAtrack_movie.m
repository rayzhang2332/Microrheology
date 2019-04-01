function PMMAtrack_movie(filehead,digit,first,last,feature,br,lnoise,radiuscutL)

for frame=first:last
    
    image = imread([filehead, num2str(frame,digit),'.tif']);
    image = flipud(image);
    
    imagebp = bpass(image,lnoise,feature);
    
    pk = pkfnd(imagebp,br,feature);
    cnt = cntrd(imagebp, pk, feature+2);
   
    findR = find(cnt(:,4)<radiuscutL);
    cnt(findR,:)=[];
    
    colormap('gray'), imagesc(imagebp);
    set(gca,'YDir','normal');
    axis equal;
    hold on;
    plot(cnt(:,1),cnt(:,2),'ro','MarkerSize',10,'LineWidth',0.5);
   
    hold off;
    title(['Frame number: ' num2str(frame)]);
    pause
end