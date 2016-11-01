function [ theta ] = logistic_newton( data, labels )
	
	N = size(data,2); % number of training samples
	M = size(data,1); % number of value in each sample
	theta = zeros(M,1);
	
	iterationNo = 10;
	J = zeros(iterationNo,1);
	
	for k = 1:iterationNo
		% hypothesis function
		% h = 1/(1+exp(g))
		% g = theta*data
		h = 1.0./(1.0+exp(transpose(theta)*data));

		% gradient descent
		gd = (1/N).*(h-labels)*data';
		hessian = (1/N).*data*diag(h)*diag(1-h)*data';
	
		% cost function
		J(k) = (1/N)*sum(-labels.*log(h)-(1-labels).*log(1-h));

		theta = theta-hessian\gd';
	end

% theta = [ randn( size(data,2), 1 ); 0 ];

end
