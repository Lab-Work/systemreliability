function [ML_pred, dfs_pred, ML_time, dfs_time]=det_network_status_logit(...
    num_points, comp_status, fitted_model, networkStruct)
    

    %Raphael Stern, March 30, 2015
    %This function takes in the number of points, and a test set, and a model,
    %a a network, and retunrs 

    dfs_pred=zeros(num_points, 1);
    ML_pred=zeros(num_points, 1);
    

    %Go through a for loop, and determine network status using both dfs
    %and ML model
    
    
    tic
    ML_probs = mnrval(fitted_model, comp_status');
    ML_pred = ML_probs(:,2)>0.5; %1 => failed
    ML_time = toc;
 
    
    dfs_time = 0;
    for i=1:num_points
        if mod(i, 10000) == 0
            disp(num2str(i))
        end
        test_point=comp_status(:, i);
        mod_net=modify_network(networkStruct, test_point);

        tic
        dfs_pred(i)=is_connected(mod_net, 1, networkStruct.networkSize); % 1 => failed
        dfs_time=dfs_time+toc;
    end
    
    dfs_pred = logical(dfs_pred);
    
end