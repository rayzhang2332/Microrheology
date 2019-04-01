t1=a1(:,1); t2=a2(:,1); t3=a3(:,1);y1=a1(:,3); y2=a2(:,3); y3=a3(:,3);x1=a1(:,2); x2=a2(:,2); x3=a3(:,2);

dy1=y1(2:end)-y1(1:end-1);dy2=y2(2:end)-y2(1:end-1);dy3=y3(2:end)-y3(1:end-1);dt1=t1(2:end)-t1(1:end-1);dt2=t2(2:end)-t2(1:end-1);dt3=t3(2:end)-t3(1:end-1);

fit1=polyfit(t1,y1,1);fit2=polyfit(t2,y2,1);fit3=polyfit(t3,y3,1);

mean1=fit1(1);mean2=fit2(1);mean3=fit3(1);

u1=dy1./dt1;u2=dy2./dt2;u3=dy3./dt3;

squ1p=(u1-mean1).^2;squ2p=(u2-mean2).^2;squ3p=(u3-mean3).^2;    %square x'

squp=cat(1,squ1p,squ2p,squ3p);  %put togethermean(squp)     
mean(squp)
%get average x velocity flucation
dx1=x1(2:end)-x1(1:end-1);dx2=x2(2:end)-x2(1:end-1);dx3=x3(2:end)-x3(1:end-1);
ux1=dx1./dt1;ux2=dx2./dt2;ux3=dx3./dt3;

squx1=ux1.^2;squx2=ux2.^2;squx3=ux3.^2;
squx=cat(1,squx1,squx2,squx3);  
mean(squx)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%For 4 traj.
t1=a1(:,1); t2=a2(:,1); t3=a3(:,1); t4=a4(:,1);
y1=a1(:,3); y2=a2(:,3); y3=a3(:,3); y4=a4(:,3);
x1=a1(:,2); x2=a2(:,2); x3=a3(:,2); x4=a4(:,2);

dy1=y1(2:end)-y1(1:end-1); dy2=y2(2:end)-y2(1:end-1); dy3=y3(2:end)-y3(1:end-1); dy4=y4(2:end)-y4(1:end-1);
dt1=t1(2:end)-t1(1:end-1); dt2=t2(2:end)-t2(1:end-1); dt3=t3(2:end)-t3(1:end-1); dt4=t4(2:end)-t4(1:end-1);

fit1=polyfit(t1,y1,1); fit2=polyfit(t2,y2,1); fit3=polyfit(t3,y3,1); fit4=polyfit(t4,y4,1);
mean1=fit1(1); mean2=fit2(1); mean3=fit3(1); mean4=fit4(1);

u1=dy1./dt1; u2=dy2./dt2; u3=dy3./dt3; u4=dy4./dt4;

squ1p=(u1-mean1).^2; squ2p=(u2-mean2).^2; squ3p=(u3-mean3).^2; squ4p=(u4-mean4).^2; %square x'

squp=cat(1,squ1p,squ2p,squ3p,squ4p);  %put together
mean(squp)

dx1=x1(2:end)-x1(1:end-1);dx2=x2(2:end)-x2(1:end-1);dx3=x3(2:end)-x3(1:end-1);dx4=x4(2:end)-x4(1:end-1);
ux1=dx1./dt1; ux2=dx2./dt2; ux3=dx3./dt3; ux4=dx4./dt4;

squx1=ux1.^2; squx2=ux2.^2; squx3=ux3.^2; squx4=ux4.^2;
squx=cat(1,squx1,squx2,squx3,squx4);  
mean(squx)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1=importdata('0.1_0_1294_dedrift.txt');
a2=importdata('0.1_0_1309_dedrift.txt');
a3=importdata('0.1_0_1317_dedrift.txt');
a4=importdata('0.1_0_1324_dedrift.txt');a5=importdata('0.1_0_1329_dedrift.txt');
t1=a1(:,1); t2=a2(:,1); t3=a3(:,1); t4=a4(:,1);t5=a5(:,1);
y1=a1(:,3); y2=a2(:,3); y3=a3(:,3); y4=a4(:,3);y5=a5(:,3);
x1=a1(:,2); x2=a2(:,2); x3=a3(:,2); x4=a4(:,2);x5=a5(:,2);
dy1=y1(2:end)-y1(1:end-1); dy2=y2(2:end)-y2(1:end-1); dy3=y3(2:end)-y3(1:end-1); dy4=y4(2:end)-y4(1:end-1);dy5=y5(2:end)-y5(1:end-1);
dt1=t1(2:end)-t1(1:end-1); dt2=t2(2:end)-t2(1:end-1); dt3=t3(2:end)-t3(1:end-1); dt4=t4(2:end)-t4(1:end-1);dt5=t5(2:end)-t5(1:end-1);
fit1=polyfit(t1,y1,1); fit2=polyfit(t2,y2,1); fit3=polyfit(t3,y3,1); fit4=polyfit(t4,y4,1);fit5=polyfit(t5,y5,1);
mean1=fit1(1); mean2=fit2(1); mean3=fit3(1); mean4=fit4(1);mean5=fit5(1);
u1=dy1./dt1; u2=dy2./dt2; u3=dy3./dt3; u4=dy4./dt4;u5=dy5./dt5;
squ1p=(u1-mean1).^2; squ2p=(u2-mean2).^2; squ3p=(u3-mean3).^2; squ4p=(u4-mean4).^2; squ5p=(u5-mean5).^2;
squp=cat(1,squ1p,squ2p,squ3p,squ4p,squ5p);
mean(squp)

