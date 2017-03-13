Ready
(C) Raphael Stern, 2017

There are two folders in this directory:

-model_building: this contains code to construct a surrogate model of network connectivity
-est_pf: this contains code used to simulate network failure and test the constructed surrogate model

Note: the implementation of depth first search is borrowed from David Gleich and can be downloaded at: https://www.mathworks.com/matlabcentral/fileexchange/24134-gaimc---graph-algorithms-in-matlab-code/content/gaimc/dfs.m. Alternately, your own implementation can be used.

To construct a SVM or logistic regression model, run the ‘build_fitted_model’ script in the ‘model_building’ directory. This will save both an SVM and logistic regression surrogate model.

To test this model, use the ‘est_pf_SVM’ and ‘est_pf_logit’ scripts in the ‘est_pf’ directory for the SVM and logistic regression estimate, respectively.

A complete description of all functions is provided below:

model_bilding:
-attenuation.m — attenuation law in Lim, Song, 2011
-build_test_set_with_connectivity.m — constructs a data set of earthquake failures with the given component failure probability and covariance matrix
-compD.m — computes the distance between two edges
-genRandEarthquakeData.m — uses the epicenter and magnitude hard coded in the script (can change) to generate data from earthquakes in that vicinity with differing magnitudes to generate training data
-getPf.m — determines component failure probabilities based on the fragility model
-is_connected.m — determines whether source and terminal node are connected under a given failure case (network state)
-modify_network.m — constructs a new network structure with the failed edges removed
-scaledBlankNetwork.mat — network topology of the California Gas Distribution network

est_pf:
-attenuation.m — attenuation law in Lim, Song, 2011
-build_test_set.m — builds test data according to edge failure probabilities and correlation
-compD.m — computes the distance between two edges
-compute_average.m — computes the running average of the MCS outcomes
-det_network_status_logit.m — determines the network status (failed or not failed) using the logistic surrogate model
-det_network_status_SVM.m — determines the network status (failed or not failed) using the SVM surrogate model
-est_pf_logit.m — main script to estimate the network failure probability using logistic surrogate model
-est_pf_SVM.m — main script to estimate the network failure probability using SVM surrogate model
-getPf.m — determines component failure probabilities based on the fragility model
-is_connected.m — determines whether source and terminal node are connected under a given failure case (network state)
-modify_network.m — constructs a new network structure with the failed edges removed

