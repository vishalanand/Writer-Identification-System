function [models, discarded] = execute1(k, s, e, p1)
    
    %p1 = '../trainFeatures/';
    %p2 = '../testFeatures/';
    n = e-s+1;
    models = cell(1, n);
    next = 0;
    discarded = [];
    for sample = [s:e]
        next = next + 1;
        fprintf('Training model for author with id: %d', sample);
        try
            fName = strcat('feat_matrix_', sprintf('%03d',sample));
            fPath = strcat(p1, fName, '.mat');
            X = load(fPath);
            W = X.(fName);
            W(isinf(W)) = NaN;
            models{next} = gmmTrain(W, k);
            fprintf('Model trained for author with id: %d', sample);
        catch error
            discarded = [discarded next];
            disp('Continue...');
        end
    end
    
    S1.models = models;
    S2.discarded = discarded;
    save('../models.mat', '-struct', 'S1')
    save('../discarded.mat', '-struct', 'S2')
    clear('S1');
    clear('S2');
    
    %{
    %models = load('C:\Users\k.shyamal\Documents\4th Year\AI\models.mat');
    %models = models.models;
    correct = zeros(1, n);
    next = 1;
    
    for sample = [s:e]
        fName = strcat('feat_matrix_', sprintf('%03d',sample));
        fPath = strcat(p2, fName, '.mat');
        X = load(fPath);
        W = X.(fName);
        W(isinf(W)) = NaN;
        posteriors = gmmTest(models, W);
        
        %{
        label = mode(classes);
        fprintf('%d %d\n', next, label);
        if label == next
            correct = correct + 1;
        end
        
        %}
        [ign, labels] = sort(posteriors, 'descend');
        disp(labels);
        
        found = false;
        for i = 1:n
            if ((found == true) || (next == labels(i)))
                found = true;
                correct(i) = correct(i) + 1;
            end
        end
        
        next = next + 1;
    end

    accuracy = correct/n;
    S1.accuracy = accuracy;
    save('../accuracy.mat', '-struct', 'S1')
    clear('S1');
    fprintf('The accuracy is: %f', accuracy(7));
    %}
end