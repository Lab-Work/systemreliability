function [avg_dfs, avg_ML, cov_dfs, cov_ML]=...
    compute_avg(num_points, dfs_pred, ML_pred)
%Raphael Stern, February 5, 2014
%This function computes the average and COV for both ML and dfs

% avg_dfs=zeros(num_points, 1);
% avg_dfs(1)=dfs_pred(1);
% avg_ML=zeros(num_points, 1);
% avg_ML(1)=ML_pred(1);
% 
% cov_dfs=zeros(num_points, 1);
% cov_dfs(1)=0;
% cov_ML=zeros(num_points, 1);
% cov_ML(1)=0;




MLsum = cumsum(ML_pred);
DFSsum = cumsum(dfs_pred);

avg_ML = MLsum./(1:num_points)';
avg_dfs = DFSsum./(1:num_points)';

MLSqSum = cumsum(ML_pred.^2);
DFSSqSum = cumsum(dfs_pred.^2);

S_ML = sqrt((MLSqSum - (MLsum.^2)./...
    ((1:num_points)'))./((0:(num_points-1))'));

S_dfs = sqrt((DFSSqSum - (DFSsum.^2)./...
    ((1:num_points)'))./((0:(num_points-1))'));

cov_ML = S_ML./(sqrt((1:num_points)').*avg_ML);
cov_dfs = S_dfs./(sqrt((1:num_points)').*avg_dfs);




% for j=2:num_points
%     avg_dfs(j)=((j-1)*avg_dfs(j-1)+dfs_pred(j))/j;
%     avg_ML(j)=((j-1)*avg_ML(j-1)+ML_pred(j))/j;
%     cov_dfs(j)=((1/sqrt(j))*(std(dfs_pred(1:j))))/(avg_dfs(j));
%     cov_ML(j)=((1/sqrt(j))*(std(ML_pred(1:j))))/(avg_ML(j));
% end


end
