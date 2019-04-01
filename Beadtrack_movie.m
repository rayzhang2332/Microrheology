function Beadtrack_movie(filehead,digit,first,last,feature,br,lnoise,mode,MarkerSize,dframe,ptime)

if nargin<11, ptime=0.25; end

for frame=first:dframe:last
    
    image = imread([filehead, num2str(frame,digit),'.tif']);
    image = flipud(image);
    image1 = 65535 - image;
    imagebp = bpass(image1,lnoise,feature);
    
    pk = pkfnd(imagebp,br,feature);
    cnt = cntrd_RZ(imagebp, pk, feature+2);
    
    colormap('gray'), imagesc(image);
    title(['Frame number: ' num2str(frame)],'fontweight','bold','Fontsize',18,'color','b');
    set(gca,'YDir','normal');
    axis equal;
    hold on;
    if mode == 0
        plot_pix(cnt(:,1),cnt(:,2),MarkerSize,'r','o')
        hold off;
        pause
    elseif mode == 1
            plot_pix(cnt(:,1),cnt(:,2),MarkerSize,'r','o')
            hold off;
            pause(ptime)
    end           
end