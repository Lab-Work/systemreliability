function pf = set_pf(coords, pf_max, pf_min, epicenter)
%Raphael Stern, July 29, 2014
%This function takes in the coordinates of each point in the network, the
%maximum pf, minimum pf and the epicenter of the event (point of highest
%pf).

d = sqrt((epicenter(1)-coords(:,1)).^2+(epicenter(2)-coords(:,2)).^2);
d_max = max(d);

pf = (pf_min-pf_max)/d_max*d+pf_max;
