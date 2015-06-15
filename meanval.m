function f = meanval(theta2)
	% This function computes the mean utility level

	% Written by Aviv Nevo, May 1998.
	%New comments by Eric Rasmusen, December 31, 2005

global theti thetj silent x2 s_jt
load mvalold

if max(abs(theta2-oldt2)) < 0.01;
	tol = 1e-9;
	flag = 0;
else
  	tol = 1e-6;
	flag = 1;
end

theta2w = full(sparse(theti,thetj,theta2));
    % expmu : no-linear part of the utility. 
expmu = exp(mufunc(x2,theta2w));
norm = 1;
avgnorm = 1;

i = 0;
while norm > tol*10^(flag*floor(i/50)) & avgnorm > 1e-3*tol*10^(flag*floor(i/50))
   % the following two lines are equivalent; however, the latter saves on the number of exponents
   % computed at therefore speeds up the computation by 5-10%
   %  mval = mvalold + log(s_jt) - log(mktsh(mvalold,expmu));
   
        % mval should be the mean utility of a product namely the linear
        % part of the utility.
        % This line below implements the fixed point iteration. 
        % log of mval is the mean utility
		mval = mvalold.*s_jt./mktsh(mvalold,expmu); 

      t = abs(mval-mvalold);
		norm = max(t);
      avgnorm = mean(t);
  		mvalold = mval;
      i = i + 1;
end
disp(['# of iterations for delta convergence:  ' num2str(i)])
	%what is converging here is norm and avgnorm, as indicated by the "while" command

if flag == 1 & max(isnan(mval)) < 1;
   mvalold = mval;
   oldt2 = theta2;
   save mvalold mvalold oldt2
end   
f = log(mval);
