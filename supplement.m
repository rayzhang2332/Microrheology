% some useful codes

%% Step 1. Pre-Tracking bead
I1 = imread();
I1i = 65535 - I1;
Ib = bpass(I1i,5,57);


max(max(Ib1))
colormap('gray'), imagesc(Ib);

pk = pkfnd(Ib,100,57);
cnt = cntrd_RZ(Ib,pk,59);

% After get all the parameter, use Beadtrack_movie() to check
Beadtrack_movie(filehead,'%04u',1,3000,57,100,5,MarkerSize,mode)

% If everything is good, then go to the tracking step
Bposlist = Btrack(filehead,'%04u',1,3000,57,100,5); 

% Check for pixel bias
hist(mod(poslist(:,1),1),20);
title('bias check for x-positions');
figure;
hist(mod(poslist(:,2),1),20);
title('bias check for y-positions');
% the command produces a histogram of the x-position modulo 1. The histogram should look flat, which ensures there is no bias in the
% position correction. A common failure is to have peaks in the histogram near 0 and 1 and a dip at 0.5. This pattern appears 
% when the feature size is made too small, causing the x- and y-coordinates to round off to the nearest integer value.

Bparam = struct('mem',0,'good',1000,'dim',2,'quiet',0);
Bpos = Bposlist(:,[1:2,6]);
Btrack = track(pos,1000,param);

Otraj = [Btrack(:,1) Btrack(:,2)];
Otraj(:,1) = Otraj(:,1) - Otraj(1,1);
Otraj(:,2) = Otraj(:,2) - Otraj(1,2);
scatter(Otraj(:,1),Otraj(:,2),'.');
axis equal

% Because the magnet is not perfectly aligned. Therefore, at this moment, we need to fit the trajectory to get the angle of the force.
% use polyfit(x,y,1) is not good idea since the linear fit must pass through orgin.

dlm = fitlm(Otraj(:,1),Otraj(:,2),'Intercept',false); % linear fit to data with intercept at origin
dlm = fitlm(Otraj(:,1),Otraj(:,2),'y~x1-1') % Wilkinson Notation, this allows you to fit models and specify the form of the equation you would like to fit
angle = atand()
string = sprintf('Angle = %0.4f degree', angle);
text(200,300,string, 'FontSize', 20, 'Color', 'r');

save('D:\Google Drive SJU\MicroRheology 2018 Summer\Calibration\Pe = 0\92 tracking\92 workspace.mat');
savefig('D:\Google Drive SJU\MicroRheology 2018 Summer\Calibration\Pe = 0\92 tracking\92 Otraj.fig');
print('D:\Google Drive SJU\MicroRheology 2018 Summer\Calibration\Pe = 0\92 tracking\92 Otraj','-dpng');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Step 2. Tracking PMMAs    	
  
 I1 = flipud(I1); I2 = flipud(I2);
 figure; colormap('gray'), imagesc(I1);set(gca,'YDir','normal');
  
 Ig = imgaussfilt(I,sigma);

% bpass
  Ib = bpass(I1,1,23);	
   
  max(max(Ib))
  % imshow(I,[low high]) displays the grayscale image I, specifying the display range as a two-element vector, [low high]. 
  % or colormap('gray'),image(Ib);

  pk = pkfnd(Ib,5,23);
  cnt = cntrd_RZ(Ib,pk,25);
  figure;colormap('gray'), imagesc(Ib); set(gca,'YDir','normal'); hold on;
  plot(cnt(:,1),cnt(:,2),'ro','MarkerSize',10,'LineWidth',0.5);
  
  %% plot the radius of gyration vs. brightness to find masscut value
      figure;plot(cnt(:,3),cnt(:,4),'.')
      yticks([10 20 30 32 35 40 50 60 70 80]);
      xticks([500 1000 1500 2000 3000 5000 7000 8000]);grid on;
      
      findI = find(cnt(:,3)>IcutH | cnt(:,3)<IcutL);
      findR = find(cnt(:,4)>radiuscutH | cnt(:,4)<radiuscutL);

      figure;histogram(cnt(:,5),300)
      
      delete=[];
      delete = [findI;findR];
      delete = unique(delete);
      cnt1=cnt;
      cnt1(delete,:)=[]; 


  PMMAtrack_movie('G:\2018\0.3\b1p0\b1p0_T','%04u',11,3000,23,7,2,30,55,0,6000);

  poslist = PMMAtrack2('G:\2018\0.3\b1p1\b1p1_T','%04u',11,3000,23,7,2,35,70,0,5500);
  
  % check for pixel bias
  hist(mod(poslist(:,1),1),20);
  title('bias check for x-positions');
  figure;
  hist(mod(poslist(:,2),1),20);
  title('bias check for y-positions');
  
                                    %check if there are NaNs
                                      TF = isnan(a);
                                      findna=find(TF==1);

  
% set the parameters
  param = struct('mem',0,'good',20,'dim',2,'quiet',0);
