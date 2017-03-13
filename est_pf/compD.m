function D = compD(epicenter, networkStruct)

%Raphael Stern, May 14, 2015
%Computes D, the distance from the epicenter to the midpoint of each edge
%SF is the scaling factor, set to 86.4 for this example.

%SF =86.4;

D = sqrt((networkStruct.edgeMdPts(:,1)-epicenter(1)).^2+...
    (networkStruct.edgeMdPts(:,2)-epicenter(2)).^2);

%D = D.*SF;

end