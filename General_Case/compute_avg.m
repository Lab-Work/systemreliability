function [avg_dijkstra, avg_ML, cov_dijkstra, cov_ML]=...
    compute_avg(num_points, dijkstra_pred, ML_pred)
%Raphael Stern, February 5, 2014
%This function computes the average and COV for both ML and Dijkstra

avg_dijkstra=zeros(num_points, 1);
avg_dijkstra(1)=dijkstra_pred(1);
avg_ML=zeros(num_points, 1);
avg_ML(1)=ML_pred(1);

cov_dijkstra=zeros(num_points, 1);
cov_dijkstra(1)=0;
cov_ML=zeros(num_points, 1);
cov_ML(1)=0;



for j=2:num_points
    avg_dijkstra(j)=avg_dijkstra(j-1)+dijkstra_pred(j);
    avg_ML(j)=avg_ML(j-1)+ML_pred(j);
    cov_dijkstra(j)=((1/sqrt(j))*(std(dijkstra_pred(1:j))))/(avg_dijkstra(j)/j);
    cov_ML(j)=((1/sqrt(j))*(std(ML_pred(1:j))))/(avg_ML(j)/j);
end

avg_dijkstra=avg_dijkstra./(1:num_points)';
avg_ML=avg_ML./(1:num_points)';

end
