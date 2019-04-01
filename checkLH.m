function checkLH(Ib,cnt,n,Low,Hi,ecce)
% br=3   radius=4,  ecce=5
%   Detailed explanation goes here

switch n
    case 3
     findI = find(cnt(:,n)>Hi | cnt(:,n)<Low);
     figure;colormap('gray'), imagesc(Ib); 
     set(gca,'YDir','normal'); 
     hold on;
     plot(cnt(findI,1),cnt(findI,2),'ro','MarkerSize',10,'LineWidth',0.5);
     num = length(findI);
     disp(['Cutting : ',num2str(num)])
    
    case 4
     findI = find(cnt(:,n)>Hi | cnt(:,n)<Low);
     figure;colormap('gray'), imagesc(Ib); 
     set(gca,'YDir','normal'); 
     hold on;
     plot(cnt(findI,1),cnt(findI,2),'ro','MarkerSize',10,'LineWidth',0.5);
     num = length(findI);
     disp(['Cutting : ',num2str(num)])
     
    case 5
        findI = find(cnt(:,n)>ecce);
        figure;colormap('gray'), imagesc(Ib); 
        set(gca,'YDir','normal'); 
        hold on;
        plot(cnt(findI,1),cnt(findI,2),'ro','MarkerSize',10,'LineWidth',0.5);
        num = length(findI);
        disp(['Cutting : ',num2str(num)])
    otherwise
        figure;
        histogram(cnt(:,5),300)
end

