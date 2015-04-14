function classLabels = execute1(cluster_mean, S, s, e, p)
    %p = '../testFeatures/'
	for i=s:e
    	testCell{i} = load(strcat(p, 'feat_matrix_', sprintf('%03d',i),'.mat'));
    end

    correct = 0;
    win = int32((e-s+1)/10);
    for i=s:e
        fprintf('Testing for author with id: %d\n', i);
        test_data = testCell{i}.(strcat('feat_matrix_',sprintf('%03d',i)));
        test_data = cleanNans(test_data);
        scoreVector = zeros(0,size(test_data,1));
        for j=s:e
            this_cluster_mean = cluster_mean{j}; 
            %this_cluster_mean = this_cluster_mean(1:50,:);
            scoreVector(j-s+1, :) = computeScore(this_cluster_mean, test_data, S{j});       
        end
        [dummy labels] = min(scoreVector);
        a = unique(labels);
        out = [a,histc(labels,a)];
        out = sortrows(out, -2);
        out = out(1, 1:(win+2));
        if(sum(out == (i-s+1)) > 0)
            disp('Correctly assigned');
            correct = correct + 1;
        else
            disp('Incorrectly assigned');   
        end
        classLabels{i-s+1} = labels;
    end
    accuracy = correct/(e-s+1);
    fprintf('The accuracy is: %f\n', accuracy);
end