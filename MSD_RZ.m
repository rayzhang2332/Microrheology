function MSD = MSD_RZ(data,column)
%MSD_RZ Summary of this function goes here
%   Detailed explanation goes here

L = length(data);
X = zeros(2990,L);

for i =1:L
    temp = data{i};
    L2 = length(temp);
    
    if L2 < 2990
        N = NaN(2990-L2,3);
        temp = [temp;N];
    end
        
    X(:,i) = temp(:,column);
end

aveX = nanmean(X,2);
Xp = bsxfun(@minus,X,aveX);
Xpsq = Xp.^2;
MSD = nanmean(Xpsq,2);
end

