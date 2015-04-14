function model = gmmTrain(X, k)
    model = gmdistribution.fit(X, k, 'CovType', 'diagonal', 'Regularize', 0.001);
end
