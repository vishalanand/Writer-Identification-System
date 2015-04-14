function [posteriors] = gmmTest(models, X, discarded)
    n = size(models, 2);
    cnt = size(X, 1);
    posteriors = zeros(cnt, n);

    for i = 1:n
        if(sum(discarded == i) > 0)
            continue;
        end
        model = models{i};
        %temp = cdf(model, X);
        temp = zeros(cnt, 1);
        P = posterior(model,X);
        comProp = model.PComponents;
        for k = 1:cnt
            temp(k, 1) = sum(comProp .* P(k, :));
        end
        posteriors(:, i) = temp;
        %{
        if i == 1
            classes(1:cnt, :) = 1;
            posteriors = temp;
        else
            for j = 1:cnt
                if(posteriors(j, 1) < temp(j, 1))
                    posteriors(j, 1) = temp(j, 1);
                    classes(j, 1) = i;
                end
            end 
        end
        %}
    end
    posteriors(isnan(posteriors)) = 1; 
    
    for i = 1:cnt
        for j = 1:n
            posteriors(i, j) = log(posteriors(i, j));
        end
    end
    
    posteriors = sum(posteriors);
end