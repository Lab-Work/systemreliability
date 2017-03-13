function modified_networkStruct = modify_network(networkStruct, network_state)

%Raphael Stern, Modified January 23, 2015
%This function takes in a network and a node to be removed from the network
% and removes that node from the network by setting cost to traverse each
% edge to and from that link to a prohibatively high value. This function
% then returns the modified network


%Need to modify this so that it takes in the network state (a column of the
%state of each component) and returns the modified network corresponding to
%that network state...

%edges is a n_edges x 2 vector with the first entry being the first
%endpoint, and the second being the second end point.

modified_networkStruct=networkStruct;
edges = networkStruct.edges;

for i=1:length(network_state)%-1
    if network_state(i)==0
        modified_networkStruct.adj(edges(i,1), edges(i,2))=0;
        modified_networkStruct.adj(edges(i,2), edges(i,1))=0;
    end
end

end