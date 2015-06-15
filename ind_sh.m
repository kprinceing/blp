function f = ind_sh(expmval,expmu)
% This function computes the "individual" probabilities of choosing each brand

% Written by Aviv Nevo, May 1998.

global ns cdindex cdid
    % eg: numerator of the logit share function. 
eg = expmu.*kron(ones(1,ns),expmval);
temp = cumsum(eg); 
sum1 = temp(cdindex,:);
sum2(2:size(sum1,1),:) = diff(sum1);

denom1 = 1./(1+sum2);
    % denom : denominator of the logit share function.
denom = denom1(cdid,:);
    % f brand share, each column is a simulation of individual. kept
    % constant. 
f = eg.*denom;