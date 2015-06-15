function f = mufunc(x2,theta2w)
% This function computes the non-linear part of the utility (mu_ijt in the %%Guide)

% Written by Aviv Nevo, May 1998.
 

global ns vfull dfull
[n k] = size(x2);
% n = 2256
% k = 4
% j =4 
j = size(theta2w,2)-1;
% mu : initiates the matrix for mu. 
mu = zeros(n,ns);
for i = 1:ns
        % vfull is 2256*80
        % v_i takes a step size fo 20.
        % vi dim : 2256*4
        % di_dim : 2256*4 
    	v_i = vfull(:,i:ns:k*ns);
        d_i = dfull(:,i:ns:j*ns);
 		mu(:,i) = (x2.*v_i*theta2w(:,1))+x2.*(d_i*theta2w(:,2:j+1)')*ones(k,1);
end
f = mu;
 