function [f,df] = gmmobjg(theta2)
	% This function computes the GMM objective function. f is the objective, and df is the gradient.

	% Written by Aviv Nevo, May 1998.
	% Modified by Bronwyn Hall, April 2005, to add gradient.
	%Eric rasmusen, Dec. 31, 2005,  modified in style. 

global invA theta1 theti thetj x1 IV
    
    % This line below calls the meanval function.
    % It calculates the mean value delta for a fixed theta2
    

delta = meanval(theta2);

% the following deals with cases were the min algorithm drifts into region where %the objective is not defined
if max(isnan(delta)) == 1
	f = 1e+10
else
        
    % temp1 and temp2 are used to get theta1 in a IV regression. 
    temp1 = x1'*IV;
    temp2 = delta'*IV;
    theta1 = inv(temp1*invA*temp1')*temp1*invA*temp2';
    clear temp1 temp2
    % gmmresid : gmm residual 
    gmmresid = delta - x1*theta1;
    % f is the gmm condition. 
	temp1 = gmmresid'*IV;
	f1 = temp1*invA*temp1';
    f = f1;
    clear temp1
    % not sure what is this condition about. 
    if nargout>1
        load mvalold
        temp = jacob(mvalold,theta2)';
        df = 2*temp*IV*invA*IV'*gmmresid 
    end
end

disp(['GMM objective:  ' num2str(f1)])

 save gmmresid; 
	%gmmresid.mat is needed later by the subroutine var_cov.m





