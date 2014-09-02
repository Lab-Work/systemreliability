function comp_status=build_test_set(mu, sigma, num_points, pf)
%Raphael Stern, February 5, 2014
%This function builds a test set based on the individual componenet failure
%probability
%
%This function takes the following imputs:
%mu -- the mean threshold
%sigma -- standard deviation of component failure
%num_points -- number of test points
%pf -- the component failure probability


%Build the whole space to test
comp_rnd=mvnrnd(mu, sigma, num_points)';
threshold=norminv(pf, 0, 1);
%comp_status=comp_rnd>threshold;

%to allow for pf to be a vector of individual component failure
%probabilities
comp_status = zeros(size(comp_rnd));
for i = 1:num_points
    comp_status(:,i) = comp_rnd(:,i)>threshold;
end