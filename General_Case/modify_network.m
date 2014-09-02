function modified_network = modify_network(network, network_state)

%Raphael Stern, June 7, 2013
%This function takes in a network and a node to be removed from the network
% and removes that node from the network by setting cost to traverse each
% edge to and from that link to a prohibatively high value. This function
% then returns the modified network

modified_network=network;
for i=1:length(network)
    if network_state(i)==0
        modified_network(:, i)=10000;
        modified_network(i, :)=10000;
    end
end


end