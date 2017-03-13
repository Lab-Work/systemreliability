%Raphael Stern, Feb 11, 2014
%This is a segmented version of the function whcih existed before to predic
%estimate network pf based on both the logistic regression and the dfs method using a
%set of damaged test networks.

clear all
close all

tic
load ../model_building/fitted_model_logit.mat
num_points=1000; %number of points to test on
epicenter = [1.2, 4.4]; %location of epicenter on CA map
SF = 133.4; %scaling factor, specific to map. 1 unit on map = 133.4km, 
%can change depending on specifc map you are using. make sure to 
%change in model building code as well
H = 19;
Mj = 6.5; %earthquake magnitude

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

%note that every distance is scaled by the scaling factor such that units
%match
scaledD = D.*SF;
lengths = networkStruct.edgeLength.*SF;
scaledLengths = lengths.*SF;
pf = getPf(PGV, scaledLengths, 0.0001, 2.5);
%Using correlated edge failures
network_size=length(network);
mu=zeros(networkStruct.numEdges, 1);

sig_eta = 0.37;
sig_e = 0.51;

%compute correlation netween e
rho_ee = exp(-0.509*scaledD.^0.5);
rho_YY = sig_eta^2/(sig_eta^2+sig_e^2) + rho_ee.*(sig_e^2/(sig_e^2+sig_eta^2));
sigma = rho_YY;


link_status=build_test_set(mu, sigma, num_points, pf);


[ml_pred, dfs_pred, ml_time, dfs_time]= ...
    det_network_status_logit(num_points, link_status, B, networkStruct);



disp('The cumulative time to complete all calculations using DFS is: ')
dfs_time
disp('The cumulative time to complete all calculations using the ML model is: ')
ml_time

[avg_dfs, avg_ml, cov_dfs, cov_ml]=...
    compute_avg(num_points, dfs_pred, ml_pred);

bias=abs(avg_ml(end)-avg_dfs(end));

disp(strcat('The bias is: ', num2str(bias)))

C = confusionmat(dfs_pred, ml_pred);
disp('The confusion matrix is:')
disp(C)

errorPercent = abs(avg_ml(end)-avg_dfs(end))/avg_dfs(end)*100;

disp(strcat('Percent error:', num2str(errorPercent), '%'))

FNset = link_status(:,dfs_pred==1 & ml_pred==0);
FPset = link_status(:,dfs_pred==0 & ml_pred==1);

precision = C(2,2)/(C(2,2)+C(1,2));
recall = C(2,2)/(C(2,2)+C(2,1));
accuracy = (C(1,1)+C(2,2))/(sum(sum(C)));
trueNeg = C(1,1)/(C(1,1)+C(1,2));

negAccuracy = trueNeg;
posAccuracy = recall;

disp(strcat('Precision: ', num2str(100*precision), '%'))
disp(strcat('Positive class accuracy: ', num2str(100*recall), '%'))
disp(strcat('Negative class accuracy: ', num2str(100*trueNeg), '%'))
disp(strcat('Accuracy: ', num2str(100*accuracy), '%'))


set(0, 'DefaultAxesFontSize', 14)

figure
hold on
plot(1:num_points, avg_ml, 'b-')
plot(1:num_points, avg_dfs, 'r-')
plot(1:num_points, (avg_ml+cov_ml), 'b:', 1:num_points, (avg_ml-cov_ml), 'b:')
plot(1:num_points, (avg_dfs+cov_dfs), 'r:', 1:num_points, (avg_dfs-cov_dfs), 'r:')
legend('Machine-learning based estimate', 'Traditional shortest path estimate')
xlabel('Number of MCS')
ylabel('Estimated network failure probability')
title(sprintf('MCS for estimate of network failure probability, M_j = %0.1f', Mj))
axis([0, num_points, 0, 1])