dx1=x1(2:end)-x1(1:end-1);dx2=x2(2:end)-x2(1:end-1);dx3=x3(2:end)-x3(1:end-1);dx4=x4(2:end)-x4(1:end-1);dx5=x5(2:end)-x5(1:end-1);
ux1=dx1./dt1; ux2=dx2./dt2; ux3=dx3./dt3; ux4=dx4./dt4;ux5=dx5./dt5;
squx1=ux1.^2; squx2=ux2.^2; squx3=ux3.^2; squx4=ux4.^2;squx5=ux5.^2;
squx=cat(1,squx1,squx2,squx3,squx4,squx5);
mean(squx)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a1=importdata('0.2_9.5_1208_dedrift.txt');
a2=importdata('0.2_9.5_1261_dedrift.txt');
a3=importdata('0.2_9.5_1263_dedrift.txt');
a4=importdata('0.2_9.5_1264_dedrift.txt');
a5=importdata('0.2_9.5_1265_dedrift.txt');
a6=importdata('0.2_9.5_1266_dedrift.txt');
a7=importdata('0.2_9.5_1267_dedrift.txt');
t1=a1(:,1); t2=a2(:,1); t3=a3(:,1); t4=a4(:,1);t5=a5(:,1);t6=a6(:,1);t7=a7(:,1);
y1=a1(:,3); y2=a2(:,3); y3=a3(:,3); y4=a4(:,3);y5=a5(:,3);y6=a6(:,3);y7=a7(:,3);
x1=a1(:,2); x2=a2(:,2); x3=a3(:,2); x4=a4(:,2);x5=a5(:,2);x6=a6(:,2);x7=a7(:,2);
dy1=y1(2:end)-y1(1:end-1); dy2=y2(2:end)-y2(1:end-1); dy3=y3(2:end)-y3(1:end-1); dy4=y4(2:end)-y4(1:end-1);dy5=y5(2:end)-y5(1:end-1);dy6=y6(2:end)-y6(1:end-1);dy7=y7(2:end)-y7(1:end-1);
dt1=t1(2:end)-t1(1:end-1); dt2=t2(2:end)-t2(1:end-1); dt3=t3(2:end)-t3(1:end-1); dt4=t4(2:end)-t4(1:end-1);dt5=t5(2:end)-t5(1:end-1);dt6=t6(2:end)-t6(1:end-1);dt7=t7(2:end)-t7(1:end-1);
fit1=polyfit(t1,y1,1); fit2=polyfit(t2,y2,1); fit3=polyfit(t3,y3,1); fit4=polyfit(t4,y4,1);fit5=polyfit(t5,y5,1);fit6=polyfit(t6,y6,1);fit7=polyfit(t7,y7,1);
mean1=fit1(1); mean2=fit2(1); mean3=fit3(1); mean4=fit4(1);mean5=fit5(1);mean6=fit6(1);mean7=fit7(1);
u1=dy1./dt1; u2=dy2./dt2; u3=dy3./dt3; u4=dy4./dt4;u5=dy5./dt5;u6=dy6./dt6;u7=dy7./dt7;
squ1p=(u1-mean1).^2; squ2p=(u2-mean2).^2; squ3p=(u3-mean3).^2; squ4p=(u4-mean4).^2; squ5p=(u5-mean5).^2;squ6p=(u6-mean6).^2;squ7p=(u7-mean7).^2;
squp=cat(1,squ1p,squ2p,squ3p,squ4p,squ5p,squ6p,squ7p);  %put together
mean(squp)

dx1=x1(2:end)-x1(1:end-1);dx2=x2(2:end)-x2(1:end-1);dx3=x3(2:end)-x3(1:end-1);dx4=x4(2:end)-x4(1:end-1);dx5=x5(2:end)-x5(1:end-1);dx6=x6(2:end)-x6(1:end-1);dx7=x7(2:end)-x7(1:end-1);
ux1=dx1./dt1; ux2=dx2./dt2; ux3=dx3./dt3; ux4=dx4./dt4;ux5=dx5./dt5;ux6=dx6./dt6;ux7=dx7./dt7;
squx1=ux1.^2; squx2=ux2.^2; squx3=ux3.^2; squx4=ux4.^2;squx5=ux5.^2;squx6=ux6.^2;squx7=ux7.^2;
squx=cat(1,squx1,squx2,squx3,squx4,squx5,squx6,squx7);
mean(squx)
