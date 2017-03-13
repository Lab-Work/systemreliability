function y = is_connected(modified_networkStruct, start_node, end_node)

%Raphael Stern, June 7, 2013
%This function takes in a modified network (in the form of a matrix), a
%start node, and a end node, and returns y=1 if the two nodes are connected
%throught the network, and returns y=0 of the two nodes are not connected.
%The network should be initialized such that the (i,j) entry holds the cost
%to travel from node i to node j.

%[~, cost]=dijkstra(modified_network, start_node, end_node);
[d, ~, ~, ~] = dfs(modified_networkStruct.adj, start_node);

if d(end_node) == -1
    y=1; % 1 means the network has failed
else
    y=0; % 0 means the network is connected
end
end
