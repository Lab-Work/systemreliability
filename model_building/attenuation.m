%Raphael Stern
%February 4, 2015
%This code impiments the attenuation law descrinbed in Lim, Song, 2011.


% INPUTS
%H - depth of earthquake, take to be 10km
%Mj - the Japanese scale (not the normal scale) earthquake intensity
%D - distance vector for each point to epicenter in km

%OUTPUT
%PGV - units of cm/s

function PGV = attenuation(Mj, H, D)

logPGV = 0.725*Mj + 0.00318*H - 1.918.*log10(D+0.334*exp(0.653*Mj))-0.519;
% Convert lnPGA to PGA (units of g)
PGV=10.^logPGV;

end