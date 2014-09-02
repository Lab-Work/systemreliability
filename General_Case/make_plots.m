function make_plots(num_points, avg_ML, avg_dijkstra, ...
    cov_ML, cov_dijkstra, ML_pred, dijkstra_pred, comp_status, network_size)

%Raphael Stern, February 5, 2014
%This function plots everything

set(0, 'DefaultAxesFontSize', 14)

figure
hold on
plot(1:num_points, avg_ML, 'b-')
plot(1:num_points, avg_dijkstra, 'r-')
plot(1:num_points, (avg_ML+cov_ML), 'b:', 1:num_points, (avg_ML-cov_ML), 'b:')
plot(1:num_points, (avg_dijkstra+cov_dijkstra), 'r:', 1:num_points, (avg_dijkstra-cov_dijkstra), 'r:')
legend('Machine-learning based estimate', 'Traditional shortest path estimate')
xlabel('Number of MCS')
ylabel('Estimated network failure probability, P_f')
title('MCS for estimate of network failure probability, p_f=0.1')
axis([0, 500, 0, 1])


num_comp_fail=network_size-sum(comp_status, 1);
figure
hist(num_comp_fail)

title('Distribution of component failures in test set')
xlabel('Number of component failures')
ylabel('Density of points within test set')

%Plot a hist with network_size bins that shows whether the node failed or
%didn't fail in the sample.
cumulative_comp_status=num_points-sum(comp_status, 2);
figure
bar(cumulative_comp_status)
title('Component faiure frequency in test data')
xlabel('Component index')
ylabel('Number of times component failed')


%Plot a hist looking at which nodes failed when there was an
%over-prediction
under_pred_cases=check_under_pred(comp_status, ML_pred, dijkstra_pred, num_points);
cumulative_under_pred_comp_status=size(under_pred_cases, 2)-sum(under_pred_cases, 2);
figure
bar(cumulative_under_pred_comp_status)
title('Frequency of component failure in actual network failures that were not predicted')
xlabel('Component index')
ylabel('Number of times this component failed')


end