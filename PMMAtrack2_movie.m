function PMMAtrack2_movie(filehead,digit,first,last,feature,sigma,br,lnoise,radiuscutL,radiuscutH,IcutL,IcutH,ecut)

if mod(feature,2) == 0
     warning('feature size must be an odd value');
     pos_lst=[];
     return;
end

for frame=first:25:last
    
    image = imread([filehead, num2str(frame,digit),'.tif']);
    image = flipud(image);
    if sigma == 'disable'
        % do nothing
    else
       image = imgaussfilt(image,sigma);
    % Bandpass filter
    end
    
    imagebp = bpass(image,lnoise,feature);
    
    pk = pkfnd(imagebp,br,feature);
    cnt = cntrd_RZ(imagebp, pk, feature+2);
   
    findI = find(cnt(:,3)>IcutH | cnt(:,3)<IcutL);
    findR = find(cnt(:,4)>radiuscutH | cnt(:,4)<radiuscutL);
    findE = find(cnt(:,5)>ecut);
    delete=[];
    delete = [findI;findR;findE];
    delete = unique(delete);
    cnt(delete,:)=[]; 
    
    colormap('gray'), imagesc(imagebp);
    set(gca,'YDir','normal');
    axis equal;
    hold on;
    plot(cnt(:,1),cnt(:,2),'ro','MarkerSize',10,'LineWidth',0.5);
    hold off;
    title(['Frame number: ' num2str(frame)],'fontweight','bold','Fontsize',18,'color','b');
    pause
end
