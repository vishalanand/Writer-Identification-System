In this project Artificial Intelligence (CS561), we have dealt with the task of writer recognition of online handwriting captured from a writing board. A set of features were extracted from this data which was used to train a text and language independent on-line writer identification system. We describe here two systems; firstly Gaussian Mixture Models (GMMs) which provide a powerful yet simple means of representing the distribution of the features extracted from the handwritten text. The second system is based on k-means clustering process. Different sets of features are described and metrics are evaluated in this report. The system is tested using text from a set of around 50 different writers. The GMM model provided us with better identification accuracy as compared to the k-means clustering approach for the same problem.

The readXML converts the data from data/original and data/part-original and creates testing_cells and training_cells respectively.
It may be noted that the testing_cells has good data and the training_cells has insufficient data.

Next, the extractFeatures is used to generate trainFeatures and trainFeatures1 (corresponding to feature-set-1 and feature-set-2) from the cells(it is suggested to use testing_cells since it has sufficient data-points for each of the authors) using 7/8 of teh cell data. The testFeatures and testFeatures1 are also generated using 1/8 part of the cell data.

GMM's execute1 then trains teh models and execute2 tests the models.
k-Means' execute1 trains and tests the data-points and execute2 tests the data-points on the k-Means generated apriori.
