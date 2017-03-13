function modified_networkStruct = modify_network(networkStruct, network_state)

%Raphael Stern, Modified January 23, 2015
%This function takes in a network and a node to be removed from the network
% and removes that node from the network by setting cost to traverse each
% edge to and from that link to a prohibatively high value. This function
% then returns the modified network


modified_networkStruct=networkStruct;
edges = networkStruct.edges;

for i=1:length(network_state)%-1
    if network_state(i)==0
        modified_networkStruct.adj(edges(i,1), edges(i,2))=0;
        modified_networkStruct.adj(edges(i,2), edges(i,1))=0;
    end
end

end