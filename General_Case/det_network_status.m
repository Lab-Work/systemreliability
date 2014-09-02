function [ML_pred, dijkstra_pred, ML_time, dijkstra_time]=det_network_status(...
    num_points, comp_status, fitted_model, network, network_size)
    

    %Raphael Stern, February 5, 2013
    %This function takes in the number of points, and a test set, and a model,
    %a a network, and retunrs 

    dijkstra_pred=zeros(num_points, 1);
    ML_pred=zeros(num_points, 1);
    

    %Go through a for loop, and determine network status using both dijkstra
    %and ML model
    ML_time=0;
    dijkstra_time=0;

    for i=1:num_points
        test_point=comp_status(:, i);

        mod_net=modify_network(network, test_point);

        tic
        dijkstra_pred(i)=is_connected(mod_net, 1, network_size); % 1 => failed
        dijkstra_time=dijkstra_time+toc;

        tic
        [ML_pred(i), ~]=adaboost('apply', test_point', fitted_model, 200); % 1 => failed
        ML_time=ML_time+toc;

    end
    ML_pred=(ML_pred+1)/2; %1 => failed
end