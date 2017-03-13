% (C) Raphael Stern, March 28, 2016
% Function to generate random network data from randomly selected
% earthquakes

% NOTE: numPoints must be a multiple of 10

function earthquakeData = genRandEarthquakeData(networkStruct, numPoints)

epicenter = [1.2, 4.4];
SF = 133.4; %scaling factor, specific to map, calibrated for CA pipeline example
H = 19;

pointsPerEQ = numPoints/10;
earthquakeData = [];

for earthquakeNum = 1:10
    Mj = 2*rand()+5;
    xrand = normrnd(0, 0.01); %random perturbations around epicenter
    yrand = normrnd(0, 0.01);
    epicenter = [epicenter(1)+xrand, epicenter(2)+yrand];

    distToEpicenter = compD(epicenter, networkStruct);
        scaledDistToEpicenter = SF.*distToEpicenter;
        PGV = attenuation(Mj, H, scaledDistToEpicenter);
        D = zeros(networkStruct.numEdges);
        for i=1:networkStruct.numEdges
            for j = 1:networkStruct.numEdges
                D(i,j) = sqrt((networkStruct.edgeCoords(i,1)-...
                    networkStruct.edgeCoords(j,1)).^2+...
                    (networkStruct.edgeCoords(i,2)-...
                    networkStruct.edgeCoords(j,2)).^2);
            end
        end
        
        scaledD = D.*SF;
        lengths = networkStruct.edgeLength.*SF;
        scaledLengths = lengths.*SF;
        pf = getPf(PGV, scaledLengths, 0.0001, 2.5);
        mu=zeros(networkStruct.numEdges, 1);
        sig_eta = 0.37;
        sig_e = 0.51;
        % %compute correlation netween e
        rho_ee = exp(-0.509*scaledD.^0.5);
        rho_YY = sig_eta^2/(sig_eta^2+sig_e^2) + rho_ee.*(sig_e^2/(sig_e^2+sig_eta^2));
        sigma = rho_YY;
        earthquakeData = [earthquakeData, build_test_set_with_connectivity(mu', sigma, pointsPerEQ, pf, networkStruct)];
end