function [ML_pred, dfs_pred, ML_time, dfs_time]=det_network_status_SVM(...
    num_points, comp_status, fitted_model, networkStruct)
    
    %Raphael Stern, March 30, 2015
    %This function takes in the number of points, and a test set, and a model,
    %a a network, and retunrs 

    dfs_pred=zeros(num_points, 1);
    

    %Go through a for loop, and determine network status using both dfs
    %and ML model
    
    
    tic
    ML_pred = predict(fitted_model, comp_status');
    ML_time = toc;
    ML_pred = ML_pred-1;
    
    dfs_time = 0;
    for i=1:num_points
        test_point=comp_status(:, i);
        mod_net=modify_network(networkStruct, test_point);

        tic
        dfs_pred(i)=is_connected(mod_net, 1, networkStruct.networkSize); % 1 => failed
        dfs_time=dfs_time+toc;
    end

    
end