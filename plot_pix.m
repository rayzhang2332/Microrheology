function  plot_pix(x,y,size,color,shape)
% plot markers by pixels
% size = diameter
% color :  'r'......
% shape :  'o', '+'.......

switch shape
    case 'o'
        r = (size+1)/2;
        theta = 0:0.001:2*pi;
      % hold on;
        for i = 1:length(x)
            cx = x(i) + r*cos(theta);
            cy = y(i) + r*sin(theta);
            plot(cx,cy,color,'linewidth',0.5)
        end
      
    case '+'
        r=(size+1)/2;
        
        for i = 1:length(x)
           
            cx = ((x(i)-r):0.01:(x(i)+r));
            cy = ((y(i)-r):0.01:(y(i)+r));
            n=length(cx);
            x1 = x(i)*ones(n,1);
            y1 = y(i)*ones(n,1);
            plot(cx,y1,color,'linewidth',1)
            plot(x1,cy,color,'linewidth',1)
        end
            
end

