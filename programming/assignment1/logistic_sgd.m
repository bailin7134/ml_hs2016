function [ theta ,obj ] = logistic_sgd( data, labels )
%	data=xtrain;
%	labels=single(ytrain > 0);
	N = size(data,2); % number of training samples
	M = size(data,1); % number of value in each sample
	theta = zeros(M,1);
	hypo = zeros(M,1);

	iter_nr = 2000;
	alpha = 0.01;

	obj = zeros(iter_nr,1);
	obj1 = zeros(iter_nr,1);
	obj2 = zeros(iter_nr,1);

% test
%	diff_j_test = zeros(M,1);

% the function g(theta_T*x)=1/(1+exp(theta_T*x))
% the hypothesis function is
% h_theta(x)=1/(1+theta_T*x)

% update theta = theta - alpha*diff(J(theta))

	
	figure(10);
	for p = 1:1:1
	alpha = alpha *50;
%	for k = 1:iter_nr
%		pick=floor(N*rand(1)) + 1;
%		diff_J = (sigmoid(theta'*data(:,pick))-labels(pick));
%		theta=theta-alpha*diff_J*data(:,pick);
%
%		obj(k) = obj_func(theta, data, labels);
%	end
	end
	%disp(obj);
	plot(1:1:iter_nr, obj, 'Color', [(0.7+0.1/p)^2 1-(0.1*p) 0.5/p^2]);
	end

end


function [ g ] = sigmoid(z)
	g = 1.0 ./ (1.0+exp(-z));
end

function [ J ] = obj_func(theta, X, y)
	% Computer Likelihood Function and Gradient
	M = length(y); % training examples
	hx = sigmoid(theta'*X);
	J = (1./M)*sum(-y.*log(hx)-(1.0-y).*log(1.0-hx));
	%grad = (1./M) .* X' * (y-hx);
end

