% calculate Pe number
% viscosity: m*Pa*s  a,b(radii):um   U: um/s  T:K
  Pe = (600*pi*viscosity*a*b*U)/(1.3806*T)
  
% Plot figure in figure
errorbar(F(1,:),U3(1,1:12),err_U3(1,1:12),'s','MarkerSize', 10);
ylabel('<U> (\mum/s)','fontsize',14);
xlabel('F (pN)','fontsize',14)
axes('position', [0.6,0.25,0.20,0.30])
errorbar(Pe,U3(1,1:12),err_U3(1,1:12),'o');
xlabel('Peclet Number','fontsize',11)
ylabel('<U> (\mum/s)','fontsize',11);
hold on;
plot(Pe,0.00936*Pe-0.09408)

