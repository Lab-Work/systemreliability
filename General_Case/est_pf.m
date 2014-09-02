%Raphael Stern, Feb 11, 2014
%This is a segmented version of the function whcih existed before to predic
%estimate network pf based on both the ML and the Dijkstra method using a
%set of damaged test networks.

tic
load large_model.mat
num_points=500;
pf = set_pf(coords, 0.2, 0.01, [7, 4.5]);

network_size=length(network);
mu=zeros(network_size, 1);
comp_sigma=ones(network_size, 1);
sigma=diag(comp_sigma);

comp_status=build_test_set(mu, sigma, num_points, pf);
%comp_status=train_data(1:70, :);

[ML_pred, dijkstra_pred, ML_time, dijkstra_time]= ...
    det_network_status(num_points, comp_status, fitted_model, network, network_size);


disp('The cumulative time to complete all calculations using Dijkstra is: ')
dijkstra_time
disp('The cumulative time to complete all calculations using the ML model is: ')
ML_time

[avg_dijkstra, avg_ML, cov_dijkstra, cov_ML]=...
    compute_avg(num_points, dijkstra_pred, ML_pred);

make_plots(num_points, avg_ML, avg_dijkstra, ...
    cov_ML, cov_dijkstra, ML_pred, dijkstra_pred, comp_status, network_size)

bias=abs(avg_ML(end)-avg_dijkstra(end))