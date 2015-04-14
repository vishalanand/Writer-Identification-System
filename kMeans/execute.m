function [] = execute(kVal, s, e, p1, p2)

    for i=s:e
    	trainCell{i} = load(strcat(p1, 'feat_matrix_', sprintf('%03d',i),'.mat'));
    	testCell{i} = load(strcat(p2, 'feat_matrix_', sprintf('%03d',i),'.mat'));
    end

    %% Compute Cluster Means
    for i=s:e
        train_data = trainCell{i}.(strcat('feat_matrix_',sprintf('%03d',i)));
        train_data = cleanNans(train_data);
        [idx cluster_mean{i}] = kmeans(train_data, kVal);
        disp(i);
        S{i} = var(train_data,0,1);
    end

    S1.cluster_mean = cluster_mean;
    S2.S = S;
    save('../cluster_mean.mat', '-struct', 'S1')
    save('../S.mat', '-struct', 'S2')
    clear('S1');
    clear('S2');

    %%
    for i=s:e
        test_data = testCell{i}.(strcat('feat_matrix_',sprintf('%03d',i)));
        test_data = cleanNans(test_data);
        scoreVector = zeros(0,size(test_data,1));
        for j=s:e
            this_cluster_mean = cluster_mean{j}; 
            %this_cluster_mean = this_cluster_mean(1:50,:);
            scoreVector(j-s+1, :) = computeScore(this_cluster_mean, test_data, S{j});       
        end
        [dummy index] = min(scoreVector);
        class_index = mode(index);
        classification(i-s+1, 1:3) = [i (class_index+s-1) i==(class_index+s-1)]
    end

end