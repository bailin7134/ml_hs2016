function [ theta ] = logistic_sgd_Lin_Bai( data, labels )
%	data=xtrain;
%	labels=single(ytrain > 0);
	N = size(data,2); % number of training samples
	M = size(data,1); % number of value in each sample
	theta = zeros(M,1);
	theta_new = zeros(M,1);
	diff_J = zeros(M,1);

	alpha = 0.05;

% the function g(theta_T*x)=1/(1+exp(theta_T*x))
% the hypothesis function is
% h_theta(x)=1/(1+theta_T*x)

% update theta = theta - alpha*diff(J(theta))

	for k = 1:N
%		for j = 1:M
%			diff_J = (1/(1+exp(transpose(theta)*data(:,k)))-labels(k)*data(j,k);
%			theta_new(j)=theta(j)-alpha*diff_J;
%		end
		diff_J = (1/(1+exp(transpose(theta)*data(:,k)))-labels(k)).*data(:,k);
		theta_new=theta-alpha*diff_J;
		theta = theta_new;
	end

% theta = [ randn( size(data,2), 1 ); 0 ];

end

