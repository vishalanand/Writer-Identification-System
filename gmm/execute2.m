function accuracy = execute2(models, discarded, s, e, p)
   
    %p = '../testFeatures1/';
    n = size(models, 2);
    correct = zeros(1, n);
    next = 0;
    tot = n-size(discarded, 2);
    win = int32(tot/10) + 2;
    for sample = [s:e]
        fprintf('Testing for author with id: %d\n', sample);
        next = next + 1;
        if(sum(discarded == next) > 0)
            continue;
        end
        fName = strcat('feat_matrix_', sprintf('%03d',sample));
        fPath = strcat(p, fName, '.mat');
        X = load(fPath);
        W = X.(fName);
        W(isinf(W)) = NaN;
        posteriors = gmmTest(models, W, discarded);
        
        %{
        label = mode(classes);
        fprintf('%d %d\n', next, label);
        if label == next
            correct = correct + 1;
        end
        
        %}
        [ign, labels] = sort(posteriors, 'descend');
        %disp(labels);
        
        found = false;
        foundAtExp = false;
        for i = 1:n
            if((i == win) && (found == true))
                foundAtExp = true;
            end
            if ((found == true) || (next == labels(i)))
                found = true;
                correct(i) = correct(i) + 1;
            end
        end
        if(foundAtExp == true)
            fprintf('The label assigned: %d\n', sample);
        else
            fprintf('The label assigned: %d\n', labels(1));
        end
    end

    
    accuracy = correct/tot;
    S1.accuracy = accuracy;
    save('../accuracy.mat', '-struct', 'S1')
    clear('S1');
    fprintf('The accuracy is: %f\n', accuracy(int32(tot/10) + 2));
end