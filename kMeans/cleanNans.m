function cf = cleanNans(f)
    l = length(f);
    cf = zeros(0,size(f,2));
    j = 0;
    for i=1:l
        
        if sum(isnan(f(i,:))) == 0 && sum(isinf(f(i,:))) == 0 && isreal(f(i,:)) == 1
            j = j+1;
            cf(j,:) = f(i,:);
        end
    end
end