% track the PMMAs  
  pos = poslist(:,[1:2,6]);
  track = track(pos,10,param);

                                    % use motin function to find drift
                                      result=motion(track,[1,0], 2);

                                    % may useful
                                      resultdf = result(:,1)'
                                      find = 0:964;
                                      dff = setdiff(find,resultdf);

                                    % integrate the dx & dy without cutting the bead
                                       result=[0 0 0 0;result];
  
                                       n = length(result(:,1))
                                       res = zeros(n,4);
                                      for i = 2:n
                                           res(i,3) = res(i-1,3)+result(i,3);
                                           res(i,4) = res(i-1,4)+result(i,4);
                                      end
% open the 1st and the last image to find cutting area.
  I1 = importdata('G:\2018\0.3\b1p0\b1p0_T0011.tif'); 
  I2 = importdata('G:\2018\0.3\b1p0\b1p0_T3000.tif');
  I1 = flipud(I1);  I2 = flipud(I2);
  colormap('gray');imagesc(I1);set(gca,'YDir','normal');grid on; 
  
%cutting one direction
findX = find(track(:,1)>550 & track(:,1)<850); %find the 550<x-axis<800
IDd = track(findX,4);
IDd = unique(IDd); %find the IDs which need to be delete
track1 = track;
for i1 = 1:length(IDd)
  iddelete = IDd(i1);
  findid = find(track1(:,4)==iddelete);
  findid = findid';
  track1(findid,:) = [];
end

% cut both X and Y
findX = find(track(:,1)>650 & track(:,1)<950); findY = find(track(:,2)>450 & track(:,2)<650);
IDX = track(findX,4); IDY = track(findY,4);  ID=intersect(IDX,IDY);        %intersect() returns the data common to both A and B, with no repetitions. C is in sorted order.
delete=[];
for i = 1:length(ID)
  findid = find(track(:,4)==ID(i));
  delete = [delete;findid];
end
track1=track; track1(delete,:)=[];

%calculate drift
result1=motion(track1,[1,0], 2);

result1=[0 0 0 0;result1];
n = length(result1(:,1))
res1 = zeros(n,4);
for i2 = 2:n
res1(i2,3) = res1(i2-1,3)+result1(i2,3);
res1(i2,4) = res1(i2-1,4)+result1(i2,4);
end

% get time & drift
t = a(:,1)-a(1,1); xd = res1(:,3); yd = res1(:,4);

%then use toolbox
xdrift = fittedmodelx(t);
ydrift = fittedmodely(t);
scatter(t,xd,'.b');
hold on;
scatter(t,yd,'.r');
hold on;
plot(t,xdrift,'b',t,ydrift,'r');
legend({'X-drift','Y-drift'},'Fontsize',14);
title('X-drift & Y-drift','Fontsize',14);

x = a(:,2)-xdrift;
y = a(:,3)-ydrift;
x = x-x(1); y = y-y(1); 
xo = a(:,2)-a(1,2);
yo = a(:,3)-a(1,3);
[v,x3,y3] = dedrift_velocity(t,x,y,xo,yo,theta);
title('1210 velocity','Fontsize',14);

title('1210 traj.','Fontsize',14);

a1=[t x3 y3];
print('D:\Google Drive SJU\Microrheology 2018\0.1\Pe=264 (0 degree, 9)\Plots 1345\1345 U','-dpng');
save('D:\Google Drive SJU\Microrheology 2018\0.1\Pe=264 (0 degree, 9)\Plots 1345\1345 workspace.mat');
%save txt. file
path = 'D:\Google Drive SJU\Microrheology 2018\0.1\Pe=264 (0 degree, 9)';
filename = '0.1_9_1345_fit.txt';
file = [path filesep filename];
save(file,'a1345','-ascii');  

filename1 = '0.1_9_1345_dedrift.txt';
file1 = [path filesep filename1];
save(file1, 'a1', '-ascii');

%seb msd
[t,m]=seb_msd('tracksCell',tracks,'dim',2);


%Furst msd

xlabel('Frame','Fontsize',14)
ylabel('MSD (\mum^2)','Fontsize',14)
title('\phi=0.2 MSD Vs. Frame','Fontsize',14)
    
string1 = sprintf('Angle = %0.2f degree', angle);
text(20,50,string1);

loglog(msd0(:,1),msd0(:,2),msd1(:,1),msd1(:,2),msd2(:,1),msd2(:,2));
% fit dt=0.2s
a=importdata('0.3_1_1158_dedrift.txt');
t=a(:,1);x=a(:,2);y=a(:,3);
for i=1:1:length(t)-1
     dt(i)=t(i+1)-t(i);
end
dt=dt';  dt=[0;dt];
 mean(dt)
tfit=[0:0.2:282.6]';

xfit=fittedmodelx(tfit);
yfit=fittedmodely(tfit);

a1161=[tfit xfit yfit];
[v] = velocity_fit(tfit,xfit,yfit)