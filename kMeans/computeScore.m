function score = computeScore(C_matrix, test_matrix, S)
	C_size = size(C_matrix);
	num_clusters = C_size(1);
    vec_len = C_size(2);
    sigma = zeros(vec_len,vec_len);
    for i=1:vec_len
        sigma(i,i) = (1/S(i));
    end

	for i = 1:num_clusters
	    this_center = C_matrix(i,:);
	    for j = 1:size(test_matrix,1);
            this_test = test_matrix(j,:);
            dist_matrix(i,j) = (this_test - this_center)*sigma*(this_test-this_center)';
	    end
    end

	%s = sort(min(dist_matrix,[],1));
    s = min(dist_matrix,[],1);
    score = s;
end
