%Raphael Stern
%February 4, 2015

%This code takes in the length of the segments, the PGV, k, and gamma and
%returns the probability of a failure

%INPUTS
%PGV - peak ground velocity
%l - length of each pipe link
%k - a parameter
%gamma - another parameter

%OUTPUT
%Pf - probability of component failure

function Pf = getPf(PGV, l, k, gamma)

nu_m = k.*(PGV).^gamma;
Pf = 1 - exp(-nu_m.*l);

end

