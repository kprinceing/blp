function f = mktsh(mval, expmu)
% This function computes the market share for each product

% Written by Aviv Nevo, May 1998.
% calls ind_sh for monte caro simulation of individual share. sum it up and
% devide the number of simulated individuals to get average market share
% for each brand in each market.
global ns 
f = sum((ind_sh(mval,expmu))')/ns;
f = f';