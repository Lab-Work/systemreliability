function D = compD(epicenter, networkStruct)

%Raphael Stern, May 14, 2015
%Computes D, the distance from the epicenter to the midpoint of each edge


D = sqrt((networkStruct.edgeMdPts(:,1)-epicenter(1)).^2+...
    (networkStruct.edgeMdPts(:,2)-epicenter(2)).^2);


end