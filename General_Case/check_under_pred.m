function under_pred_cases=check_under_pred(comp_status, ML_pred, dijkstra_pred, num_points)
%Raphael Stern, January 26, 2014
%This function checks the cases where the ML model under predict failure

c=1; %A curser
under_pred_index=[1]; %holds the index values of the over-predicted points

for i=1:num_points
    if ML_pred(i)==0
        if dijkstra_pred(i)==1
            under_pred_index(c)=i;
            c=c+1;
        end
    end
end

under_pred_cases=comp_status(:,under_pred_index);


