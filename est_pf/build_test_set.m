function comp_status=build_test_set(mu, sigma, num_points, pf)
%Raphael Stern, February 5, 2014
%This function builds a test set based on the individual componenet failure
%probability


%Build the whole space to test
%Generate a random variable for each component
comp_rnd=mvnrnd(mu, sigma, num_points)';
%generate a threshold based on the failure probability
threshold=norminv(pf, 0, 1);
%comp_status=comp_rnd>threshold;

%to allow for pf to be a vector of individual component failure
%probabilities
comp_status = zeros(size(comp_rnd));
for i = 1:num_points
    comp_status(:,i) = comp_rnd(:,i)>threshold;
end