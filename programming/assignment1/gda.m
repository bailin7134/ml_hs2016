function [phi, mu0, mu1, Sigma] = gda( data, labels )

	% size of data
	% M is the dimension of one sample
	% N is the number of samples
	[M,N] = size(data);
	all1 = ones(N,1);
	
	% phi, the propability of y=1
%	numYis1 = labels*all1;		%sum(labels==1);
%	numYis0 = (1-labels)*all1;	%sum(labels==-1);
	numYis0 = (1-labels)*all1/2;	%sum(labels==-1);
	numYis1 = (labels+1)*all1/2;	%sum(labels==1);
%	numYis1 = sum(labels==1);
%	numYis0 = sum(labels==-1);
	phi = (1/N)*numYis1;
	
	% mu, mathematics expectation when y=0 or 1
%	mu0 = (1-labels)*data'/numYis0;
%	mu1 = labels*data'/numYis1;
	mu0 = (1-labels)*data'/numYis0/2;
	mu1 = (labels+1)*data'/numYis1/2;
	mu0 = mu0';
	mu1 = mu1';
	
	% Sigma, the coveriance
	% subract mu0, for all elements when y=0
	x_sub_mu = data-mu0*(1-labels)/2-mu1*(labels+1)/2;
	Sigma = (1/M)*x_sub_mu*x_sub_mu';


%phi = 0.5;
%mu0 = rand(size(data,1),1);
%mu1 = rand(size(data,1),1);
%Sigma = eye(size(data,1));

end

